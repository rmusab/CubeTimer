unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzBorder, RzBckgnd, StdCtrls, RzLabel, RzButton, ExtCtrls,
  RzPanel, Digit, DBCtrls, RzDBNav, DB, Grids, DBGrids, ABSMain;

type
  TForm1 = class(TForm)
    RzBackground1: TRzBackground;
    RzBitBtn1: TRzBitBtn;
    Timer1: TTimer;
    Digit3: TDigit;
    Digit4: TDigit;
    Digit5: TDigit;
    Digit6: TDigit;
    Digit1: TDigit;
    Digit2: TDigit;
    Timer2: TTimer;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    ABSTable1: TABSTable;
    ABSDatabase1: TABSDatabase;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ABSTable1Date: TStringField;
    ABSTable1Record: TStringField;
    RzDBNavigator1: TRzDBNavigator;
    RzBitBtn2: TRzBitBtn;
    procedure Timer1Timer(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  milsec,sec,min: integer;
  time: _SYSTEMTIME;

implementation

{$R *.dfm}

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if milsec < 59 then milsec:=milsec+1
  else begin
  milsec:=0;
  if sec < 59 then sec:=sec+1
  else begin
    sec:=0;
    if min >= 59 then begin
      Timer2.Enabled := false;
      Timer1.Enabled := false;
      Digit1.Value := IntToStr(milsec mod 10)[1];
      Digit1.Value := '0';
      Digit2.Value := '0';
      Digit3.Value := '0';
      Digit4.Value := '0';
      Digit5.Value := '0';
      Digit6.Value := '0';
      MessageDlg('Достигнуто масмальное время!',mtInformation,[mbOk],0);
      RzBitBtn1.Enabled := false;
      RzBitBtn2.Enabled := true;
      DBGrid1.Enabled := true;
      RzDBNavigator1.Enabled := true;
      RzBitBtn2.SetFocus;
      Exit;
    end else begin
      min:=min+1;
    end;
   end;
  end;
  Digit2.Value := IntToStr(milsec div 10)[1];
  Digit3.Value := IntToStr(sec mod 10)[1];
  Digit4.Value := IntToStr(sec div 10)[1];
  Digit5.Value := IntToStr(min mod 10)[1];
  Digit6.Value := IntToStr(min div 10)[1];
  Application.ProcessMessages;
end;

procedure TForm1.RzBitBtn1Click(Sender: TObject);
begin
  if Timer1.Enabled = false then begin
  Digit1.Value := '0';
  Digit2.Value := '0';
  Digit3.Value := '0';
  Digit4.Value := '0';
  Digit5.Value := '0';
  Digit6.Value := '0';
  Timer1.Enabled := true;
  Timer2.Enabled := true;
  end else begin
  Timer2.Enabled := false;
  Timer1.Enabled := false;
  Digit1.Value := IntToStr(milsec mod 10)[1];
  RzBitBtn1.Enabled := false;
  RzBitBtn2.Enabled := true;
  DBGrid1.Enabled := true;
  RzDBNavigator1.Enabled := true;
  ABSTable1.Insert;
  GetSystemTime(Time);
  ABSTable1.FieldByName('Date').Text := FloatToStr(time.wDay)+'.'+
    FloatToStr(time.wMonth)+'.'+FloatToStr(time.wYear)+' '+FloatToStr(time.wHour)+
    ':'+FloatToStr(time.wMinute)+':'+FloatToStr(time.wSecond);
  ABSTable1.FieldByName('Record').Text := IntToStr(min)+':'+
  IntToStr(sec)+':'+IntToStr(milsec);
  ABSTable1.Post;
  RzBitBtn2.SetFocus;
  end;
  milsec:=0; sec:=0; min:=0;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  Digit1.Value := IntToStr(milsec mod 10)[1];
end;

procedure TForm1.RzBitBtn2Click(Sender: TObject);
begin
  If RzBitBtn1.Enabled = false then begin
    RzBitBtn1.Enabled := true;
    RzBitBtn2.Enabled := false;
    DBGrid1.Enabled := false;
    RzDBNavigator1.Enabled := false;
    RzBitBtn1.SetFocus;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  RzBitBtn2.SetFocus;
end;

end.
