describe('Login as user error', function(){
    it('Should login as user with error', function(){
        browser.ignoreSynchronization = true;
        browser.get('http://localhost:3000/login');
        element(by.xpath('/html/body/div[2]/div/div/form/div[4]/input')).click();
        browser.sleep(5000);
        expect(element(by.xpath('//*[@id="message"]/div')).isDisplayed()).toBe(true);
    });
});