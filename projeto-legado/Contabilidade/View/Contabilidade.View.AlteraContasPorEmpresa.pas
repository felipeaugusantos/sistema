unit Contabilidade.View.AlteraContasPorEmpresa;

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
  TfrmAlteraContasPorEmpresa = class(TfrmPaiContabilidade)
    Panel1: TPanel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtDesCon: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dtsDados: TDataSource;
    mskCodCon: TMaskEditFocus;
    btnAdicionar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure mskCodConKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    strMascara : String;
    function fContaTemDuplicidade(const strCodEmp, strCreDeb: String): Boolean;
    function fContaJaInformada(const ACodigoEmpresa, APlanoConta: string): Boolean;
    procedure pCarregaPlanoContabil(var ANatureza: String);
  public
    { Public declarations }
    cdsDados : TUniClientDataSet;
    strCreDeb: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, Contabilidade.Funcoes, untTypesSistema, untConsultas,
     Contabilidade.Consultas, Uni, System.MaskUtils, System.StrUtils;

{$R *.dfm}

{ TfrmAlteraContasPorEmpresa }

procedure TfrmAlteraContasPorEmpresa.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If fContaTemDuplicidade(edtCodEmp.Text, strCreDeb) Then
  begin
    fMensagem('ATENÇÃO!', 'Existe uma duplicidade nos registros [ Empresa: '+edtCodEmp.Text+' - Natureza: "'+strCreDeb+'" ], favor verificar!',['&OK']);
    pSetFocus(btnAdicionar);
    Exit;
  end;

  if not fVerificaCampos then
    exit;

  if (fContaJaInformada(edtCodEmp.Text, fSemMascaraPlaNco(mskCodCon.Text))) then
  begin
    fMensagem('ATENÇÃO!', 'Esses dados já foram inseridos, favor verificar!',['&OK']);
    pSetFocus(btnAdicionar);
    Exit;
  end;

  cdsDados.Edit;
  cdsDados.FieldByName('CODEMP').AsString := edtCodEmp.Text;
  cdsDados.FieldByName('CODCON').AsString := fSemMascaraPlaNco(mskCodCon.Text);
  cdsDados.FieldByName('CONMSK').AsString := FormatMaskText(strMascara, fSemMascaraPlaNco(mskCodCon.Text));
  cdsDados.Post;
  Close;
end;

procedure TfrmAlteraContasPorEmpresa.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp : TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmAlteraContasPorEmpresa.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodEmp);
end;

procedure TfrmAlteraContasPorEmpresa.FormCreate(Sender: TObject);
begin
  inherited;
  strMascara := fMskCon;
  mskCodCon.EditMask := strMascara;
end;

function TfrmAlteraContasPorEmpresa.fValidaCampos(Sender: TWinControl;
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
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmAlteraContasPorEmpresa.fValidaCampos]');
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmAlteraContasPorEmpresa.mskCodConKeyPress(Sender: TObject;
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

procedure TfrmAlteraContasPorEmpresa.pCarregaPlanoContabil(
  var ANatureza: String);
var
  strTplAco : string ;
begin
  strTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text], False);
  edtDesCon.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskCodCon.Text), strTplAco], False);
  ANatureza := fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskCodCon.Text), strTplAco], False);
end;

function TfrmAlteraContasPorEmpresa.fContaTemDuplicidade(const strCodEmp, strCreDeb: String): Boolean;
  Var
    cdsCloneDados: TUniClientDataSet;
Begin
  Result := False;

  cdsCloneDados := TUniClientDataSet.Create(nil);
  try
    cdsCloneDados.CloneCursor(cdsDados, False, False);
    cdsCloneDados.First;
    While Not cdsCloneDados.Eof do
    Begin
      if (cdsCloneDados.FieldByName('CODEMP').AsString = cdsDados.FieldByName('CODEMP').AsString) and
         (cdsCloneDados.FieldByName('CREDEB').AsString = cdsDados.FieldByName('CREDEB').AsString) then
      begin
        cdsCloneDados.Next;
        continue ;
      end ;

      If (cdsCloneDados.FieldByName('CODEMP').AsString = strCodEmp) And
         (cdsCloneDados.FieldByName('CREDEB').AsString = strCreDeb) Then
        Result := True;
      cdsCloneDados.Next;
    End;
    cdsCloneDados.Close;
  finally
    FreeAndNil(cdsCloneDados);
  end ;
End;

function TfrmAlteraContasPorEmpresa.fContaJaInformada(const ACodigoEmpresa, APlanoConta: string): Boolean;
  Var
    cdsClone : TUniClientDataSet;
Begin
  cdsClone := TUniClientDataSet.Create(nil);
  try
    pCloneDataSet(cdsClone, cdsDados);
    cdsClone.IndexFieldNames := 'CODEMP;CODCON';
    Result := cdsClone.FindKey([ACodigoEmpresa, APlanoConta]);
    cdsClone.Close;
  finally
    FreeAndNil(cdsClone);
  end;
End;

end.
