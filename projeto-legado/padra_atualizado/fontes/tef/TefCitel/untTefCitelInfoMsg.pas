unit untTefCitelInfoMsg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, untInterfaceTefCitel, UniClientDataSet,
  Datasnap.DBClient;

const
  constMsgTef = 'Insira ou passe ou aproxime o cartao na leitora';

type
  TfrmTefCitelInfoMsg = class(TfrmPaiSimples)
    dsMsg: TDataSource;
    CdsMsg: TUniClientDataSet;
    CdsMsgMSG: TStringField;
    ListBox1: TListBox;
    lbStatusTef: TLabel;
    btnEncerraMenu: TBitBtnLocked;
    tmrDesabilitaBotao: TTimer;
    procedure btnEncerraMenuClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrDesabilitaBotaoTimer(Sender: TObject);
  private
    { Private declarations }
    function fValidaStatus : Boolean;
  public
    { Public declarations }
    dtaData : TDate;
    strNumAut : String;
    fltValTra : Double;
    strTipoCar : String;
    strMsgTef : String;
    RetornoTEFCitel: IRetornoTEFCitel;

    intOperacao, intQtdParc : Integer;
    strModalidade , strNumDoc, strRcxCodOpe : String;
    fltValor : Double;
    strStatus : String;
  end;

implementation

uses
  untTefCitelUtil, untFuncoesSimples;

{$R *.dfm}

procedure TfrmTefCitelInfoMsg.btnEncerraMenuClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmTefCitelInfoMsg.FormShow(Sender: TObject);
begin
  inherited;
  btnEncerraMenu.Visible   := False;
  tmrDesabilitaBotao.Enabled      := True;
  if fValidaStatus then
  begin
    tmrDesabilitaBotao.Enabled    := False;
    btnEncerraMenu.Visible := True;
    btnEncerraMenu.SetFocus;
  end;
end;

procedure TfrmTefCitelInfoMsg.tmrDesabilitaBotaoTimer(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

function TfrmTefCitelInfoMsg.fValidaStatus : Boolean;
begin
  Result := False;

  if (fVerificaMsgTefCitel(lbStatusTef.Caption)) then
    Result := True;

  if (strStatus = '21') then
    Result := True;
end;

end.
