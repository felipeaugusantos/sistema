unit untRelEstItemsAcimaMax_ItensOrc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, BitBtnLockedIncrem, MemDS,
  DBAccess, Datasnap.DBClient, Datasnap.Provider, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxGridCitel;

type
  TfrmRelEstItemsAcimaMax_ItensOrc = class(TfrmPaiOrdena)
    lblEmpresa: TLabel;
    lbl1: TLabel;
    btnGravar: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    dtsEmpresaDistribuidor: TDataSource;
    pnlEmpresasDistribuicao: TPanel;
    cxDistrib: TcxGridCitel;
    cxgDistrib: TcxGridDBTableViewCitel;
    cxgDistribEMPRESA: TcxGridDBColumn;
    cxgDistribCODITE: TcxGridDBColumn;
    cxgDistribITE_SALDOS: TcxGridDBColumn;
    cxgDistribITE_ESTMAX: TcxGridDBColumn;
    cxgDistribITE_SALTRA: TcxGridDBColumn;
    cxlDistrib: TcxGridLevel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    btnMarcarDesmarcarExclusao: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure qryConsultaAfterScroll(DataSet: TDataSet);
    procedure cxgDistribITE_SALTRAPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnMarcarDesmarcarExclusaoClick(Sender: TObject);
  private
    { Private declarations }
    blnMarcaTodos: Boolean;
    FEspDoc: String;
    function fHabilitaEdicaoDbgConsulta: Boolean;
    function fProximoDbgConsulta: Boolean;
    procedure pApagarSelecionadosParaExclusao;
    Function fVerificaTamanhoTela: Boolean;

  public
    { Public declarations }
    strSQLGen : String;
    blnConfirma : Boolean;
    strEmpresaAbastecedo: String;
    strEmpresaAbastecida: String;
    blnDistribuido: Boolean;


    dtsEmpresaDistribuicao: TDataSet;

    property strEspDoc: String read FEspDoc write FEspDoc;

  protected
    function fGetSql(blnLike: Boolean): String; Override;
    procedure pAddListaQuery; Override;
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmRelEstItemsAcimaMax_ItensOrc }

procedure TfrmRelEstItemsAcimaMax_ItensOrc.btnDesmarcaTodosClick(
  Sender: TObject);
Var
  intRecNo: Integer;
  strAuto  : String;
  intIndex : integer;
begin
  inherited;
  blnMarcaTodos := FALSE;

  intRecNo := cdsConsulta.RecNo;
  cdsConsulta.DisableControls;

  cdsConsulta.First;
  While Not cdsConsulta.Eof Do
  Begin
    cdsConsulta.Edit;
    cdsConsulta.FieldByName('MARDES').AsString := 'D';
    cdsConsulta.Post;

    strAuto  := '''' + cdsConsulta.Fieldbyname('AUTOINCREM').AsString + '''';
    intIndex := stlListSelecao.IndexOf(strAuto);
    If intIndex > -1 then
    Begin
      stlListSelecao.Delete(intIndex);
      pAcaoDel;
    End;

    cdsConsulta.Next;
  End;

  dbgConsulta.Refresh;

  cdsConsulta.EnableControls;
  cdsConsulta.RecNo := intRecNo;
end;

procedure TfrmRelEstItemsAcimaMax_ItensOrc.btnGravarClick(Sender: TObject);
begin
  inherited;
  If (cdsConsulta.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não há nenhum produto, portanto o orçamento não será gerado!', ['&Ok']);
    Exit;
  End;

  cdsConsulta.DisableControls;

  cdsConsulta.Filter := 'MARDES = ' + QuotedStr('M');
  cdsConsulta.Filtered := True;

  If Not(fEmptyStr(fCfgSis('QTDMPV', varString))) Then
  Begin
    If (strEspDoc = 'PD') Then
    Begin
      If cdsConsulta.RecordCount > fCfgSis('QTDMPV', varString) Then
      Begin
        pMensagemOk('Não é permitido selecionar mais de: '+fCfgSis('QTDMPV', varString)+' itens'+
                    ' conforme definido na CFG_QTDMPV!');
        blnConfirma := False;
        cdsConsulta.Filtered := False;
        cdsConsulta.EnableControls;
        Exit;
      End;
    End;
  End;

  If cdsConsulta.IsEmpty Then
  Begin
    If fMensagem('','Nenhum item foi selecionado, portanto, o orçamento não será gerado!' + #13#10 + 'Deseja continuar?',  ['&Sim', '&Não']) = 1 Then
    Begin
      blnConfirma := True;
      close;
    End
    Else
    Begin
      cdsConsulta.Filtered := False;
      cdsConsulta.EnableControls;
      Exit;
    End;
  End
  Else
  Begin
    blnConfirma := True;
    close;
  End;
end;

procedure TfrmRelEstItemsAcimaMax_ItensOrc.btnMarcarDesmarcarExclusaoClick(
  Sender: TObject);
begin
  inherited;
  pApagarSelecionadosParaExclusao;
end;

procedure TfrmRelEstItemsAcimaMax_ItensOrc.btnMarcaTodosClick(Sender: TObject);
Var
  intRecNo : Integer;
  strAuto  : String;
  intIndex : integer;
begin
  inherited;
  blnMarcaTodos := TRUE;

  intRecNo := cdsConsulta.RecNo;
  cdsConsulta.DisableControls;

  cdsConsulta.First;
  While Not cdsConsulta.Eof Do
  Begin
    cdsConsulta.Edit;
    cdsConsulta.FieldByName('MARDES').AsString := 'M';
    cdsConsulta.Post;

    strAuto  := '''' + cdsConsulta.Fieldbyname('AUTOINCREM').AsString + '''';
    intIndex := stlListSelecao.IndexOf(strAuto);
    If intIndex <= -1 then
    Begin
      stlListSelecao.Add(strAuto);
      pAcaoAdd;
    End;

    cdsConsulta.Next;
  End;

  dbgConsulta.Refresh;

  cdsConsulta.EnableControls;
  cdsConsulta.RecNo := intRecNo;
end;

procedure TfrmRelEstItemsAcimaMax_ItensOrc.btnSairClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmRelEstItemsAcimaMax_ItensOrc.cxgDistribITE_SALTRAPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);

  var fltVariacao: Double;
begin
  inherited;
  If Not fVerificaAcessoSistema('SAMALT', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso. Permitir alterar a quantidade de produtos na tela de Itens do Orçamento no Relatório de Estoque acima do Máximo', ['&Ok']);
    DisplayValue :=  dtsEmpresaDistribuicao.FieldByName('ITE_SALUSO').AsFloat;
  End
  Else
  Begin
    fltVariacao := dtsEmpresaDistribuicao.FieldByName('ITE_SALUSO').AsFloat - DisplayValue;

    If (cdsConsulta.FieldByName('SALUSO').AsFloat + fltVariacao) < 0 Then
    Begin
      pMensagemOk('Valor informado maior que o disponivel.');
      DisplayValue :=  dtsEmpresaDistribuicao.FieldByName('ITE_SALUSO').AsFloat;
    End
    Else
    Begin
      dtsEmpresaDistribuicao.FieldByName('ITE_SALUSO').AsFloat := DisplayValue;
      dtsEmpresaDistribuicao.FieldByName('ITE_SALTRA').AsFloat := DisplayValue;
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('SALUSO').AsFloat := cdsConsulta.FieldByName('SALUSO').AsFloat +  fltVariacao;
      cdsConsulta.Post;
    End;
  End;
end;

function TfrmRelEstItemsAcimaMax_ItensOrc.fGetSql(blnLike: Boolean): String;
begin
  Result := strSQLgen;
end;

function TfrmRelEstItemsAcimaMax_ItensOrc.fHabilitaEdicaoDbgConsulta: Boolean;
begin
  Result :=cdsConsulta.Active;
  If Result Then
   Result :=  (Not blnDistribuido);
end;

function TfrmRelEstItemsAcimaMax_ItensOrc.fProximoDbgConsulta: Boolean;
Begin
 Result := blnDistribuido;
 If Result Then
   Result := (dbgConsulta.Focused);
 If Result Then
   Result := (Not (dtsEmpresaDistribuicao.State = dsEdit));
End;

function TfrmRelEstItemsAcimaMax_ItensOrc.fVerificaTamanhoTela: Boolean;
begin
  Result := False;
  If ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
  Begin
    Result := True;
    Exit;
  End;

  If (Screen.Width <= 1366) Then
    Result := True
end;

procedure TfrmRelEstItemsAcimaMax_ItensOrc.FormCreate(Sender: TObject);
begin
  inherited;
  If fVerificaTamanhoTela Then
    Self.WindowState := wsMaximized;

  blnSelecionaComEnter := False;
  blnSempreRelerBanco  := False;
  blnMarcaTodos        := False;
  blnDistribuido := False;
  FEspDoc := 'PD';
end;

procedure TfrmRelEstItemsAcimaMax_ItensOrc.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  Var
    fltNecAnt: Double;
begin
  inherited;

  Case Key Of
    VK_DELETE: pApagarSelecionadosParaExclusao;
    VK_F6    : btnDesmarcaTodos.Click;
    VK_F7    : btnMarcaTodos.Click;
    VK_F10   : Begin
                 btnGravar.Click;
                 Key := 0;
               End;

    VK_RETURN: If cdsConsulta.State = dsEdit Then
               Begin
                 fltNecAnt := cdsConsulta.FieldByName('NECCOM').AsFloat;
                 dbgConsulta.Options := dbgConsulta.Options - [dgEditing];
                 cdsConsulta.Post;

                 If Not fVerificaAcessoSistema('SAMALT', strLoginUsuarioLogado) Then
                 Begin
                   fMensagem('', 'Esse usuário não tem acesso a esse recurso. Permitir alterar a quantidade de produtos na tela de Itens do Orçamento no Relatório de Estoque acima do Máximo', ['&Ok']);
                   cdsConsulta.Edit;
                   cdsConsulta.FieldByName('NECCOM').AsFloat := fltNecAnt;
                   cdsConsulta.Post;
                   Exit;
                 End;

                 If cdsConsulta.FieldByName('NECCOM').AsFloat > 0 Then
                 Begin
                   cdsConsulta.Next;
                   dbgConsulta.SelectedField := cdsConsulta.FieldByName('NECCOM');
                 End
                 Else
                 Begin
                   fMensagem('', 'Quantidade deve ser maior que zero (0)!', ['&Ok']);
                   cdsConsulta.Edit;
                   cdsConsulta.FieldByName('NECCOM').AsFloat := fltNecAnt;
                   cdsConsulta.Post;
                   Exit;
                 End;

               End
               Else
               Begin

                 If fHabilitaEdicaoDbgConsulta Then
                 Begin
                   dbgConsulta.Options := dbgConsulta.Options + [dgEditing];
                   cdsConsulta.Edit;

                   dbgConsulta.SelectedField := cdsConsulta.FieldByName('NECCOM');
                 End
                 Else If fProximoDbgConsulta Then
                   cdsConsulta.Next;

               End;

    VK_SPACE : Begin
                 dbgConsulta.Options := dbgConsulta.Options - [dgEditing];
                 pAddListaQuery;
                 Key := 0;
               End;
  Else
    inherited;

  End;
end;

procedure TfrmRelEstItemsAcimaMax_ItensOrc.FormShow(Sender: TObject);
begin
  inherited;
//  splDivisor.Visible := False;
  pnlEmpresasDistribuicao.Visible := False;

  lflLastField.intIndCol := 1;
  lflLastField.strNomCam := dbgConsulta.Columns[1].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[1].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  blnSempreRelerBanco := False;

  dtsEmpresaDistribuidor.DataSet := dtsEmpresaDistribuicao;

  dbgConsulta.Columns[3].Title.Caption := 'Saldo '+strEmpresaAbastecedo;
  dbgConsulta.Columns[4].Title.Caption := 'Ext. Máximo '+strEmpresaAbastecedo;
  If Not blnDistribuido Then
  Begin
    dbgConsulta.Columns[5].Title.Caption := 'Saldo '+strEmpresaAbastecida;
    dbgConsulta.Columns[6].Title.Caption := 'Ext. Máximo '+strEmpresaAbastecida;
  End
  Else
  Begin
    dbgConsulta.Columns[8].Visible := True;

    dbgConsulta.Columns[5].Visible := False;
    dbgConsulta.Columns[6].Visible := False;
  End;

  TFloatField(cdsConsulta.Fieldbyname('NECCOM')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.Fieldbyname('ESTMAX')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.Fieldbyname('SALDOS')).DisplayFormat := '#,##0.000';
  TFloatField(cdsConsulta.Fieldbyname('ESTMAXABS')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.Fieldbyname('SALDOSABS')).DisplayFormat := '#,##0.000';
  TFloatField(cdsConsulta.Fieldbyname('SALUSO')).DisplayFormat := '#,##0.00';

  If blnDistribuido Then
  Begin
    TFloatField(dtsEmpresaDistribuicao.Fieldbyname('ITE_SALDOS')).DisplayFormat := '#,##0.000';
    TFloatField(dtsEmpresaDistribuicao.Fieldbyname('ITE_ESTMAX')).DisplayFormat := '#,##0.000';
    TFloatField(dtsEmpresaDistribuicao.Fieldbyname('ITE_SALTRA')).DisplayFormat := '#,##0.000';
    cdsConsulta.afterScroll := qryConsulta.AfterScroll;
    cdsConsulta.First;
//    splDivisor.Visible := True;
    pnlEmpresasDistribuicao.Visible := True;
    pnlHeader.Visible := False;

  End;

end;

procedure TfrmRelEstItemsAcimaMax_ItensOrc.pAddListaQuery;
var
  strAuto  : String;
  intIndex : integer;
begin
  If blnTemSelecao Then
  Begin
    strAuto  := '''' + cdsConsulta.Fieldbyname('AUTOINCREM').AsString + '''';
    intIndex := stlListSelecao.IndexOf(strAuto);
    If intIndex > -1 then
    Begin
      stlListSelecao.Delete(intIndex);

      cdsConsulta.Edit;
      cdsConsulta.FieldByName('MARDES').AsString := 'D';
      cdsConsulta.Post;

      pAcaoDel;
    End
    Else
    Begin
      stlListSelecao.Add(strAuto);

      cdsConsulta.Edit;
      cdsConsulta.FieldByName('MARDES').AsString := 'M';
      cdsConsulta.Post;

      pAcaoAdd;
    End;
  End;
end;

procedure TfrmRelEstItemsAcimaMax_ItensOrc.pApagarSelecionadosParaExclusao;
begin
  If Not fVerificaAcessoSistema('SAMEXC', strLoginUsuarioLogado) Then
    fMensagem('', 'Esse usuário não tem acesso a esse recurso. Permitir exlusão de produtos na tela de Itens do Orçamento no Relatório de Estoque acima do Máximo', ['&Ok'])
  Else If fMensagem('','Tem certeza que deseja excluir o produto '+cdsConsulta.FieldByName('CODITE').AsString+'-'+cdsConsulta.FieldByName('DESITE').AsString+' ?',  ['&Sim', '&Não']) = 1 Then
  Begin
    cdsConsulta.Delete;
  End;
end;

procedure TfrmRelEstItemsAcimaMax_ItensOrc.qryConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If blnDistribuido Then
  Begin
    TClientDataSet(dtsEmpresaDistribuidor.DataSet).Filtered := False;
    TClientDataSet(dtsEmpresaDistribuidor.DataSet).Filter := 'CODITE = ' + QuotedStr(cdsConsulta.FieldByName('CODITE').AsString);
    TClientDataSet(dtsEmpresaDistribuidor.DataSet).Filtered := True;
  End;
end;

end.
