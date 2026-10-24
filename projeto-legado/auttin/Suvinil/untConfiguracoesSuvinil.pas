unit untConfiguracoesSuvinil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, FilenameEditFocus, Menus, MaskEditFocus, untIConsultaTinta,
  DirectoryEditFocus, AppEvnts, Grids, ValEdit, Uni, untConfConsulta,
  untIConfTinta, BitBtnLockedIncrem, JvExMask, JvToolEdit, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmConfiguracoesSuvinil = class(TfrmPaiSimples)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label20: TLabel;
    chkUsaSuv: TCheckBox;
    edtTraSuv: TEditFocus;
    edtFatSuv: TEditFocus;
    edtNfmSuv: TEditFocus;
    pnlBotoesConf: TPanel;
    edtPatSuv: TFilenameEditFocus;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    chkUsaFor: TCheckBox;
    chkAntigo: TCheckBox;
    Label1: TLabel;
    vleBases: TValueListEditor;
    tbsConfCampos: TTabSheet;
    lblDtaAtu: TLabel;
    edtDtaAtu: TMaskEditFocus;
    edtVersao: TEditFocus;
    lblVersao: TLabel;
    Label6: TLabel;
    edtDesSuv: TEditFocus;
    btnSairConf: TBitBtnLocked;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    edtDesOpe: TEditFocus;
    Label7: TLabel;
    Label38: TLabel;
    edtApreve: TEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairConfClick(Sender: TObject);
    procedure vleBasesKeyPress(Sender: TObject; var Key: Char);
    procedure vleBasesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
  private
    { Private declarations }
    frmConfConsultaSuvinil: TfrmConfConsulta;
    tinta: IConsultaTinta ;
    conf: IConfTinta;
    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pAtualizaVariaveisGlobais;
    function fGetStrMaskEdit(edtEdit: TMaskEdit): String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesSuvinil: TfrmConfiguracoesSuvinil;

implementation

uses
    untFuncTinta, untFuncoesSimples, StrUtils;

{$R *.dfm}

{ TfrmConfiguracoesSuvinil }

procedure TfrmConfiguracoesSuvinil.pAtualizaVariaveisGlobais;
begin

end;

procedure TfrmConfiguracoesSuvinil.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA SUVINIL              *}
  {**************************************MV*}
  chkUsaSuv.Checked := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
  chkAntigo.Checked := conf.fGetBoolean('ANTIGO');
  edtTraSuv.Text := conf.fGet('TRASUV');
  edtFatSuv.Text := conf.fGet('FATSUV');
  edtNfmSuv.Text := conf.fGet('NFMSUV');
  edtPatSuv.Text := conf.fGet('PATSUV');
  vleBases.Strings.Text := AnsiReplaceStr(conf.fGet('BASANT'), '\n', #13#10);
  edtDtaAtu.Text := conf.fGet('DTAATU');
  edtVersao.Text := conf.fGet('VERSAO');
  edtDesSuv.Text := conf.fGet('DESSUV');
  edtDesOpe.Text := conf.fGet('DESOPE');
  edtApreve.Text := conf.fGet('APREVE');
end;

procedure TfrmConfiguracoesSuvinil.pGravaArqIni;
begin
  conf.pSetBoolean('USATIN', chkUsaSuv.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);
  conf.pSetBoolean('VENDIN', True);
  conf.pSetBoolean('ANTIGO', chkAntigo.Checked);
  conf.pSet('TRASUV', edtTraSuv.Text);
  conf.pSetDouble('FATSUV', fStrToFloat(edtFatSuv.Text));
  conf.pSetInteger('NFMSUV', StrToIntDef(edtNfmSuv.Text, 0));
  conf.pSet('PATSUV', edtPatSuv.Text);
  conf.pSet('BASANT', AnsiReplaceStr(vleBases.Strings.Text, #13#10, '\n'));

  If fEmptyStr(fGetStrMaskEdit(edtDtaAtu)) Then
    conf.pSet('DTAATU', '')
  Else
    conf.pSetDate('DTAATU', StrToDate(edtDtaAtu.Text));

  conf.pSet('VERSAO', edtVersao.Text);
  conf.pSetDouble('DESSUV', fStrToFloat(edtDesSuv.Text));
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaSuvinil.pSalvarConfs;
end;

procedure TfrmConfiguracoesSuvinil.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  if (fVerificaCampos) then
  begin

    if (fMensagem('', 'Confirma dados?', ['&Sim', '&Não']) = 1) then
    begin
      pGravaArqIni;
      pAtualizaVariaveisGlobais;
      Close;
    end;

  end;
end;

procedure TfrmConfiguracoesSuvinil.FormCreate(Sender: TObject);
begin
  inherited;
  conf := fGetConfTinta('SUV');
  tinta := fGetConsultaTinta('SUV');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************PH*}

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', 'S');
  conf.pInsereCodigo('USAFOR', 'Utilizar Formulação', 'S');
  conf.pInsereCodigo('VENDIN', 'Venda Dinâmica', 'S');
  conf.pInsereCodigo('ANTIGO', 'Utilizar Bases Antigas', 'N');
  conf.pInsereCodigo('BASANT', 'Bases com Geração Diferenciadas', '');
  conf.pInsereCodigo('TRASUV', 'Trava de Preço', 'VEN');
  conf.pInsereCodigo('FATSUV', 'Fator da Trava', '1');
  conf.pInsereCodigo('NFMSUV', 'Próximo código', '1');
  conf.pInsereCodigo('PATSUV', 'Path para os arquivos', '\');
  conf.pInsereCodigo('VERSAO', 'Versão da máquina', '');
  conf.pInsereCodigo('DTAATU', 'Data da Ultima Atualização', '');
  conf.pInsereCodigo('DESSUV', 'Desconto para valor da tinta', '0');
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pCarregaArqIni;
  pgcDados.ActivePageIndex := 0;
  frmConfConsultaSuvinil := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);  
end;

function TfrmConfiguracoesSuvinil.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    dtaUltAtualizacao: TDateTime;
begin
  Result := True;

  if (inherited fValidaCampos(Sender, blnBuscaPorChave)) then
  begin

    {*****************************************}
    {* VALIDA CAMPOS DA SUVINIL              *}
    {**************************************MV*}
    if (Sender = edtTraSuv) then
    begin

      if fEmptyStr(edtTraSuv.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      end
      else if Length(edtTraSuv.Text) <> 3 then
      begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
        Result := False;
      end
      else if Pos(edtTraSuv.Text, 'VEN_CUS_') <= 0 then
      begin
        fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
        Result := False;
      end;

    end

    Else If (Sender = edtDtaAtu) Then
    Begin
      If Not fEmptyStr(fGetStrMaskEdit(edtDtaAtu)) Then
      Begin
        If Not TryStrToDate(edtDtaAtu.Text, dtaUltAtualizacao) Then
          Result := fMensagem('ATENÇÃO', 'A data informada não é válida!', ['OK']) = -1
        Else
          edtDtaAtu.Text := DateToStr(dtaUltAtualizacao);
      End;
    End

    else if (Sender = edtFatSuv) then
    begin

      if fEmptyStr(edtFatSuv.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      end
      else if fStrToFloat(edtFatSuv.Text) <= 0.0 then
      begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
        Result := False;
      end;

    end

    else if (Sender = edtNfmSuv) then
    begin

      if (fEmptyStr(edtNfmSuv.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'O produto deve ser preenchido!', ['&Ok']);
        Result := False;
      end;

    end

    else if (Sender = edtPatSuv) then
    begin
      if (fEmptyStr(edtPatSuv.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'O path para arquivo de fórmulas deve ser preenchido!', ['&Ok']);
        Result := False;
      end
      else
      begin
        edtPatSuv.Text := fGetPath(edtPatSuv.Text);
        if (not DirectoryExists(edtPatSuv.Text)) then
          CreateDir(edtPatSuv.Text);
      end;
    end

    else if (Sender = edtDesSuv) then
    begin

      if fEmptyStr(edtDesSuv.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O Desconto deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      end
      else if fStrToFloat(edtDesSuv.Text) < 0.0 then
      begin
        fMensagem('ATENÇÃO!', 'O Desconto deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      end;

    end

    else if (Sender = edtDesOpe) then
    begin

      if fEmptyStr(edtDesOpe.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      end
      else if fStrToFloat(edtDesOpe.Text) < 0.0 then
      begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      end;

    end

    else if (Sender = edtApreve) then
    begin

      if fEmptyStr(edtApreve.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      end
      else if fStrToFloat(edtApreve.Text) < 0.0 then
      begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      end;

    end
                           {
    Else If (Sender = edtPatGpd) Then
    Begin

      If (Not fEmptyStr(edtPatGpd.Text)) Then
      Begin
        edtPatGpd.Text := fGetPath(edtPatGpd.Text);
        If (Not DirectoryExists(edtPatGpd.Text)) Then
          CreateDir(edtPatGpd.Text);
      End;

    End;                    }

  end;

  if (not Result) then
    pSetFocus(Sender);

end;

procedure TfrmConfiguracoesSuvinil.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

destructor TfrmConfiguracoesSuvinil.Destroy;
begin
  if Assigned(frmConfConsultaSuvinil) then FreeAndNil(frmConfConsultaSuvinil);
  inherited;
end;

procedure TfrmConfiguracoesSuvinil.vleBasesKeyPress(
  Sender: TObject; var Key: Char);
var
  stlCamIndBas: TStringList;
  stlDesIndBas: TStringList;
  qryAux: TUniQuery;
  strSQL: string;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    Key := #0;

    stlCamIndBas := TStringList.Create;
    stlDesIndBas := TStringList.Create;
    qryAux := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUV_CODFML "Código", ';
    strSQL := strSQL + '  SUV_CODBAS "Base", ';
    strSQL := strSQL + '  SUV_CODUNI "Unidade", ';
    strSQL := strSQL + '  SUV_CODEMP "Emp.", ';
    strSQL := strSQL + '  SUV_CODITE "Item", ';
    strSQL := strSQL + '  ITE_DESITE "Desc. Item", ';
    strSQL := strSQL + '  SUV_DESCRI "Descrição", ';
    strSQL := strSQL + '  SUV_CADBAS.AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  SUV_CADBAS ';
    strSQL := strSQL + 'LEFT JOIN CADITE ON ITE_CODITE = SUV_CODITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TRUE ';


    stlCamIndBas.Add('SUV_DESCRI');
    stlCamIndBas.Add('SUV_CODFML');
    stlCamIndBas.Add('SUV_CODBAS');
    stlCamIndBas.Add('SUV_CODITE');
    stlCamIndBas.Add('ITE_DESITE');

    stlDesIndBas.Add('Descrição');
    stlDesIndBas.Add('Código');
    stlDesIndBas.Add('Base');
    stlDesIndBas.Add('Item');
    stlDesIndBas.Add('Desc. Item');

    utcRegistros.Limpar(Self.Name + 'SUV_CADBAS');

    if pConsultaComp(Self, qryAux, 'SUV_CADBAS', strSQL, stlCamIndBas, stlDesIndBas) then
    begin
      if Pos(qryAux.FieldByName('SUV_CODFML').AsString + '=' + qryAux.FieldByName('SUV_CODBAS').AsString, vleBases.Strings.Text) <= 0 then
        vleBases.Strings.Add(qryAux.FieldByName('SUV_CODFML').AsString + '=' + qryAux.FieldByName('SUV_CODBAS').AsString);
    end;

    FreeAndNil(qryAux);
    FreeAndNil(stlCamIndBas);
    FreeAndNil(stlDesIndBas);
  end;
end;

procedure TfrmConfiguracoesSuvinil.vleBasesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (not fEmptyStr(vleBases.Strings.Text)) and (Key = VK_DELETE) then
  begin
    vleBases.DeleteRow(vleBases.Row);
  end;
end;

procedure TfrmConfiguracoesSuvinil.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaSuvinil.pRestaurarPadrao;
end;

procedure TfrmConfiguracoesSuvinil.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesSuvinil.ApplicationEventsMessage(
  var Msg: tagMSG; var Handled: Boolean);
begin
  inherited;
  If Msg.message = WM_KEYFIRST Then
    If Msg.wParam = 27 then
      btnSairConf.Click;
end;

function TfrmConfiguracoesSuvinil.fGetStrMaskEdit(
  edtEdit: TMaskEdit): String;
begin
  Result := edtEdit.Text;

  Result := Trim(AnsiReplaceStr(Result, '/', ''));
  Result := Trim(AnsiReplaceStr(Result, '_', ''));
end;

end.



