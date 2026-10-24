unit Contabilidade.View.ContasPorEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, UniClientDataSet,
  Vcl.Mask, MaskEditFocus;

type
  TfrmContasPorEmpresa = class(TfrmPaiContabilidade)
    Panel1: TPanel;
    Panel2: TPanel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtDesCon: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    cxgDadosDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgDadosLevel1: TcxGridLevel;
    cxgDados: TcxGridCitel;
    cxgDadosDBTableViewCitel1CODEMP: TcxGridDBColumn;
    dtsDados: TDataSource;
    mskCodCon: TMaskEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    cxgDadosDBTableViewCitel1CONMSK: TcxGridDBColumn;
    btnGravar: TBitBtnLocked;
    btnAlterarRegistro: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mskCodConKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cxgDadosDBTableViewCitel1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarRegistroClick(Sender: TObject);
  private
    { Private declarations }
    FblnReadOnly: Boolean;
    strMascara : String;
    blnDeletou : Boolean;
    procedure pLimpar;
    procedure pCarregarDados;
    procedure pCarregaPlanoContabil(var ANatureza: String);
    procedure pConfReadOnly;
  public
    { Public declarations }
    strTabela : String;
    strValorChave: String;
    strCampoChave: String;
    blnCriaDataSet : Boolean;
    cdsDados : TUniClientDataSet;
    strCreDeb: String;
    class function fCriaCdsDados(AOwner: TComponent): TUniClientDataSet;
    property ReadOnly: Boolean read FblnReadOnly write FblnReadOnly;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, Contabilidade.Funcoes, untTypesSistema, untConsultas,
     Contabilidade.Consultas, Uni, System.MaskUtils,
     Contabilidade.View.AlteraContasPorEmpresa, System.StrUtils;

{$R *.dfm}

{ TfrmContasPorEmpresa }

procedure TfrmContasPorEmpresa.btnAlterarRegistroClick(Sender: TObject);
  var
    LfrmAlteraContasPorEmpresa : TfrmAlteraContasPorEmpresa;
    strTplAco : String ;
begin
  if (not cdsDados.Active) then
  begin
    fMensagem('ATENÇÃO!', 'Não há dados para efetuar a alteração!',['&OK']);
    Exit;
  end;

  if (cdsDados.IsEmpty) then
  begin
    fMensagem('ATENÇÃO!', 'Não há dados para efetuar a alteração!',['&OK']);
    Exit;
  end;

  pCriarFormularios(TfrmAlteraContasPorEmpresa, LfrmAlteraContasPorEmpresa);
  try
    LfrmAlteraContasPorEmpresa.cdsDados := cdsDados;
    LfrmAlteraContasPorEmpresa.strCreDeb := strCreDeb;
    LfrmAlteraContasPorEmpresa.edtCodEmp.Text := cdsDados.FieldByName('CODEMP').AsString;
    LfrmAlteraContasPorEmpresa.edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [cdsDados.FieldByName('CODEMP').AsString], False);
    LfrmAlteraContasPorEmpresa.mskCodCon.Text := cdsDados.FieldByName('CODCON').AsString;
    strTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [cdsDados.FieldByName('CODEMP').AsString], False);
    LfrmAlteraContasPorEmpresa.edtDesCon.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(cdsDados.FieldByName('CODCON').AsString), strTplAco]);
    LfrmAlteraContasPorEmpresa.ShowModal;

    If (cdsDados.State in [dsInsert, dsEdit]) then
      cdsDados.Cancel;
  finally
    pFreeAndNil(LfrmAlteraContasPorEmpresa);
  end;
end;

procedure TfrmContasPorEmpresa.btnAdicionarClick(Sender: TObject);

  Function fContaTemDuplicidade(strCodEmp, strCreDeb: String): Boolean;
  Var
    cdsCloneDados: TUniClientDataSet;
  Begin
    Result := False;

    cdsCloneDados := TUniClientDataSet.Create(nil);
    cdsCloneDados.CloneCursor(cdsDados, False, False);
    cdsCloneDados.First;
    While Not cdsCloneDados.Eof do
    Begin
      If (cdsCloneDados.FieldByName('CODEMP').AsString = strCodEmp) And
         (cdsCloneDados.FieldByName('CREDEB').AsString = strCreDeb) Then
        Result := True;
      cdsCloneDados.Next;
    End;
    cdsCloneDados.Close;
    FreeAndNil(cdsCloneDados);
  End;

begin
  inherited;

  If fContaTemDuplicidade(edtCodEmp.Text, strCreDeb) Then
  begin
    fMensagem('ATENÇÃO!', 'Existe uma duplicidade nos registros [ Empresa : '+edtCodEmp.Text+' - Natureza : "'+strCreDeb+'" ], favor verificar!',['&OK']);
    pSetFocus(btnAdicionar);
    Exit;
  end;

  if not fVerificaCampos then
    exit;

  if (Not cdsDados.IsEmpty) and (cdsDados.FindKey([edtCodEmp.Text, fSemMascaraPlaNco(mskCodCon.Text)])) then
  begin
    fMensagem('ATENÇÃO!', 'Esses dados já foram inseridos, favor verificar!',['&OK']);
    pSetFocus(btnAdicionar);
    Exit;
  end;

  cdsDados.Insert;
  cdsDados.FieldByName('CREDEB').AsString := strCreDeb;
  cdsDados.FieldByName('CODEMP').AsString := edtCodEmp.Text;
  cdsDados.FieldByName('CODCON').AsString := fSemMascaraPlaNco(mskCodCon.Text);
  cdsDados.FieldByName('CONMSK').AsString := FormatMaskText(strMascara, fSemMascaraPlaNco(mskCodCon.Text));
  cdsDados.Post;

  pLimpar;

  pSetFocus(edtCodEmp);
end;

procedure TfrmContasPorEmpresa.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pLimpar;
  pSetFocus(edtCodEmp);
end;

procedure TfrmContasPorEmpresa.btnGravarClick(Sender: TObject);
begin
  inherited;

  if (cdsdados.IsEmpty) and (not blnDeletou) then
  begin
    fMensagem('ATENÇÃO!', 'Não há dados para gravar!',['&OK']);
    Exit;
  end;

  if (blnCriaDataSet) then
  begin

    if fSalvaDadosNCO(strTabela, strCampoChave, strValorChave, cdsDados) then
      blnDeletou := False;

  End;

  Close;
end;

procedure TfrmContasPorEmpresa.cxgDadosDBTableViewCitel1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if FblnReadOnly then
    Exit ;

  if (Key = VK_Delete) then
  begin
    If fMensagem('ATENÇÃO!', 'Deseja realmente excluir o registro?', ['&Sim', '&Não']) = 1 Then
    begin
      cdsDados.Delete;
      blnDeletou := True;
    end;
  end;
end;

procedure TfrmContasPorEmpresa.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp : TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
    SelectNext(ActiveControl, True, True);
end;

class function TfrmContasPorEmpresa.fCriaCdsDados(AOwner: TComponent): TUniClientDataSet;
begin
  Result := fCriaEstruturaCdsNCO(AOwner) ;
end;

procedure TfrmContasPorEmpresa.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodEmp);
end;

procedure TfrmContasPorEmpresa.FormCreate(Sender: TObject);
begin
  inherited;
  strTabela := '';
  strValorChave := '';
  strCampoChave := '';
  blnCriaDataSet := True;
  strMascara := fMskCon;
  mskCodCon.EditMask := strMascara;
  blnDeletou := False;
end;

procedure TfrmContasPorEmpresa.FormDestroy(Sender: TObject);
begin
  if (blnCriaDataSet) then
    FreeAndNil(cdsDados);
  inherited;
end;

procedure TfrmContasPorEmpresa.FormShow(Sender: TObject);
begin
  inherited;
  pConfReadOnly ;

  if (blnCriaDataSet) then
    cdsDados := fCriaCdsDados(Self);

  dtsDados.DataSet := cdsDados;

  pCarregarDados;
end;

function TfrmContasPorEmpresa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  LNatureza: String ;
begin
  Result := True;

  Try
    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin
      if (Sender = mskCodCon) then
      begin
        if fEmptyStr(fSemMascaraPlaNco(mskCodCon.Text)) then
        begin
          fMensagem('ATENÇÃO!','Obrigatório preenchimento da Conta!',['&OK']);
          Result := False;
        end
        else
        begin
          pCarregaPlanoContabil(LNatureza) ;
          If (Not fEmptyStr(fSemMascaraPlaNco(mskCodCon.Text))) And (fEmptyStr(edtDesCon.Text)) Then
          Begin
            fMensagem('ATENÇÃO!',IfThen(LNatureza = 'S', 'Não é possível utilizar uma Conta Contábil de Natureza Sintética', 'Conta Inválida!'),['&OK']);
            Result := False;
          End;
        end;
      end
      else if (Sender = edtCodEmp) then
      begin
        if fEmptyStr(edtCodEmp.Text) then
        begin
          fMensagem('ATENÇÃO!','Obrigatório preenchimento da Empresa!',['&OK']);
          Result := False;
        end
        else
        begin
          edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text], False);
          If (Not fEmptyStr(edtCodEmp.Text)) And (fEmptyStr(edtNomEmp.Text)) Then
          Begin
            fMensagem('ATENÇÃO!','Empresa Inválida!',['&OK']);
            Result := False;
          End;
        end;
      end;
    End;
  Except
    {On E: ExceptionAutCom Do
    Begin
      fMensagem('', E.Message, ['&OK']);
      Result := False;
    End;}
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmContasPorEmpresa.fValidaCampos]');
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmContasPorEmpresa.mskCodConKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPlan: TConsultasArray;
    qryTplAco : TUniQuery;
begin

  If fEmptyStr(edtCodEmp.Text) Then
  Begin

    fMensagem('ATENÇÃO!','Obrigatório preenchimento da Empresa!',['&OK']);
    pSetFocus(edtCodEmp);

  End
  Else
  Begin

    Try
      qryTplAco := fCriaQuery(Self);
      qryTplAco.SQL.Add('SELECT EMP_TPLACO FROM CADEMP WHERE EMP_CODEMP = ' + edtCodEmp.Text);
      qryTplAco.Open;
      If fPesqPlanoContabil(Self, mskCodCon, edtDesCon, Nil, Key, arrPlan, True, qryTplAco.FieldByName('EMP_TPLACO').asString, True, True) Then
      begin
        if not fVerificaCampos then
        begin
          pSetFocus(mskCodCon);
          mskCodCon.SelectAll ;
          exit;
        end ;
        SelectNext(ActiveControl, True, True);
      end ;
    Finally
      qryTplAco.Close;
      FreeAndNil(qryTplAco);
    End;

  End;

end;

procedure TfrmContasPorEmpresa.pCarregaPlanoContabil(
  var ANatureza: String);
var
  strTplAco : string ;
begin
  strTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text], False);
  edtDesCon.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskCodCon.Text), strTplAco]);
  ANatureza := fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskCodCon.Text), strTplAco], False);
end;

procedure TfrmContasPorEmpresa.pCarregarDados;
begin
  if (not blnCriaDataSet) then
    exit;

  pCarregaDadosNCO(strTabela, strCampoChave, strValorChave, cdsDados) ;

end;

procedure TfrmContasPorEmpresa.pConfReadOnly;
begin
  btnGravar.Enabled := not FblnReadOnly ;
  btnAlterarRegistro.Enabled := not FblnReadOnly ;
  btnAdicionar.Enabled := not FblnReadOnly ;
  btnCancelar.Enabled := not FblnReadOnly ;
  edtCodEmp.Enabled := not FblnReadOnly ;
  mskCodCon.Enabled := not FblnReadOnly ;
end;

procedure TfrmContasPorEmpresa.pLimpar;
begin
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  mskCodCon.Clear;
  edtDesCon.Clear;
end;

end.
