unit untPaiOrdenaEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, BitBtnLockedIncrem,
  ComCtrls, MemDS, DBAccess, Provider, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient, untCfgGrid;

type
  TfrmPaiOrdenaEdit = class(TfrmPaiOrdena)
    btnCancela: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnIncluir: TBitBtnLocked;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    pnlInfBotoes: TPanel;
    Label1: TLabel;
    lblInf: TLabel;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsConsultaAfterDelete(DataSet: TDataSet);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure cdsConsultaBeforePost(DataSet: TDataSet);
    procedure mnuConfigurarRelClick(Sender: TObject);
  private
    { Private declarations }
    function fRetProximoCodVirtual: Integer;
  protected
    procedure pHabilitaControles(Habilitar:Boolean);virtual;
    procedure pOnStateChange; virtual;
  public
    { Public declarations }
    strNomTab  : String;
    strCamChave: String;
    blnUsaProxCodVirtual: Boolean;

    blnIncluiu,
    blnGravou,
    blnAlterou,
    blnExcluiu,
    blnCancelou,
    blnAutoCommit: Boolean;
    objCfgGrid: TCfgGrid;

    procedure pIniciaPesquisa;
  end;

var
  frmPaiOrdenaEdit: TfrmPaiOrdenaEdit;

implementation

uses untFuncoesSimples, untPai;

{$R *.dfm}

procedure TfrmPaiOrdenaEdit.pOnStateChange;
begin
  pSetButton(cdsConsulta, btnIncluir, btnGravar, btnExcluir, btnCancela, btnAlterar, btnPesquisar, btnSair);
  dbgConsulta.Enabled  := (Not (cdsConsulta.State In [dsInsert, dsEdit])) And (Not cdsConsulta.IsEmpty);
  btnMudaOrdem.Enabled := Not (cdsConsulta.State In [dsInsert, dsEdit]);
  edtData.Enabled      := Not (cdsConsulta.State In [dsInsert, dsEdit]);
  edtNumero.Enabled    := Not (cdsConsulta.State In [dsInsert, dsEdit]);
  edtString.Enabled    := Not (cdsConsulta.State In [dsInsert, dsEdit]);
  edtValor.Enabled     := Not (cdsConsulta.State In [dsInsert, dsEdit]);
end;

procedure TfrmPaiOrdenaEdit.btnIncluirClick(Sender: TObject);
  var
    strProxCod: String;
begin
  inherited;

  blnIncluiu := False;

  If cdsConsulta.Active Then
  Begin
    pgcDados.ActivePageIndex := 0;
    pLimpaPesquisa;

    With cdsConsulta, FieldByName(strCamChave) Do
    Begin

      If blnUsaProxCodVirtual Then
      Begin
        If DataType = ftString Then
          strProxCod := fStrZero(IntToStr(fRetProximoCodVirtual), Size)
        Else strProxCod := IntToStr(fRetProximoCodVirtual);
      End;

      Append;

      If blnUsaProxCodVirtual Then AsString := strProxCod;

    End;

    pHabilitaControles(True);
    pOnStateChange;
    SelectFirst;

    blnIncluiu := True;

  End;
end;

procedure TfrmPaiOrdenaEdit.btnGravarClick(Sender: TObject);
begin
  inherited;
  blnGravou := False;

  If ((cdsConsulta.State = dsInsert) Or (cdsConsulta.State = dsEdit)) And fVerificaCampos Then
  Begin
    cdsConsulta.Post;
    pLimpaPesquisa;
    pHabilitaControles(False);
    pOnStateChange;
    If btnIncluir.CanFocus Then pSetFocus(btnIncluir)
    Else If btnPesquisar.CanFocus Then pSetFocus(btnPesquisar);
    blnGravou := True;
  End;
end;

procedure TfrmPaiOrdenaEdit.btnAlterarClick(Sender: TObject);
begin
  inherited;
  blnAlterou := False;
  If Not cdsConsulta.IsEmpty Then
  Begin
    cdsConsulta.Edit;
    pHabilitaControles(True);
    pOnStateChange;
    SelectFirst;
    blnAlterou := True;    
  End
  Else
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
end;

procedure TfrmPaiOrdenaEdit.btnExcluirClick(Sender: TObject);
begin
  inherited;
  blnExcluiu := False;
  If Not cdsConsulta.IsEmpty Then
  Begin
    If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1 Then
    Begin
      cdsConsulta.Delete;
      pLimpaPesquisa;
      If btnIncluir.CanFocus Then pSetFocus(btnIncluir)
      Else If btnPesquisar.CanFocus Then pSetFocus(btnPesquisar);
    End;
    blnExcluiu := True;
  End
  Else
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
end;

procedure TfrmPaiOrdenaEdit.btnCancelaClick(Sender: TObject);
begin
  inherited;
  blnCancelou := False;
  If (cdsConsulta.State = dsInsert) Or (cdsConsulta.State = dsEdit) Then
  Begin
    cdsConsulta.Cancel;
    pLimpaPesquisa;
    pHabilitaControles(False);
    pOnStateChange;
    If btnIncluir.CanFocus Then pSetFocus(btnIncluir)
    Else If btnPesquisar.CanFocus Then pSetFocus(btnPesquisar);
    blnCancelou := True;
  End;
end;

procedure TfrmPaiOrdenaEdit.btnPesquisarClick(Sender: TObject);
begin
  If btnPesquisar.Enabled Then
  Begin
    btnCancela.Click;
    inherited;
  End;
end;

procedure TfrmPaiOrdenaEdit.cdsConsultaAfterDelete(DataSet: TDataSet);
begin
  inherited;

  If blnAutoCommit Then
    cdsConsulta.ApplyUpdates(0);
  
end;

procedure TfrmPaiOrdenaEdit.cdsConsultaAfterPost(DataSet: TDataSet);
begin
  inherited;

  If blnAutoCommit Then
    cdsConsulta.ApplyUpdates(0);
  
end;

procedure TfrmPaiOrdenaEdit.cdsConsultaBeforePost(DataSet: TDataSet);
begin
  inherited;

  With cdsConsulta Do
  If blnAutoCommit And (State = dsInsert) Then
  Begin
    FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(strNomTab, VS_strCodEmp);
  End;
  
end;

procedure TfrmPaiOrdenaEdit.btnMudaOrdemClick(Sender: TObject);
begin
  If btnMudaOrdem.Enabled Then
  Begin                              
    btnCancela.Click;
    inherited;
    if Assigned(objCfgGrid) Then
      objCfgGrid.GravaOrdColunaDbg(lflLastField.intIndCol, IIF(cdsConsulta.IndexName <> '',cdsConsulta.IndexName, cdsConsulta.IndexFieldNames));
  End;
end;

procedure TfrmPaiOrdenaEdit.FormCreate(Sender: TObject);
  var
    intCont: Integer;
begin
  inherited;
  cdsConsulta.Tag := 1;//Para Liberar Inserção
  blnSempreRelerBanco   := False;
  blnSelecionaComEnter  := False;
  blnSelecionaComEspaco := True;
  blnUsaProxCodVirtual  := True;
  blnAutoCommit         := False;

  blnIncluiu  := False;
  blnGravou   := False;
  blnAlterou  := False;
  blnExcluiu  := False;
  blnCancelou := False;

  For intCont := 0 To pnlBotoes.ControlCount -1 Do
    If pnlBotoes.Controls[intCont] Is TBitBtnLocked Then
      TBitBtnLocked(pnlBotoes.Controls[intCont]).Align := alLeft;

  btnSair.Align := alClient;
end;

procedure TfrmPaiOrdenaEdit.FormShow(Sender: TObject);
var LIndexName: string;
    LNomeCampo: string;
begin
  inherited;
  pIniciaPesquisa;
  If Assigned(objCfgGrid) then
  Begin
    objCfgGrid.pAjustaColunas(True);
    LIndexName := objCfgGrid.IndexOrdColunaDbg;
    if LIndexName <> '' then
    begin
      LNomeCampo := objCfgGrid.NomeColOrdColunaDbg;
      cdsConsulta.IndexDefs.Add(LIndexName, LNomeCampo, []);
      cdsConsulta.IndexName := LIndexName;
    end;
  End;
end;

procedure TfrmPaiOrdenaEdit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If Key = VK_F2 Then
  Begin
    btnCancela.Click;
    pSetFocus(dbgConsulta);
  End

  Else If (Key In [VK_F3, VK_F5, VK_ESCAPE]) And (cdsConsulta.State In [dsInsert, dsEdit]) Then
  Begin
    If (Key = VK_ESCAPE) And (fMensagem('', 'Deseja cancelar a edição desse registro?', ['', '']) = 1) Then
    Begin
      btnCancela.Click;
    End;
    Key := 0;
  End

  Else If (dbgConsulta.Focused) And (cdsConsulta.RecordCount > 0) And (Key In [VK_RETURN, VK_DELETE]) Then
  begin
    Case Key Of
      VK_RETURN:
        begin
          If btnAlterar.Visible And btnAlterar.Enabled Then
            btnAlterar.Click;
        end;
      VK_DELETE:
        begin
          If btnExcluir.Visible And btnExcluir.Enabled Then
            btnExcluir.Click;
        end;
    End;
  End

  Else
    inherited;

end;

function TfrmPaiOrdenaEdit.fRetProximoCodVirtual: Integer;
  var
    cdsTemp: TUniClientDataSet;
begin
  cdsTemp := TUniClientDataSet.Create(Self);
  cdsTemp.Data := cdsConsulta.Data;
  cdsTemp.IndexFieldNames := strCamChave;
  cdsTemp.Last;
  Result := cdsTemp.FieldByName(strCamChave).AsInteger + 1;
  FreeAndNil(cdsTemp);
end;

procedure TfrmPaiOrdenaEdit.mnuConfigurarRelClick(Sender: TObject);
begin
  inherited;
  // nao remover este comentario, pois o evento deixara de funcionar
  // esta vinculado ao direito de acesso ao frmcadconfrelatorio
  // rl
end;

procedure TfrmPaiOrdenaEdit.pIniciaPesquisa;
begin
  strCampoLista := strCamChave;
  fAbreConsulta;
  pHabilitaControles(False);
  pOnStateChange;
  stlListSelecao.Clear;
  pLimpaPesquisa;
  pSetFocus(btnIncluir);
end;

procedure TfrmPaiOrdenaEdit.pHabilitaControles(Habilitar:Boolean);
begin
  pEnabled(Self, Habilitar);
end;

end.
