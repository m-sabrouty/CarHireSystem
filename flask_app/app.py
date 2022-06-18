from flask import Flask, request,flash,Response
from flask_mysqldb import MySQL
app = Flask(__name__)
  
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'odoo'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'CarHireDB'
 
mysql = MySQL(app)


@app.route('/customer',methods = ['GET'])
def get_customer():
    cursor = mysql.connection.cursor()
    cursor.execute(''' SELECT  name,phone,email from customer ''')
    data = cursor.fetchall()
    cursor.close()
    return Response(data, mimetype='text/plain')

#Add Customer 
@app.route('/customer/add',methods = ['POST'])
def add_customer():
    error=False
    try:
        cursor = mysql.connection.cursor()
        name=request.form.get('name')
        phone=request.form.get('phone')
        email=request.form.get('email')
        query_string=''' INSERT INTO customer (name,phone,email) VALUES(%s,%s,%s) '''
        cursor.execute(query_string, (name,phone,email,))
        mysql.connection.commit()
    except:
    error=True
    flash('An error occurred. Customer could not be deleted.')

  finally:
    if not error:
      flash('Customer is successfully Added!') 
    cursor.close()     
  return None

#delete customer
@app.route('/customer/<customer_id>/delete',methods = ['DELETE'])
def delete_customer():
    error=False
  try:
    cursor = mysql.connection.cursor()
    query_string=''' SELECT  name,phone,email from customer where id = %s'''
    cursor.execute(query_string, (customer_id))
    db_customer = cursor.fetchall()
    
    if db_customer:
        query_string=''' DELETE  from customer where id = %s'''
        cursor.execute(query_string, (customer_id))
        mysql.connection.commit()
  except:
    error=True
    flash('An error occurred. Customer could not be deleted.')

  finally:
    if not error:
      flash('Customer is successfully deleted!') 
    cursor.close()     
  return None
  
#edit customer 
@app.route('/customer/<customer_id>/edit',methods = ['PUT'])
def edit_customer():
    error=False
    try:
        cursor = mysql.connection.cursor()
        query_string=''' SELECT  name,phone,email from customer where id = %s'''
        cursor.execute(query_string, (customer_id))
        db_customer = cursor.fetchall()
    
    if db_customer:
        name=request.form.get('name')
        phone=request.form.get('phone')
        email=request.form.get('email')
        query_string='''UPDATE customer SET name=%s, phone=%s,email=%s  WHERE id = %s'''
        cursor.execute(query_string, (name,phone,email,customer_id))
        mysql.connection.commit()
       
    except:
    error=True
    flash('An error occurred. Customer could not be edited.')

  finally:
    if not error:
      flash('Customer is successfully edited!') 
    cursor.close()     
  return None
    

     


# main driver function
if __name__ == '__main__':
  
    app.run()