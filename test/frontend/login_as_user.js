describe('Login as user success', function(){
    it('Should login as user with success', function(){
        browser.ignoreSynchronization = true;
        browser.get('http://localhost:3000/login');
        element(by.id("session_email")).sendKeys("test1@test.com");
        element(by.id("session_password")).sendKeys("123456");
        element(by.xpath('//div[contains(@class,"ui checkbox")]')).click();
        browser.sleep(5000);
        element(by.xpath('/html/body/div[2]/div/div/form/div[4]/input')).click();
    });
});