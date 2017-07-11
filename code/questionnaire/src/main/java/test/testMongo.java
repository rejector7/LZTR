package test;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.net.UnknownHostException;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCursor;
import com.mongodb.Mongo;
import com.mongodb.gridfs.GridFS;
import com.mongodb.gridfs.GridFSDBFile;
import com.mongodb.gridfs.GridFSInputFile;

public class testMongo {       
	    public static void main(String[] args) throws FileNotFoundException, UnknownHostException  
	    {  
	        /* 
	         * 1、创建数据库连接 
	         */  
	        Mongo client= new Mongo("127.0.0.1",27017);  
	        //取得数据库对象  
	        DB db=client.getDB("bookstore");  
	          
	        String collectionName="mongoCollectionTest";  
	        //创建数据库对象中GridFS集合  
	        GridFS gridFS= new GridFS(db,collectionName);         
	          
	        /* 
	         * 2、上传文件 
	         */  
	        //创建测试文件，mongo 默认存在该文件  
	        File file=new File("C:/Users/Lixuhui/Desktop/mongoDB.bmp");  
	        FileInputStream fileInputStream=new FileInputStream(file);  
	          
	        //创建gridFS文件数据流  
	        GridFSInputFile createFile=gridFS.createFile(fileInputStream);  
	          
	        //设置文件属性  
	        createFile.put("filename", "mongoDB.bmp");  
	        createFile.put("contentType", "application/bmp");  
	        createFile.save();  
	          
	          
	        /* 
	         * 3、根据id查询上传文件 
	         */  
	        GridFSDBFile findOne= gridFS.findOne(new BasicDBObject("_id",createFile.getId()));  
	        System.out.print("\t\n");
	        System.out.print(findOne);  
	        System.out.print("\t\n");
	          
	        /* 
	         * 4、查询所有文件列表 
	         * DBCursor 数据库游标 
	         */  
	        DBCursor fileList=gridFS.getFileList();  
	        while(fileList.hasNext())  
	        {  
	            System.out.print(fileList.next()); 
	            System.out.print("\t\n");
	        }  
	          
	        /* 
	         *5、 删除文件 
	         */  
	        //gridFS.remove(new  BasicDBObject("_id",createFile.getId()));  
	        client.close();  
	    } 
}