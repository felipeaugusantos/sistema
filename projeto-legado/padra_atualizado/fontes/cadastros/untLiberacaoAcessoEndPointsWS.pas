unit untLiberacaoAcessoEndPointsWS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Uni,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, MemDS, DBAccess,
  cxGridCustomLayoutView, cxGridCardView, cxGridDBCardView, Datasnap.DBClient,
  UniClientDataSet, cxCheckBox, cxLabel, Vcl.Grids, Vcl.DBGrids,
  Datasnap.Provider, untPaiConfirma, cxContainer;

type
  TfrmLiberacaoAcessoEndPointsWS = class(TfrmPaiConfirma)
    pnlCodDiv: TPanel;
    Label224: TLabel;
    edtCodAut: TEditFocus;
    edtDesAut: TEditFocus;
    dtsEndPoints: TDataSource;
    cdsEndPoints: TUniClientDataSet;
    cdsEndPointsEND_END_ID: TStringField;
    cdsEndPointsEND_DESEND: TStringField;
    cdsEndPointsEND_GRPEND: TStringField;
    cdsEndPointsEND_METHOD: TStringField;
    cxStyleRepository1: TcxStyleRepository;
    cxsPOST: TcxStyle;
    cxsGET: TcxStyle;
    cxsPUT: TcxStyle;
    cxsDELETE: TcxStyle;
    cxsPATCH: TcxStyle;
    cxsOPTIONS: TcxStyle;
    cxsHEAD: TcxStyle;
    cxgEndPoints: TcxGrid;
    cxgEndPointsDBTv: TcxGridDBTableView;
    cxgEndPointsDBTvMARCADO: TcxGridDBColumn;
    cxgEndPointsDBTvGRPEND: TcxGridDBColumn;
    cxgEndPointsDBTvENDPOI: TcxGridDBColumn;
    cxgEndPointsDBTvDESEND: TcxGridDBColumn;
    cxgEndPointsLevel1: TcxGridLevel;
    cxgEndPointsDBTvMETHOD: TcxGridDBColumn;
    cdsEndPointsEND_ENDPOI: TStringField;
    cdsEndPointsEND_MARCADO: TLargeintField;
    cdsEndPointsACS_ID_INT: TStringField;
    cbxMarcarTodos: TcxCheckBox;
    procedure edtCodAutKeyPress(Sender: TObject; var Key: Char);
    procedure cxgEndPointsDBTvMETHODStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbxMarcarTodosClick(Sender: TObject);
  private
    { Private declarations }
    function fGetSQL(strCodAut : String):String;
    procedure pExcluiRegistroNoBanco(strCodAut, strEndPoi: String);
    procedure pInsereRegistroNoBanco(strCodAut, strEndPoi: String);
    procedure pCarregaTabela;
    procedure pLimpaCampos;
    procedure pConfirma;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmLiberacaoAcessoEndPointsWS: TfrmLiberacaoAcessoEndPointsWS;

implementation

uses
  untGravando,
  untConsultas,
  untTypesSistema,
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmLiberacaoAcessoEndPointsWS.pInsereRegistroNoBanco(strCodAut: String; strEndPoi: String);
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' INSERT INTO CONECTA_ACESSOS ');
    qryGen.SQL.Add(' (AUTOINCREM, ACS_ID_INT, ACS_ENDPNT) ');
    qryGen.SQL.Add(' VALUES ');
    qryGen.SQL.Add(' (:AUTINC, :ID_INT, :ENDPNT); ');
    qryGen.ParamByName('AUTINC').AsString := fRetAutoIncrem('CONECTA_ACESSOS', VS_strCodEmp);
    qryGen.ParamByName('ID_INT').AsString := strCodAut;
    qryGen.ParamByName('ENDPNT').AsString := strEndPoi;
    qryGen.ExecSQL();
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmLiberacaoAcessoEndPointsWS.pExcluiRegistroNoBanco(strCodAut: String; strEndPoi: String);
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' DELETE FROM CONECTA_ACESSOS ');
    qryGen.SQL.Add(' WHERE ACS_ID_INT = :ID_INT ');
    qryGen.SQL.Add('   AND ACS_ENDPNT = :ENDPNT; ');
    qryGen.ParamByName('ID_INT').AsString := strCodAut;
    qryGen.ParamByName('ENDPNT').AsString := strEndPoi;
    qryGen.ExecSQL();
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmLiberacaoAcessoEndPointsWS.btnConfirmaClick(Sender: TObject);
begin
  If (fMensagem('Confirmação', 'Deseja autorizar acesso aos EndPoints selecionados para '+edtDesAut.Text+'?', ['&Sim', '&Não'], 1) = 2) Then
    Exit;

  Try
    TfrmGravando.fExecutarModal(pConfirma, 'Aguarde... Registrando informações...', '');
    pMensagemOk('Operação realizada com sucesso!');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[untLiberacaoAcessoEndPointsWS.btnConfirmaClick]');
    End;
  End;

  pSetFocus(edtCodAut);
end;

procedure TfrmLiberacaoAcessoEndPointsWS.pConfirma;
begin
  cdsEndPoints.DisableControls;
  Try
    cdsEndPoints.First;
    While Not cdsEndPoints.Eof Do
    Begin
      If (cdsEndPointsEND_MARCADO.AsInteger = 1) And
         (cdsEndPointsACS_ID_INT.IsNull) Then
      Begin
        pInsereRegistroNoBanco(edtCodAut.Text, cdsEndPointsEND_END_ID.AsString);
      End
      Else if (cdsEndPointsEND_MARCADO.AsInteger = 0) And
              (Not cdsEndPointsACS_ID_INT.IsNull) Then
      Begin
        pExcluiRegistroNoBanco(edtCodAut.Text, cdsEndPointsEND_END_ID.AsString);
      End;

      cdsEndPoints.Next;
    End;
  Finally
    cdsEndPoints.EnableControls;
  End;

  pCarregaTabela;
end;

procedure TfrmLiberacaoAcessoEndPointsWS.pLimpaCampos;
begin
  edtCodAut.Clear;
  edtDesAut.Clear;
  edtCodAut.Enabled := True;
  btnConfirma.Enabled := False;
  cbxMarcarTodos.Checked := False;
  cbxMarcarTodos.Visible := False;
  cdsEndPoints.EmptyDataSet;
  pSetFocus(edtCodAut);
end;

procedure TfrmLiberacaoAcessoEndPointsWS.btnSairClick(Sender: TObject);
begin
  If btnConfirma.Enabled Then
    pLimpaCampos
  Else
    Self.ModalResult := mrCancel;
end;

procedure TfrmLiberacaoAcessoEndPointsWS.cbxMarcarTodosClick(Sender: TObject);
begin
  inherited;

  cdsEndPoints.DisableControls;
  Try
    cdsEndPoints.First;
    While Not cdsEndPoints.Eof Do
    Begin
      cdsEndPoints.Edit;
      cdsEndPointsEND_MARCADO.AsInteger := IIF(cbxMarcarTodos.Checked, 1, 0);
      cdsEndPoints.Post;

      cdsEndPoints.Next;
    End;
  Finally
    cdsEndPoints.EnableControls;
  End;
end;

procedure TfrmLiberacaoAcessoEndPointsWS.cxgEndPointsDBTvMETHODStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  Var
    varValor : Variant;
begin
  inherited;
  varValor := ARecord.Values[AItem.Index];

  If varValor = 'POST' Then
    AStyle := cxsPOST
  Else If varValor = 'GET' Then
    AStyle := cxsGET
  Else If varValor = 'PUT' Then
    AStyle := cxsPUT
  Else If varValor = 'PATCH' Then
    AStyle := cxsPATCH
  Else If varValor = 'HEAD' Then
    AStyle := cxsHEAD
  Else If varValor = 'OPTIONS' Then
    AStyle := cxsOPTIONS
  Else If varValor = 'DELETE' Then
    AStyle := cxsDELETE;
end;

procedure TfrmLiberacaoAcessoEndPointsWS.edtCodAutKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
    qryConAut : TUniQuery;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    qryConAut := fCriaQuery(Self);
    Try
      if fPesqAutorizadosWS(Self, edtCodAut, edtDesAut, qryConAut, Key, arrSel, True) then
      Begin
        If (fValidaCampos(edtCodAut, True)) Then
          SelectNext(ActiveControl, True, True);
      End;
    Finally
      FreeAndNil(qryConAut);
    End;
  End;
end;

procedure TfrmLiberacaoAcessoEndPointsWS.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodAut);
end;

function TfrmLiberacaoAcessoEndPointsWS.fGetSQL(strCodAut : String):String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   ACS_ID_INT, ';
  Result := Result + '   IF(ACS_ID_INT IS NULL, 0, 1) AS END_MARCADO, ';
  Result := Result + '   END_END_ID, ';
  Result := Result + '   SUBSTRING_INDEX(END_END_ID, " ", 1) AS END_METHOD, ';
  Result := Result + '   SUBSTRING_INDEX(END_END_ID, " ", - 1) AS END_ENDPOI, ';
  Result := Result + '   END_DESEND, ';
  Result := Result + '   END_GRPEND ';
  Result := Result + ' FROM ';
  Result := Result + '   ENDPNT ';
  Result := Result + '   LEFT JOIN CONECTA_ACESSOS ON ACS_ENDPNT = END_END_ID ';

  If Not fEmptyStr(strCodAut) Then
    Result := Result + ' AND ACS_ID_INT = "'+strCodAut+'" ';

  Result := Result + '   LEFT JOIN CONECTA_INTEGRACOES ON INT_CODAUT = ACS_ID_INT ';

  If fEmptyStr(strCodAut) Then
    Result := Result + ' WHERE FALSE '
end;

function TfrmLiberacaoAcessoEndPointsWS.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodAut) And (blnBuscaPorChave) Then
    Begin
      If Not fEmptyStr(edtCodAut.Text) Then
      Begin
        edtDesAut.Text := fRetNomeAutorizadoWS(edtCodAut.Text);
        If fEmptyStr(edtDesAut.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Cadastro de autorizado não encontrado!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          pCarregaTabela;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmLiberacaoAcessoEndPointsWS.pCarregaTabela;
  Var
    qryEndPoints : TUniQuery;
begin
  qryEndPoints := fCriarQuery(fGetSQL(''), Self);
  Try
    qryEndPoints.Close;
    qryEndPoints.SQL.Clear;
    qryEndPoints.SQL.Add(fGetSQL(edtCodAut.Text));
    qryEndPoints.Open;

    edtCodAut.Enabled := False;
    btnConfirma.Enabled := True;

    If Not cdsEndPoints.Active Then
    Begin
      cdsEndPoints.CreateDataSet;
      cdsEndPoints.Open;
    End;

    cdsEndPoints.EmptyDataSet;
    cdsEndPoints.DisableControls;
    Try
      qryEndPoints.First;
      While Not qryEndPoints.Eof Do
      Begin
        cdsEndPoints.Append;
        cdsEndPointsACS_ID_INT.AsVariant  := qryEndPoints.FieldByName('ACS_ID_INT').AsVariant;
        cdsEndPointsEND_END_ID.AsString   := qryEndPoints.FieldByName('END_END_ID').AsString;
        cdsEndPointsEND_ENDPOI.AsString   := qryEndPoints.FieldByName('END_ENDPOI').AsString;
        cdsEndPointsEND_DESEND.AsString   := qryEndPoints.FieldByName('END_DESEND').AsString;
        cdsEndPointsEND_GRPEND.AsString   := qryEndPoints.FieldByName('END_GRPEND').AsString;
        cdsEndPointsEND_MARCADO.AsInteger := qryEndPoints.FieldByName('END_MARCADO').AsInteger;
        cdsEndPointsEND_METHOD.AsString   := qryEndPoints.FieldByName('END_METHOD').AsString;
        cdsEndPoints.Post;

        qryEndPoints.Next;
      End;
    Finally
      cdsEndPoints.First;
      cdsEndPoints.EnableControls;
    End;

    cxgEndPointsDBTv.DataController.Groups.FullExpand;
    cbxMarcarTodos.Visible := True;
  Finally
    FreeAndNil(qryEndPoints);
  End;
end;

end.
