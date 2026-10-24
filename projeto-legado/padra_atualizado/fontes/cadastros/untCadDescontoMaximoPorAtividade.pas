unit untCadDescontoMaximoPorAtividade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxClasses, cxGridLevel, cxGrid, EditFocus, Uni,
  Data.DB, Datasnap.DBClient, UniClientDataSet, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGridDBTableView, cxGridCitel,
  cxCurrencyEdit;

type
  TfrmCadDescontoMaximoPorAtividade = class(TfrmPai)
    pnlCabecalho: TPanel;
    pnlRodape: TPanel;
    btnGravar: TBitBtnLocked;
    btnReplicarParaTodasAsAtividades: TBitBtnLocked;
    cdsAtividades: TUniClientDataSet;
    cdsAtividadesCODATI: TStringField;
    cdsAtividadesDESATI: TStringField;
    cdsAtividadesDESMAX: TFloatField;
    cdsAtividadesDESMSU: TFloatField;
    cdsAtividadesDESMGE: TFloatField;
    cdsAtividadesDESMVM: TFloatField;
    cdsAtividadesDESMSM: TFloatField;
    cdsAtividadesDESMGM: TFloatField;
    dtsAtividades: TDataSource;
    cxAtividades: TcxGridCitel;
    cxAtividadesView: TcxGridDBTableViewCitel;
    cxAtividadesLevel1: TcxGridLevel;
    cxAtividadesViewCODATI: TcxGridDBColumn;
    cxAtividadesViewDESATI: TcxGridDBColumn;
    cxAtividadesViewDESMAX: TcxGridDBColumn;
    cxAtividadesViewDESMSU: TcxGridDBColumn;
    cxAtividadesViewDESMGE: TcxGridDBColumn;
    cxAtividadesViewDESMVM: TcxGridDBColumn;
    cxAtividadesViewDESMSM: TcxGridDBColumn;
    cxAtividadesViewDESMGM: TcxGridDBColumn;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    cdsAtividadesAUTINC: TStringField;
    cdsAtividadesCODEMP: TStringField;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cdsAtividadesNewRecord(DataSet: TDataSet);
    procedure btnReplicarParaTodasAsAtividadesClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

    qryConEmp: TUniQuery;
    procedure pCarregaEmpresa;
    function  fInformouEmpresa : Boolean;
    function  fExisteAtividadesEmBanco : Boolean;
    procedure pCarregarAtividades;
    procedure pValidaHierarquiaBeforePost(DataSet: TDataSet);

    procedure pLimparDados;
    procedure pTelaEmModoEdicao;
    procedure pTelaEmModoPadrao;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public

  end;

var
  frmCadDescontoMaximoPorAtividade: TfrmCadDescontoMaximoPorAtividade;

implementation

uses
  untTypesSistema, untConsultas, untfuncoesSimples, untPesqAux,
  untValidaHierarquia;

{$R *.dfm}

procedure TfrmCadDescontoMaximoPorAtividade.btnGravarClick(Sender: TObject);
const
  SQL = 'SELECT * FROM DESMAX WHERE AUTOINCREM = :AUTINC';
  ALL = 'SELECT * FROM DESMAX WHERE FALSE';
var
  qryAux : TUniQuery;
  blnNew : Boolean;
  blnGrv : Boolean;
begin

  inherited;

  blnGrv := False;

  If cdsAtividades.IsEmpty Then
    Exit;

  If fMensagem('Atenção', 'Deseja gravar as alterações?', ['&Sim', '&Não'], 1) = 2 Then
    Exit;

  qryAux := fCriarQuery(ALL, Self);
  qryAux.Open;

  cxAtividades.BeginUpdate();

  Try

    Screen.Cursor := crHourGlass;

    fStartTransaction;

    Try

      cdsAtividades.First;
      blnNew := fEmptyStr(cdsAtividadesAUTINC.AsString);

      While Not cdsAtividades.Eof Do
      Begin

        If blnNew Then
        Begin
          qryAux.Append;
          qryAux.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DESMAX', VS_strCodEmp);
        End
        Else
        Begin

          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Add(SQL);
          qryAux.ParamByName('AUTINC').AsString := cdsAtividadesAUTINC.AsString;

          qryAux.Open;
          qryAux.Edit;

        End;

        qryAux.FieldByName('MAX_CODEMP').AsString := cdsAtividadesCODEMP.AsString;
        qryAux.FieldByName('MAX_CODATI').AsString := cdsAtividadesCODATI.AsString;

        qryAux.FieldByName('MAX_DESMAX').AsFloat := cdsAtividadesDESMAX.AsFloat;
        qryAux.FieldByName('MAX_DESMSU').AsFloat := cdsAtividadesDESMSU.AsFloat;
        qryAux.FieldByName('MAX_DESMGE').AsFloat := cdsAtividadesDESMGE.AsFloat;
        qryAux.FieldByName('MAX_DESMVM').AsFloat := cdsAtividadesDESMVM.AsFloat;
        qryAux.FieldByName('MAX_DESMSM').AsFloat := cdsAtividadesDESMSM.AsFloat;
        qryAux.FieldByName('MAX_DESMGM').AsFloat := cdsAtividadesDESMGM.AsFloat;
        qryAux.Post;

        cdsAtividades.Next;

      End;

      blnGrv := fCommit;

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;

    End;

  Finally
    cxAtividades.EndUpdate();
    Screen.Cursor := crDefault;

    If (blnGrv) Then
    Begin
      fMensagem('','Gravação realizada com sucesso!',['&OK']);
      pTelaEmModoPadrao;
    End;

  End;

end;

procedure TfrmCadDescontoMaximoPorAtividade.btnReplicarParaTodasAsAtividadesClick(Sender: TObject);
var
  fltDESMAX,
  fltDESMSU,
  fltDESMGE,
  fltDESMVM,
  fltDESMSM,
  fltDESMGM : Double;

  Posicao : TBookmark;

begin

  inherited;

  If cdsAtividades.IsEmpty Then
    Exit;

  If fMensagem('Atenção', 'Deseja replicar os valores desse registro para todos os demais?', ['&Sim', '&Não'], 1) = 2 Then
    Exit;

  Posicao := cdsAtividades.GetBookmark;

  fltDESMAX := cdsAtividadesDESMAX.AsFloat;
  fltDESMSU := cdsAtividadesDESMSU.AsFloat;
  fltDESMGE := cdsAtividadesDESMGE.AsFloat;
  fltDESMVM := cdsAtividadesDESMVM.AsFloat;
  fltDESMSM := cdsAtividadesDESMSM.AsFloat;
  fltDESMGM := cdsAtividadesDESMGM.AsFloat;

  cxAtividades.BeginUpdate();

  Try

    cdsAtividades.First;
    While Not cdsAtividades.Eof Do
    Begin
      cdsAtividades.Edit;
      cdsAtividadesDESMAX.AsFloat := fltDESMAX;
      cdsAtividadesDESMSU.AsFloat := fltDESMSU;
      cdsAtividadesDESMGE.AsFloat := fltDESMGE;
      cdsAtividadesDESMVM.AsFloat := fltDESMVM;
      cdsAtividadesDESMSM.AsFloat := fltDESMSM;
      cdsAtividadesDESMGM.AsFloat := fltDESMGM;
      cdsAtividades.Post;
      cdsAtividades.Next;
    End;

  Finally
    cxAtividades.EndUpdate();

    If cdsAtividades.BookmarkValid(Posicao) Then
      cdsAtividades.GotoBookmark(Posicao);

  End;

end;

procedure TfrmCadDescontoMaximoPorAtividade.cdsAtividadesNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('DESMAX').AsFloat := 0;
  DataSet.FieldByName('DESMSU').AsFloat := 0;
  DataSet.FieldByName('DESMGE').AsFloat := 0;
  DataSet.FieldByName('DESMVM').AsFloat := 0;
  DataSet.FieldByName('DESMSM').AsFloat := 0;
  DataSet.FieldByName('DESMGM').AsFloat := 0;
end;

procedure TfrmCadDescontoMaximoPorAtividade.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  if fPesqEmpresa( conEmpSimples,
                   Self,
                   edtCodEmp,
                   edtDesEmp,
                   qryConEmp,
                   Key,
                   arrSel)  then
  Begin
    If (fValidaCampos(edtCodEmp, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadDescontoMaximoPorAtividade.fExisteAtividadesEmBanco: Boolean;
const
  SQL_EXISTE       = 'SELECT COUNT(*) AS QTD FROM DESMAX WHERE MAX_CODEMP = :CODEMP';
  SQL_EXISTE_VAZIO = 'SELECT COUNT(*) AS QTD FROM DESMAX WHERE (MAX_CODEMP IS NULL) OR (MAX_CODEMP = "")';
var
  qryAux : TUniQuery;
begin

  qryAux := fCriaQuery;

  Try

    qryAux.Close;
    qryAux.SQL.CLear;
    qryAux.SQL.Add(IIF(fInformouEmpresa, SQL_EXISTE, SQL_EXISTE_VAZIO));

    If fInformouEmpresa Then
      qryAux.ParamByName('CODEMP').AsString := edtCodEmp.Text;

    qryAux.Open;

    Result := (qryAux.RecordCount > 0) And (qryAux.FieldByName('QTD').AsInteger > 0);

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmCadDescontoMaximoPorAtividade.fInformouEmpresa: Boolean;
begin
  Result := Not fEmptyStr(edtCodEmp.Text);
end;

procedure TfrmCadDescontoMaximoPorAtividade.FormCreate(Sender: TObject);
begin
  inherited;

  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);

  cdsAtividades.CreateDataSet;
  cdsAtividades.EmptyDataSet;
  pTelaEmModoPadrao;

end;

procedure TfrmCadDescontoMaximoPorAtividade.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  If (Key = VK_F12) Then
  Begin
    If btnReplicarParaTodasAsAtividades.Enabled Then
      btnReplicarParaTodasAsAtividadesClick(Self);
  End
  Else
  If (Key = VK_F10) Then
  Begin
    If btnGravar.Enabled Then
      btnGravarClick(Self);
  End
  Else
  If (Key = VK_ESCAPE) Then
  Begin

    If Not cdsAtividades.IsEmpty Then
    Begin
      If fMensagem('Atenção', 'Deseja realmente cancelar as alterações?', ['&Sim', '&Não'], 1) = 1 Then
      Begin
        pTelaEmModoPadrao;
        Exit;
      End;
    End;

  End;

  inherited;

end;

function TfrmCadDescontoMaximoPorAtividade.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
Begin

  Result := True;

  Try

    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin

      If (Sender = edtCodEmp) Then
      Begin

        If (Not fEmptyStr(edtCodEmp.Text)) Then
        Begin

          pCarregaEmpresa;

          If (qryConEmp.FieldByName('EMP_CODEMP').IsNull) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa não está cadastrada!', ['OK']);
            Exit(False);
          End;

        End
        Else
          edtDesEmp.Text := 'Todas';

        pCarregarAtividades;

      End;

    End;

  Finally

    If Not Result Then
      pSetFocus(Sender);

  End;

End;

procedure TfrmCadDescontoMaximoPorAtividade.pCarregaEmpresa;
begin
  pPesquisaCadEmp(Nil, qryConEmp, edtCodEmp.Text);
  EdtDesEmp.Text := qryConEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmCadDescontoMaximoPorAtividade.pCarregarAtividades;
const
  SQL_LOAD = 'SELECT                    ' +
             '  D.AUTOINCREM AS AUTINC, ' +
             '  D.MAX_CODEMP AS CODEMP, ' +
             '  D.MAX_CODATI AS CODATI, ' +
             '  A.ATI_DESATI AS DESATI, ' +
             '  D.MAX_DESMAX AS DESMAX, ' +
             '  D.MAX_DESMSU AS DESMSU, ' +
             '  D.MAX_DESMGE AS DESMGE, ' +
             '  D.MAX_DESMVM AS DESMVM, ' +
             '  D.MAX_DESMSM AS DESMSM, ' +
             '  D.MAX_DESMGM AS DESMGM  ' +
             'FROM            ' +
             '  DESMAX D      ' +
             '  INNER JOIN CADATI A ON (A.ATI_CODATI = D.MAX_CODATI) ' +
             'WHERE                    ' +
             '  D.MAX_CODEMP = :CODEMP ' +
             'ORDER BY       ' +
             '  A.ATI_DESATI ';

  SQL_LOAD_VAZIO = 'SELECT                    ' +
                   '  D.AUTOINCREM AS AUTINC, ' +
                   '  D.MAX_CODEMP AS CODEMP, ' +
                   '  D.MAX_CODATI AS CODATI, ' +
                   '  A.ATI_DESATI AS DESATI, ' +
                   '  D.MAX_DESMAX AS DESMAX, ' +
                   '  D.MAX_DESMSU AS DESMSU, ' +
                   '  D.MAX_DESMGE AS DESMGE, ' +
                   '  D.MAX_DESMVM AS DESMVM, ' +
                   '  D.MAX_DESMSM AS DESMSM, ' +
                   '  D.MAX_DESMGM AS DESMGM  ' +
                   'FROM            ' +
                   '  DESMAX D      ' +
                   '  INNER JOIN CADATI A ON (A.ATI_CODATI = D.MAX_CODATI) ' +
                   'WHERE                                           ' +
                   '  (D.MAX_CODEMP IS NULL) OR (D.MAX_CODEMP = "") ' +
                   'ORDER BY       ' +
                   '  A.ATI_DESATI ';

  SQL_NOVO = 'SELECT ATI_CODATI AS CODATI, ATI_DESATI AS DESATI FROM CADATI ORDER BY ATI_DESATI';

var
  qryAux : TUniQuery;
  blnNew : Boolean;
begin

  qryAux := fCriaQuery;

  cxAtividades.BeginUpdate();
  cdsAtividades.BeforePost := Nil;

  Try

    blnNew := Not fExisteAtividadesEmBanco;

    qryAux.Close;
    qryAux.SQL.Clear;

    qryAux.SQL.Add(IIF(blnNew, SQL_NOVO, IIF(fInformouEmpresa, SQL_LOAD, SQL_LOAD_VAZIO)));

    If (fInformouEmpresa) And (Not blnNew) Then
      qryAux.ParamByName('CODEMP').AsString := edtCodEmp.Text;

    qryAux.Open;

    qryAux.First;
    cdsAtividades.EmptyDataSet;

    While Not qryAux.Eof Do
    Begin

      cdsAtividades.Append;

      cdsAtividadesCODEMP.AsString := edtCodEmp.Text;
      cdsAtividadesCODATI.AsString := qryAux.FieldByName('CODATI').AsString;
      cdsAtividadesDESATI.AsString := qryAux.FieldByName('DESATI').AsString;

      If blnNew Then
      Begin
        cdsAtividadesAUTINC.AsString := '';
        cdsAtividadesDESMAX.AsFloat  := 0;
        cdsAtividadesDESMSU.AsFloat  := 0;
        cdsAtividadesDESMGE.AsFloat  := 0;
        cdsAtividadesDESMVM.AsFloat  := 0;
        cdsAtividadesDESMSM.AsFloat  := 0;
        cdsAtividadesDESMGM.AsFloat  := 0;
      End
      Else
      Begin
        cdsAtividadesAUTINC.AsString := qryAux.FieldByName('AUTINC').AsString;
        cdsAtividadesDESMAX.AsFloat  := qryAux.FieldByName('DESMAX').AsFloat;
        cdsAtividadesDESMSU.AsFloat  := qryAux.FieldByName('DESMSU').AsFloat;
        cdsAtividadesDESMGE.AsFloat  := qryAux.FieldByName('DESMGE').AsFloat;
        cdsAtividadesDESMVM.AsFloat  := qryAux.FieldByName('DESMVM').AsFloat;
        cdsAtividadesDESMSM.AsFloat  := qryAux.FieldByName('DESMSM').AsFloat;
        cdsAtividadesDESMGM.AsFloat  := qryAux.FieldByName('DESMGM').AsFloat;
      End;

      cdsAtividades.Post;

      qryAux.Next;

    End;

    If Not cdsAtividades.IsEmpty Then
      pTelaEmModoEdicao;

  Finally
    cdsAtividades.BeforePost := pValidaHierarquiaBeforePost;
    cxAtividades.EndUpdate();
    FreeAndNil(qryAux);
  End;

end;

procedure TfrmCadDescontoMaximoPorAtividade.pLimparDados;
begin

  edtCodEmp.Clear;
  edtDesEmp.Clear;

  If Not cdsAtividades.IsEmpty Then
    cdsAtividades.EmptyDataSet;

end;

procedure TfrmCadDescontoMaximoPorAtividade.pTelaEmModoEdicao;
begin
  pnlCabecalho.Enabled := False;
  cxAtividades.Enabled := True;
  btnGravar.Enabled    := True;
  btnReplicarParaTodasAsAtividades.Enabled := True;

    If Not cdsAtividades.IsEmpty Then
      cdsAtividades.First;

  pSetFocus(cxAtividades);
end;

procedure TfrmCadDescontoMaximoPorAtividade.pTelaEmModoPadrao;
begin
  pLimparDados;
  pnlCabecalho.Enabled := True;
  cxAtividades.Enabled := False;
  btnGravar.Enabled    := False;
  btnReplicarParaTodasAsAtividades.Enabled := False;
  pSetFocus(edtCodEmp);
end;

procedure TfrmCadDescontoMaximoPorAtividade.pValidaHierarquiaBeforePost(DataSet: TDataSet);
var
  objValidaHierarquia : TValidaHierarquia;
  recResultado        : TResultado;
begin

  objValidaHierarquia := TValidaHierarquia.Create(Self);

  Try

    objValidaHierarquia.pSetVendedorJunior(DataSet.FieldByName('DESMAX').AsFloat);
    objValidaHierarquia.pSetVendedorMaster(DataSet.FieldByName('DESMVM').AsFloat);
    objValidaHierarquia.pSetSubGerenJunior(DataSet.FieldByName('DESMSU').AsFloat);
    objValidaHierarquia.pSetSubGerenMaster(DataSet.FieldByName('DESMSM').AsFloat);
    objValidaHierarquia.pSetGerente_Junior(DataSet.FieldByName('DESMGE').AsFloat);
    objValidaHierarquia.pSetGerente_Master(DataSet.FieldByName('DESMGM').AsFloat);

    recResultado := objValidaHierarquia.fValidarDescontoMaximoOperador;

    If recResultado.TemInconsistencia Then
    Begin
      fMensagem('ATENÇÃO!', recResultado.Mensagem, ['&Ok']);
      DataSet.Cancel;
      Abort;
    End;

  Finally
    FreeAndNil(objValidaHierarquia);
  End;

end;

end.
