unit untCadMargemMinimaPorAtividade;

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
  TfrmCadMargemMinimaPorAtividade = class(TfrmPai)
    pnlCabecalho: TPanel;
    pnlRodape: TPanel;
    btnGravar: TBitBtnLocked;
    btnReplicarParaTodasAsAtividades: TBitBtnLocked;
    cdsAtividades: TUniClientDataSet;
    cdsAtividadesCODATI: TStringField;
    cdsAtividadesDESATI: TStringField;
    cdsAtividadesMARMIN: TFloatField;
    cdsAtividadesMARMSG: TFloatField;
    cdsAtividadesMARMGE: TFloatField;
    cdsAtividadesMARMMV: TFloatField;
    cdsAtividadesMARMMS: TFloatField;
    cdsAtividadesMARMMG: TFloatField;
    dtsAtividades: TDataSource;
    cxAtividades: TcxGridCitel;
    cxAtividadesView: TcxGridDBTableViewCitel;
    cxAtividadesLevel1: TcxGridLevel;
    cxAtividadesViewCODATI: TcxGridDBColumn;
    cxAtividadesViewDESATI: TcxGridDBColumn;
    cxAtividadesViewMARMIN: TcxGridDBColumn;
    cxAtividadesViewMARMSG: TcxGridDBColumn;
    cxAtividadesViewMARMGE: TcxGridDBColumn;
    cxAtividadesViewMARMMV: TcxGridDBColumn;
    cxAtividadesViewMARMMS: TcxGridDBColumn;
    cxAtividadesViewMARMMG: TcxGridDBColumn;
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
  frmCadMargemMinimaPorAtividade: TfrmCadMargemMinimaPorAtividade;

implementation

uses
  untTypesSistema, untConsultas, untfuncoesSimples, untPesqAux,
  untValidaHierarquia;

{$R *.dfm}

procedure TfrmCadMargemMinimaPorAtividade.btnGravarClick(Sender: TObject);
const
  SQL = 'SELECT * FROM MARMIN WHERE AUTOINCREM = :AUTINC';
  ALL = 'SELECT * FROM MARMIN WHERE FALSE';
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
          qryAux.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MARMIN', VS_strCodEmp);
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

        qryAux.FieldByName('MIN_CODEMP').AsString := cdsAtividadesCODEMP.AsString;
        qryAux.FieldByName('MIN_CODATI').AsString := cdsAtividadesCODATI.AsString;

        qryAux.FieldByName('MIN_MARMIN').AsFloat := cdsAtividadesMARMIN.AsFloat;
        qryAux.FieldByName('MIN_MARMSG').AsFloat := cdsAtividadesMARMSG.AsFloat;
        qryAux.FieldByName('MIN_MARMGE').AsFloat := cdsAtividadesMARMGE.AsFloat;
        qryAux.FieldByName('MIN_MARMMV').AsFloat := cdsAtividadesMARMMV.AsFloat;
        qryAux.FieldByName('MIN_MARMMS').AsFloat := cdsAtividadesMARMMS.AsFloat;
        qryAux.FieldByName('MIN_MARMMG').AsFloat := cdsAtividadesMARMMG.AsFloat;
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

procedure TfrmCadMargemMinimaPorAtividade.btnReplicarParaTodasAsAtividadesClick(Sender: TObject);
var
  fltMARMIN,
  fltMARMSG,
  fltMARMGE,
  fltMARMMV,
  fltMARMMS,
  fltMARMMG : Double;

  Posicao : TBookmark;

begin

  inherited;

  If cdsAtividades.IsEmpty Then
    Exit;

  If fMensagem('Atenção', 'Deseja replicar os valores desse registro para todos os demais?', ['&Sim', '&Não'], 1) = 2 Then
    Exit;

  Posicao := cdsAtividades.GetBookmark;

  fltMARMIN := cdsAtividadesMARMIN.AsFloat;
  fltMARMSG := cdsAtividadesMARMSG.AsFloat;
  fltMARMGE := cdsAtividadesMARMGE.AsFloat;
  fltMARMMV := cdsAtividadesMARMMV.AsFloat;
  fltMARMMS := cdsAtividadesMARMMS.AsFloat;
  fltMARMMG := cdsAtividadesMARMMG.AsFloat;

  cxAtividades.BeginUpdate();

  Try

    cdsAtividades.First;
    While Not cdsAtividades.Eof Do
    Begin
      cdsAtividades.Edit;
      cdsAtividadesMARMIN.AsFloat := fltMARMIN;
      cdsAtividadesMARMSG.AsFloat := fltMARMSG;
      cdsAtividadesMARMGE.AsFloat := fltMARMGE;
      cdsAtividadesMARMMV.AsFloat := fltMARMMV;
      cdsAtividadesMARMMS.AsFloat := fltMARMMS;
      cdsAtividadesMARMMG.AsFloat := fltMARMMG;
      cdsAtividades.Post;
      cdsAtividades.Next;
    End;

  Finally
    cxAtividades.EndUpdate();

    If cdsAtividades.BookmarkValid(Posicao) Then
      cdsAtividades.GotoBookmark(Posicao);

  End;

end;

procedure TfrmCadMargemMinimaPorAtividade.cdsAtividadesNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('MARMIN').AsFloat := 0;
  DataSet.FieldByName('MARMSG').AsFloat := 0;
  DataSet.FieldByName('MARMGE').AsFloat := 0;
  DataSet.FieldByName('MARMMV').AsFloat := 0;
  DataSet.FieldByName('MARMMS').AsFloat := 0;
  DataSet.FieldByName('MARMMG').AsFloat := 0;
end;

procedure TfrmCadMargemMinimaPorAtividade.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
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

function TfrmCadMargemMinimaPorAtividade.fExisteAtividadesEmBanco: Boolean;
const
  SQL_EXISTE       = 'SELECT COUNT(*) AS QTD FROM MARMIN WHERE MIN_CODEMP = :CODEMP';
  SQL_EXISTE_VAZIO = 'SELECT COUNT(*) AS QTD FROM MARMIN WHERE (MIN_CODEMP IS NULL) OR (MIN_CODEMP = "")';
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

function TfrmCadMargemMinimaPorAtividade.fInformouEmpresa: Boolean;
begin
  Result := Not fEmptyStr(edtCodEmp.Text);
end;

procedure TfrmCadMargemMinimaPorAtividade.FormCreate(Sender: TObject);
begin
  inherited;

  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);

  cdsAtividades.CreateDataSet;
  cdsAtividades.EmptyDataSet;
  pTelaEmModoPadrao;

end;

procedure TfrmCadMargemMinimaPorAtividade.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

function TfrmCadMargemMinimaPorAtividade.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
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

procedure TfrmCadMargemMinimaPorAtividade.pCarregaEmpresa;
begin
  pPesquisaCadEmp(Nil, qryConEmp, edtCodEmp.Text);
  EdtDesEmp.Text := qryConEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmCadMargemMinimaPorAtividade.pCarregarAtividades;
const
  SQL_LOAD = 'SELECT                    ' +
             '  M.AUTOINCREM AS AUTINC, ' +
             '  M.MIN_CODEMP AS CODEMP, ' +
             '  M.MIN_CODATI AS CODATI, ' +
             '  A.ATI_DESATI AS DESATI, ' +
             '  M.MIN_MARMIN AS MARMIN, ' +
             '  M.MIN_MARMSG AS MARMSG, ' +
             '  M.MIN_MARMGE AS MARMGE, ' +
             '  M.MIN_MARMMV AS MARMMV, ' +
             '  M.MIN_MARMMS AS MARMMS, ' +
             '  M.MIN_MARMMG AS MARMMG  ' +
             'FROM            ' +
             '  MARMIN M      ' +
             '  INNER JOIN CADATI A ON (A.ATI_CODATI = M.MIN_CODATI) ' +
             'WHERE                    ' +
             '  M.MIN_CODEMP = :CODEMP ' +
             'ORDER BY       ' +
             '  A.ATI_DESATI ';

  SQL_LOAD_VAZIO = 'SELECT                    ' +
                   '  M.AUTOINCREM AS AUTINC, ' +
                   '  M.MIN_CODEMP AS CODEMP, ' +
                   '  M.MIN_CODATI AS CODATI, ' +
                   '  A.ATI_DESATI AS DESATI, ' +
                   '  M.MIN_MARMIN AS MARMIN, ' +
                   '  M.MIN_MARMSG AS MARMSG, ' +
                   '  M.MIN_MARMGE AS MARMGE, ' +
                   '  M.MIN_MARMMV AS MARMMV, ' +
                   '  M.MIN_MARMMS AS MARMMS, ' +
                   '  M.MIN_MARMMG AS MARMMG  ' +
                   'FROM            ' +
                   '  MARMIN M      ' +
                   '  INNER JOIN CADATI A ON (A.ATI_CODATI = M.MIN_CODATI) ' +
                   'WHERE                                           ' +
                   '  (M.MIN_CODEMP IS NULL) OR (M.MIN_CODEMP = "") ' +
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
        cdsAtividadesMARMIN.AsFloat  := 0;
        cdsAtividadesMARMSG.AsFloat  := 0;
        cdsAtividadesMARMGE.AsFloat  := 0;
        cdsAtividadesMARMMV.AsFloat  := 0;
        cdsAtividadesMARMMS.AsFloat  := 0;
        cdsAtividadesMARMMG.AsFloat  := 0;
      End
      Else
      Begin
        cdsAtividadesAUTINC.AsString := qryAux.FieldByName('AUTINC').AsString;
        cdsAtividadesMARMIN.AsFloat  := qryAux.FieldByName('MARMIN').AsFloat;
        cdsAtividadesMARMSG.AsFloat  := qryAux.FieldByName('MARMSG').AsFloat;
        cdsAtividadesMARMGE.AsFloat  := qryAux.FieldByName('MARMGE').AsFloat;
        cdsAtividadesMARMMV.AsFloat  := qryAux.FieldByName('MARMMV').AsFloat;
        cdsAtividadesMARMMS.AsFloat  := qryAux.FieldByName('MARMMS').AsFloat;
        cdsAtividadesMARMMG.AsFloat  := qryAux.FieldByName('MARMMG').AsFloat;
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

procedure TfrmCadMargemMinimaPorAtividade.pLimparDados;
begin

  edtCodEmp.Clear;
  edtDesEmp.Clear;

  If Not cdsAtividades.IsEmpty Then
    cdsAtividades.EmptyDataSet;

end;

procedure TfrmCadMargemMinimaPorAtividade.pTelaEmModoEdicao;
begin
  pnlCabecalho.Enabled := False;
  cxAtividades.Enabled := True;
  btnGravar.Enabled    := True;
  btnReplicarParaTodasAsAtividades.Enabled := True;

    If Not cdsAtividades.IsEmpty Then
      cdsAtividades.First;

  pSetFocus(cxAtividades);
end;

procedure TfrmCadMargemMinimaPorAtividade.pTelaEmModoPadrao;
begin
  pLimparDados;
  pnlCabecalho.Enabled := True;
  cxAtividades.Enabled := False;
  btnGravar.Enabled    := False;
  btnReplicarParaTodasAsAtividades.Enabled := False;
  pSetFocus(edtCodEmp);
end;

procedure TfrmCadMargemMinimaPorAtividade.pValidaHierarquiaBeforePost(DataSet: TDataSet);
var
  objValidaHierarquia : TValidaHierarquia;
  recResultado        : TResultado;
begin

  objValidaHierarquia := TValidaHierarquia.Create(Self);

  Try

    objValidaHierarquia.pSetVendedorJunior(DataSet.FieldByName('MARMIN').AsFloat);
    objValidaHierarquia.pSetVendedorMaster(DataSet.FieldByName('MARMMV').AsFloat);
    objValidaHierarquia.pSetSubGerenJunior(DataSet.FieldByName('MARMSG').AsFloat);
    objValidaHierarquia.pSetSubGerenMaster(DataSet.FieldByName('MARMMS').AsFloat);
    objValidaHierarquia.pSetGerente_Junior(DataSet.FieldByName('MARMGE').AsFloat);
    objValidaHierarquia.pSetGerente_Master(DataSet.FieldByName('MARMMG').AsFloat);

    recResultado := objValidaHierarquia.fValidarMargemMinimaOperador;

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
