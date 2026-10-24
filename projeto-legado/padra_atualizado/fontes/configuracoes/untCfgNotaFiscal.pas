{***************************}
{* qryConTra -> CADTRA     *}
{************************JB*}

unit untCfgNotaFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  DBCtrls, DBEditFocus, QColorLabel, Uni, AppEvnts;

type
  TfrmCfgNotaFiscal = class(TfrmPai)
    pnlCentral: TPanel;
    Label69: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    dbeIteNot: TDBEditFocus;
    dbeTraSug: TDBEditFocus;
    edtSenCla: TEditFocus;
    edtSenNfo: TEditFocus;
    edtTraSug: TEditFocus;
    btnGravar: TBitBtn;
    edtSenNes: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    ColorLabel1: TColorLabel;
    dbeOpcCfop: TDBEditFocus;
    Label3: TLabel;
    dbeQtdMsgNota: TDBEditFocus;
    Label4: TLabel;
    dbeQtdCarac: TDBEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    ColorLabel2: TColorLabel;
    dbeTipFor: TDBEditFocus;
    edtSenNfe: TEditFocus;
    Label7: TLabel;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeTraSugKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryConTra: TUniQuery;

    procedure pGravaArqIni;
    procedure pCarregaArqIni;

    procedure pCarregaTransportadoraSugestao;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCfgNotaFiscal: TfrmCfgNotaFiscal;

implementation

uses untPesqAux, untModuloCadTra, untFuncoes, untfuncoesSimples,
  untModulo;

{$R *.dfm}

{ TfrmCfgNotaFiscal }

function TfrmCfgNotaFiscal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  {*****************************************}
  {* VALIDAÇÃO DA ABA NOTA FISCAL          *}
  {**************************************MV*}
  If (Sender = dbeIteNot) Then
  Begin

    If fEmptyStr(dbeIteNot.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Quantidade de itens por nota deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeIteNot.Text) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'A Quantidade de itens por nota deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;

  End
  Else If (Sender = dbeQtdMsgNota) Then
  Begin

    If fEmptyStr(dbeQtdMsgNota.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Quantidade de mensagens da nota deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeQtdMsgNota.Text) <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'A Quantidade de mensagens na nota deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbeQtdMsgNota.Text) > 5 Then
    Begin
      fMensagem('ATENÇÃO!', 'A Quantidade de mensagens na nota deve ser menor que 5!',['&OK']);
      Result := False;
    End;

  End

  Else If (Sender = dbeTraSug) Then
  Begin

    If Not fEmptyStr(dbeTraSug.Text) Then
    Begin
      pCarregaTransportadoraSugestao;

      If qryConTra.FieldByName('TRA_CODTRA').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Transportadora não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      edtTraSug.Clear;
    End;

  End

  Else If (Sender  = dbeOpcCfop) Then
  Begin

    If Pos(dbeOpcCfop.Text,'12') <= 0 Then
    Begin
      fMensagem('','O campo de opção do cfop deve ser 1 ou 2!', ['&OK']);
      Result := False;
    End;

  End

  Else If (Sender = edtSenCla) Then
  Begin
    If fEmptyStr(edtSenCla.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A senha para alteração de Classificação Fiscal deve ser preenchida!', ['&Ok']);
      Result := False;
    End
  End

  Else If (Sender = edtSenNfo) Then
  Begin
    If fEmptyStr(edtSenNfo.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A senha para emissão de NF outras saidas deve ser preenchida!', ['&Ok']);
      Result := False;
    End
  End

  Else If (Sender = edtSenNfe) Then
  Begin
    If fEmptyStr(edtSenNfe.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A senha para emissão de NF outras entradas deve ser preenchida!', ['&Ok']);
      Result := False;
    End
  End

  Else If (Sender = edtSenNes) Then
  Begin
    If fEmptyStr(edtSenNes.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A senha para emissão de Nota Especial deve ser preenchida!', ['&Ok']);
      Result := False;
    End
  End

  Else If (Sender  = dbeQtdCarac) Then
  Begin
    If fStrToFloat(dbeQtdCarac.Text) < 0 Then
    Begin
      fMensagem('','O valor do campo Qtde de Caracteres para Imprimir Mensagem dever ser maior ou igual a Zero!', ['&OK']);
      Result := False;
    End
    Else If fStrToFloat(dbeQtdCarac.Text) > 70 Then
    Begin
      fMensagem('','O valor do campo Qtde de Caracteres para Imprimir Mensagem dever ser menor que 70!', ['&OK']);
      Result := False;
    End;
  End
  Else If (Sender = dbeTipFor) Then
  Begin

    If (Pos(dbeTipFor.Text,'AC') <= 0) Then
      Result := False;

  End;  

  If (Not Result) Then
    Sender.SetFocus;

end;

procedure TfrmCfgNotaFiscal.pCarregaArqIni;
begin
  {*****************************************}
  {* SENHAS DA ABA NOTA FISCAL             *}
  {**************************************MV*}
  edtSenCla.Text := frmModulo.qryCadCfg.FieldByName('CFG_SENCLA').AsString;
  edtSenNfe.Text := frmModulo.qryCadCfg.FieldByName('CFG_SENNFE').AsString;
  edtSenNfo.Text := frmModulo.qryCadCfg.FieldByName('CFG_SENNFO').AsString;
  edtSenNes.Text := frmModulo.qryCadCfg.FieldByName('CFG_SENNES').AsString;

  pCarregaTransportadoraSugestao; 
end;

procedure TfrmCfgNotaFiscal.pCarregaTransportadoraSugestao;
begin
  pPesquisaCadTra(frmModuloCadTra.qryCadTra, qryConTra, dbeTraSug.Text);
  With qryConTra Do
  Begin
    edtTraSug.Text := FieldByName('TRA_NOMTRA').AsString;
  End;
end;

procedure TfrmCfgNotaFiscal.pGravaArqIni;
begin
  {*****************************************}
  {* SENHAS DA ABA NOTA FISCAL             *}
  {**************************************MV*}
  frmModulo.qryCadCfg.FieldByName('CFG_SENCLA').AsString := edtSenCla.Text;
  frmModulo.qryCadCfg.FieldByName('CFG_SENNFE').AsString := edtSenNfe.Text;
  frmModulo.qryCadCfg.FieldByName('CFG_SENNFO').AsString := edtSenNfo.Text;
  frmModulo.qryCadCfg.FieldByName('CFG_SENNES').AsString := edtSenNes.Text;
end;

procedure TfrmCfgNotaFiscal.btnGravarClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    pGravaArqIni;
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmCfgNotaFiscal.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
end;

procedure TfrmCfgNotaFiscal.dbeTraSugKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamposTra: TStringList;
    stlCamIndTra: TStringList;
    stlDesIndTra: TStringList;
begin
  inherited;
  stlCamposTra := TStringList.Create;
  stlCamIndTra := TStringList.Create;
  stlDesIndTra := TStringList.Create;

  If fEntraCons(Key) Then
  Begin

    stlCamposTra.Add('TRA_CODTRA');
    stlCamposTra.Add('TRA_NOMTRA');
    stlCamposTra.Add('TRA_ENDERE');
    stlCamposTra.Add('AUTOINCREM');

    stlCamIndTra.Add('TRA_NOMTRA');
    stlCamIndTra.Add('TRA_CODTRA');

    stlDesIndTra.Add('Nome');
    stlDesIndTra.Add('Código');

    If pConsultaRapida(Self, qryConTra, 'CADTRA', stlCamIndTra, stlDesIndTra, stlCamposTra) Then
    Begin
      dbeTraSug.Text := qryConTra.FieldByName('TRA_CODTRA').AsString;
      pCarregaTransportadoraSugestao;
      Self.SelectNext(ActiveControl, True, True);
    End;

  End;

  FreeAndNil(stlCamposTra);
  FreeAndNil(stlCamIndTra);
  FreeAndNil(stlDesIndTra);

end;

procedure TfrmCfgNotaFiscal.FormCreate(Sender: TObject);
begin
  inherited;

  qryConTra := frmModuloCadTra.qryCadTra;

end;

initialization
  RegisterClass(TfrmCfgNotaFiscal);
finalization
  UnRegisterClass(TfrmCfgNotaFiscal);

end.

