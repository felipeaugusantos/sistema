unit untCfgContele;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, MemoFocus, EditFocus, Uni;

type
  TfrmCfgContele = class(TfrmPaiConfirma)
    edtBaseUrl: TEditFocus;
    edtApiKey: TEditFocus;
    mmoTokenAuth: TMemoFocus;
    lblBaseUrl: TLabel;
    lblApikey: TLabel;
    lblToken: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }

    procedure pCarregaDados;
  public
    { Public declarations }
  end;

var
  frmCfgContele: TfrmCfgContele;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmCfgContele.btnConfirmaClick(Sender: TObject);
var
  qryApiCon: TUniQuery;
begin
  inherited;
  qryApiCon := fCriaQuery(Self);
  try
    try
      fStartTransaction;

      qryApiCon.Close;
      qryApiCon.SQL.Text :=
      ' DELETE FROM '+
      '   APICON '+
      ' WHERE '+
      '   CON_CODEMP = :CODEMP ';
      qryApiCon.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryApiCon.ExecSQL;

      qryApiCon.Close;
      qryApiCon.SQL.Text :=
      ' INSERT INTO APICON '+
      '   (CON_CODEMP, '+
      '    CON_URLCON, '+
      '    CON_KEYCON, '+
      '    CON_AUTCON) '+
      ' VALUES '+
      '   (:CODEMP, '+
      '    :URLCON, '+
      '    :KEYCON, '+
      '    :AUTCON) ';

      qryApiCon.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryApiCon.ParamByName('URLCON').AsString := Trim(edtBaseUrl.Text);
      qryApiCon.ParamByName('KEYCON').AsString := Trim(edtApiKey.Text);
      qryApiCon.ParamByName('AUTCON').AsString := Trim(mmoTokenAuth.Text);
      qryApiCon.ExecSQL;

      fCommit;

      fMensagem('ATENÇÃO!', 'Configurações gravadas com sucesso!', ['&Ok']);
    except
      on E: Exception do
      begin
        if fInTransaction then
          fRollBack;

        pMensagensErro(E.message, 'TfrmCfgContele');
      end;
    end;
  finally
    FreeAndNil(qryApiCon);
  end;
end;

procedure TfrmCfgContele.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmCfgContele.pCarregaDados;
var
  qryApiCon: TUniQuery;
begin
  qryApiCon := fCriaQuery(Self);
  try
    qryApiCon.Close;
    qryApiCon.SQL.Text :=
    ' SELECT '+
    '   CON_URLCON, '+
    '   CON_KEYCON, '+
    '   CON_AUTCON  '+
    ' FROM '+
    '   APICON '+
    ' WHERE '+
    '   CON_CODEMP = :CODEMP ';

    qryApiCon.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryApiCon.Open;

    if not qryApiCon.IsEmpty then
    begin
      edtBaseUrl.Text := qryApiCon.FieldByName('CON_URLCON').AsString;
      edtApiKey.Text := qryApiCon.FieldByName('CON_KEYCON').AsString;
      mmoTokenAuth.Text := qryApiCon.FieldByName('CON_AUTCON').AsString;
    end;
  finally
    FreeAndNil(qryApiCon);
  end;

end;

end.
