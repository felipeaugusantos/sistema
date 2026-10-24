unit untExpBuscaChaveNFe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, EditFocus,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Uni, DB;

type
  TfrmExpBuscaChaveNFe = class(TfrmPaiConfirma)
    Label1: TLabel;
    edtChave: TEditFocus;
    procedure edtChaveKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtChaveChange(Sender: TObject);
  private
    { Private declarations }
    function fAchouDoc: Boolean;
    function fChaveValida:Boolean;

  public
    { Public declarations }
    strNumDocChv : String;
    strEspDocChv : String;
    strCodEmpChv : String;
    strCodCliChv : String;

  end;

var
  frmExpBuscaChaveNFe: TfrmExpBuscaChaveNFe;

implementation

uses
  untFuncoes, untFuncoesSimples;

{$R *.dfm}

procedure TfrmExpBuscaChaveNFe.edtChaveChange(Sender: TObject);
begin
  inherited;

  If fChaveValida Then
  Begin
    If fAchouDoc Then
    Begin
      btnConfirma.Click;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Nenhum documento encontrado com esta Chave de Acesso!', ['&Ok']);
      edtChave.SelText;
      pSetFocus(edtChave);
    End;
  End;

end;

procedure TfrmExpBuscaChaveNFe.edtChaveKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If (Key = #13) Then
  Begin
    If fEmptyStr(edtChave.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Digite ou faça a leitura da Chave de Acesso!', ['&Ok']);
      pSetFocus(edtChave);
    End

    Else If Not fChaveValida Then
    Begin
      fMensagem('ATENÇÃO!', 'Tamanho da Chave de Acesso diferente da quantidade válida!', ['&Ok']);
      edtChave.SelText;
      pSetFocus(edtChave);
    End;
  End;
end;

function TfrmExpBuscaChaveNFe.fAchouDoc: Boolean;
  Var
    qryTmp : TUniQuery;
    strSQL : String;
begin
  Result := False;

  strNumDocChv := '';
  strEspDocChv := '';
  strCodEmpChv := '';
  strCodCliChv := '';

  Try
    qryTmp := fCriaQuery(Nil);

    With qryTmp Do
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   FIS_NUMDOC AS NUMDOC, ';
      strSQL := strSQL + '   FIS_ESPDOC AS ESPDOC, ';
      strSQL := strSQL + '   FIS_CODEMP AS CODEMP, ';
      strSQL := strSQL + '   FIS_FORCLI AS CODCLI, ';
      strSQL := strSQL + '   FIS_TIP_FC AS CLIFOR ';
      strSQL := strSQL + ' FROM  ';
      strSQL := strSQL + '   CADFIS      ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   FIS_ACESSO = "' + Trim(edtChave.Text)  + '"';

      Close;
      Sql.Text := strSQL;
      Open;

      If (Not qryTmp.IsEmpty) Then
      Begin
        strNumDocChv := qryTmp.FieldByName('NUMDOC').AsString;
        strEspDocChv := qryTmp.FieldByName('ESPDOC').AsString;
        strCodEmpChv := qryTmp.FieldByName('CODEMP').AsString;
        strCodCliChv := qryTmp.FieldByName('CODCLI').AsString;
        Result := True;
      End;
    End;

  Finally
    pFreeAndNil(qryTmp);
  End;

end;

function TfrmExpBuscaChaveNFe.fChaveValida: Boolean;
begin

  Result := Length(Trim(edtChave.Text)) = 44;

end;

procedure TfrmExpBuscaChaveNFe.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtChave);
end;

end.
