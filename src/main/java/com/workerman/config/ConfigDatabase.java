package com.workerman.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.mybatis.spring.boot.autoconfigure.SpringBootVFS;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@MapperScan(value="com.workerman.vo", sqlSessionFactoryRef="workermanSqlSessionFactory")
@EnableTransactionManagement
public class ConfigDatabase {

	@Bean(name = "workermanDataSource", destroyMethod = "close")	
	@ConfigurationProperties(prefix = "workerman.db")
	public DataSource dataSource() {
	    return DataSourceBuilder.create().build();
	}
	
	@Bean(name = "workermanSqlSessionFactory")
    @Primary
    public SqlSessionFactory workermanSqlSessionFactory(@Qualifier("workermanDataSource") DataSource skyIvrDataSource, ApplicationContext applicationContext) throws Exception {
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(skyIvrDataSource);
        sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:/sql/*.xml"));
        sqlSessionFactoryBean.setConfigLocation(applicationContext.getResource("classpath:/config/mapper-config.xml"));
        sqlSessionFactoryBean.setTypeAliasesPackage("com.workerman.vo");
        // VO 매핑안되는문제 해결
        sqlSessionFactoryBean.setVfs(SpringBootVFS.class);
        return sqlSessionFactoryBean.getObject();
    }
 
    @Bean(name = "sqlSessionTemplate")
    @Primary
    public SqlSessionTemplate skyIvrSqlSessionTemplate(SqlSessionFactory workermanSqlSessionFactory) throws Exception {
        return new SqlSessionTemplate(workermanSqlSessionFactory);
    }
    
    @Bean
    @Primary
    public DataSourceTransactionManager transactionManager() {
        DataSourceTransactionManager manager = new DataSourceTransactionManager(dataSource());
        return manager;
    }
}