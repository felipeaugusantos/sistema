unit untAltDataEntregaRota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, Uni,
  ExtCtrls, Mask, MaskEditFocus, frxClass, frxExportCSVTestabilidade;

type
  TfrmAltDataEntregaRota = class(TfrmPai)
    pnlDados: TPanel;
    Label1: TLabel;
    mskDtaVen: TMaskEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function fDataAlterada: Boolean;
    function fValidaFeriado: Boolean;
  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
    strCodRot: String;
    strCodReg: String;
    blnAlterou: Boolean;
  end;


implementation

uses
    untFuncoesSimples, RotasPorRegiao.Funcoes;

{$R *.dfm}

{ TfrmAltDataEntregaRota }

procedure TfrmAltDataEntregaRota.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And (fValidaFeriado) Then
    blnAlterou := fDataAlterada;
  If blnAlterou Then
    Self.Close;  
end;

function TfrmAltDataEntregaRota.fDataAlterada: Boolean;
  function fRetSQL: String;
  Begin
    Result := '';
    Result := Result + ' UPDATE ENTREG ';
    Result := Result + '    SET ENT_DTAENT = :DTAENT ';
    Result := Result + '  WHERE ENT_CODIGO = :CODROT '; 
  End;
var
  qryUpt: TUniQuery;
begin
  Result := True;
  Try
    Try
      qryUpt := fCriaQuery(Nil);
      With qryUpt Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSQL);
        ParamByName('DTAENT').AsDate   := StrToDate(mskDtaVen.Text);
        ParamByName('CODROT').AsString := strCodRot;
        ExecSQL;
      End;

      fMensagem('INFORMAÇÃO','Data de entrega alterada com sucesso !',['&Ok']);

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[frmAltDataEntregaRota.fDataAlterada]');
      End;
    End;
  Finally
    FreeAndNil(qryUpt);
  End;
end;

procedure TfrmAltDataEntregaRota.FormShow(Sender: TObject);
begin
  inherited;
  blnAlterou := False;
  mskDtaVen.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  pSetFocus(mskDtaVen);
end;

function TfrmAltDataEntregaRota.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaVen) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaVen.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data da Rota deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If StrToDate(mskDtaVen.Text) < VS_Date Then
      Begin
        fMensagem('ATENÇÃO!', 'A data de entrega deve ser maior ou igual a hoje !', ['&O k']);
        Result := False;
      End
    End;

    If Not Result Then
      pSetFocus(Sender);

  End;
end;

function TfrmAltDataEntregaRota.fValidaFeriado: Boolean;
begin
  Result := TFuncoesRotas.fValidaFeriadoCidades(strCodReg, StrToDateTimeDef(mskDtaVen.Text, 0));
end;

end.
