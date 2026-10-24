unit untCadCondLinGru;

interface

uses
  Windows, Classes, Controls, Forms, untPaiConfirma, AppEvnts, Menus, StdCtrls,
  Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Mask, DBEditFocus, UniClientDataSet, BitBtnLockedIncrem, Uni, ComCtrls,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, DBCtrls, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient;

type
  TfrmCadCondLinGru = class(TfrmPaiConfirma)
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    pnlItem: TPanel;
    dbeCodGru: TDBEditFocus;
    dbeDesGru: TDBEditFocus;
    dbeDesVen: TDBEditFocus;
    dbeDesGen: TDBEditFocus;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dtsItens: TDataSource;
    cdsItens: TUniClientDataSet;
    cxgItensViewColumn3: TcxGridDBColumn;
    cxgItensViewColumn4: TcxGridDBColumn;
    cxgItensViewColumn5: TcxGridDBColumn;
    btnAdicionar: TBitBtnLocked;
    prgProgresso: TProgressBar;
    dtsGrid: TDataSource;
    btnExcluir: TBitBtnLocked;
    cdsItensCODCND: TStringField;
    cdsItensDESCND: TStringField;
    cdsItensCODGRU: TStringField;
    cdsItensDESGRU: TStringField;
    cdsItensDESMAG: TFloatField;
    cdsItensDESMAV: TFloatField;
    cxgItensViewColumn6: TcxGridDBColumn;
    lbl1: TLabel;
    dbeCodCnd: TDBEditFocus;
    dbeDesCnd: TDBEditFocus;
    btnCancelaItem: TBitBtnLocked;
    dbeDesSub: TDBEditFocus;
    Label2: TLabel;
    cxgItensViewColumn1: TcxGridDBColumn;
    cdsItensDESMAS: TFloatField;
    Label5: TLabel;
    dbeDesGeM: TDBEditFocus;
    Label6: TLabel;
    dbeDesSuM: TDBEditFocus;
    Label7: TLabel;
    dbeDesVeM: TDBEditFocus;
    cdsItensDESMGM: TFloatField;
    cdsItensDESMSM: TFloatField;
    cdsItensDESMVM: TFloatField;
    cxgItensViewColumn2: TcxGridDBColumn;
    cxgItensViewColumn7: TcxGridDBColumn;
    cxgItensViewColumn8: TcxGridDBColumn;
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAdicionarClick(Sender: TObject);
    procedure dbeCodGruKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsItensAfterPost(DataSet: TDataSet);
    procedure cxgItensEnter(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    qryConGru: TUniQuery;
    cdsAux   : TUniClientDataSet;    
    blnConfirma: Boolean;

    procedure pCarregaLinGru;
    Procedure pSalvaItem;
    function fValidaHierarquia(DataSet: TDataSet) : Boolean;

  public
    { Public declarations }
    strCodCnd: String;

    procedure pInsereNovo;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses SysUtils, untFuncoesSimples, untConsultas, untPesqAux, untTypesSistema, untValidaHierarquia;


{$R *.dfm}

procedure TfrmCadCondLinGru.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  if not fValidaHierarquia(cdsItens) Then
   Exit;

  If fVerificaCampos Then
  Begin
    pSalvaItem;
    pSetFocus(dbeCodGru);
  End;
end;

procedure TfrmCadCondLinGru.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  If cdsItens.State In [dsEdit, dsInsert] Then
    cdsItens.Cancel;
end;

procedure TfrmCadCondLinGru.btnConfirmaClick(Sender: TObject);
  Var
    qryGen : TUniQuery;
begin
  inherited;

  qryGen := fCriaQuery(Nil);

  With cdsItens Do
  Begin

    If State In [dsEdit, dsInsert] Then
    Begin
      If fEmptyStr(FieldByName('CODCND').AsString) Or
         fEmptyStr(FieldByName('CODGRU').AsString) Then
        Cancel
      Else
      Begin
        If fVerificaCampos Then
          Post
        Else
        Begin
          blnConfirma := False;
          Exit;
        End;
      End;
    End;

    blnConfirma := True;

    If Not (IsEmpty) Then
    Begin

      First;

      While Not EOF Do
      Begin

        With qryGen Do
        Begin
          SQL.Clear;
          SQL.Add('DELETE FROM CNDGRU          ');
          SQL.Add('WHERE  CND_CODCND = :CODCND ');
          SQL.Add('AND    CND_CODGRU = :CODGRU ');
          ParamByName('CODCND').AsString := cdsItens.FieldByName('CODCND').AsString;
          ParamByName('CODGRU').AsString := cdsItens.FieldByName('CODGRU').AsString;
          ExecSQL;

          SQL.Clear;
          SQL.Add('INSERT INTO     ');
          SQL.Add('  CNDGRU (      ');
          SQL.Add('    CND_CODCND, ');
          SQL.Add('    CND_CODGRU, ');
          SQL.Add('    CND_DESMAG, ');
          SQL.Add('    CND_DESMAS, ');
          SQL.Add('    CND_DESMAV, ');
          SQL.Add('    CND_DESMGM, ');
          SQL.Add('    CND_DESMSM, ');
          SQL.Add('    CND_DESMVM) ');
          SQL.Add('  VALUES (      ');
          SQL.Add('    :CODCND,    ');
          SQL.Add('    :CODGRU,    ');
          SQL.Add('    :DESMAG,    ');
          SQL.Add('    :DESMAS,    ');
          SQL.Add('    :DESMAV,    ');
          SQL.Add('    :DESMGM,    ');
          SQL.Add('    :DESMSM,    ');
          SQL.Add('    :DESMVM)    ');

          ParamByName('CODCND').AsString := cdsItens.FieldByName('CODCND').AsString;
          ParamByName('CODGRU').AsString := cdsItens.FieldByName('CODGRU').AsString;
          ParamByName('DESMAG').AsFloat  := cdsItens.FieldByName('DESMAG').AsFloat;
          ParamByName('DESMAS').AsFloat  := cdsItens.FieldByName('DESMAS').AsFloat;
          ParamByName('DESMAV').AsFloat  := cdsItens.FieldByName('DESMAV').AsFloat;
          ParamByName('DESMGM').AsFloat  := cdsItens.FieldByName('DESMGM').AsFloat;
          ParamByName('DESMSM').AsFloat  := cdsItens.FieldByName('DESMSM').AsFloat;
          ParamByName('DESMVM').AsFloat  := cdsItens.FieldByName('DESMVM').AsFloat;
          ExecSQL;
        End;

        Next;
      End;

    End;

  End;

  FreeAndNil(qryGen);
  Close;  
end;

procedure TfrmCadCondLinGru.btnExcluirClick(Sender: TObject);
  Var
    qryGen : TUniQuery;
begin
  inherited;

  qryGen := fCriaQuery(Nil);  

  With cdsItens Do
  Begin
    If (Not Active) Or IsEmpty Then
      Exit;

    If fPergunta('Confirma a exclusão do registro?') Then
    Begin

      With qryGen Do
      Begin
        SQL.Clear;
        SQL.Add('DELETE FROM CNDGRU          ');
        SQL.Add('WHERE  CND_CODCND = :CODCND ');
        SQL.Add('AND    CND_CODGRU = :CODGRU ');
        ParamByName('CODCND').AsString := cdsItens.FieldByName('CODCND').AsString;
        ParamByName('CODGRU').AsString := cdsItens.FieldByName('CODGRU').AsString;
        ExecSQL;
      end;

      Delete;
    End;

  End;

  pSetFocus(dbeCodGru);
  FreeAndNil(qryGen);  
end;

procedure TfrmCadCondLinGru.cdsItensAfterPost(DataSet: TDataSet);
begin
  inherited;
  cdsAux.Data := cdsitens.Data;
end;

procedure TfrmCadCondLinGru.cxgItensEnter(Sender: TObject);
begin
  inherited;
  cdsItens.Cancel;
  cdsItens.Edit;
end;

procedure TfrmCadCondLinGru.dbeCodGruKeyPress(Sender: TObject; var Key: Char);
  Var
    arrGrupos: TConsultasArray;
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If not (cdsItens.state = dsEdit) Then
    cdsItens.Edit;

  If fPesqGrupo(Self, dbeCodGru, Nil, qryConGru, Key, arrGrupos) Then
  Begin
    If fValidaCampos(dbeCodGru) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCondLinGru.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If (Not blnConfirma) Then
    Action := caNone;

  If Action <> caNone Then
  Begin
    FreeAndNil(qryConGru);
    FreeAndNil(cdsAux);
  End;

  blnConfirma := True;
end;

procedure TfrmCadCondLinGru.FormCreate(Sender: TObject);
begin
  inherited;

  qryConGru := fCriarQuery('SELECT * FROM CADGRU', Self);
  cdsAux    := TUniClientDataSet.Create(Self);
  blnConfirma := True;
end;

procedure TfrmCadCondLinGru.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If pnlBotoes.Enabled Then
    Case Key Of
      VK_F10   : btnConfirma.Click;

      VK_DELETE: If fCheckParent(ActiveControl, cxgItens) Then
                   btnExcluir.Click;

      VK_RETURN: If fCheckParent(ActiveControl, cxgItens) And dbeCodGru.CanFocus then
                   pSetFocus(dbeCodGru);
    End;
end;

function TfrmCadCondLinGru.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = dbeCodGru Then
    Begin
      If fEmptyStr(dbeCodGru.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Linha / Grupo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaLinGru;
        If qryConGru.FieldByName('GRU_CODGRU').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Linha / Grupo não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If Not cdsAux.IsEmpty then
          Begin
            If (cdsItens.State = dsInsert) And
               (cdsAux.Locate('CODGRU',qryConGru.FieldByName('GRU_CODGRU').AsString, [])) Then
            Begin
              fMensagem('ATENÇÃO!', 'Essa Linha / Grupo já foi adicionada!', ['&Ok']);
              Result := False;
            End;
          End;
        End;
      End;

    End
    Else If Sender = dbeDesGen Then
    Begin
      If fEmptyStr(dbeDesGen.Text) Then
        dbeDesGen.Field.AsFloat := 0.0;

      If (Not fValidaEscala(dbeDesGen.Text, 0, 100)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Desconto máximo do gerente júnior deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End

    Else If Sender = dbeDesGeM Then
    Begin
      If fEmptyStr(dbeDesGeM.Text) Then
        dbeDesGeM.Field.AsFloat := 0.0;

      If (Not fValidaEscala(dbeDesGeM.Text, 0, 100)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Desconto máximo do gerente master deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End

    Else If Sender = dbeDesSub Then
    Begin
      If fEmptyStr(dbeDesSub.Text) Then
        dbeDesSub.Field.AsFloat := 0.0;

      If (Not fValidaEscala(dbeDesSub.Text, 0, 100)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Desconto máximo do sub-gerente júnior deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End

    Else If Sender = dbeDesSuM Then
    Begin
      If fEmptyStr(dbeDesSuM.Text) Then
        dbeDesSuM.Field.AsFloat := 0.0;

      If (Not fValidaEscala(dbeDesSuM.Text, 0, 100)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Desconto máximo do sub-gerente master deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End

    Else If Sender = dbeDesVen Then
    Begin
      If fEmptyStr(dbeDesVen.Text) Then
        dbeDesVen.Field.AsFloat := 0.0;

      If (Not fValidaEscala(dbeDesVen.Text, 0, 100)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Desconto máximo do vendedor júnior deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End

    Else If Sender = dbeDesVeM Then
    Begin
      If fEmptyStr(dbeDesVeM.Text) Then
        dbeDesVeM.Field.AsFloat := 0.0;

      If (Not fValidaEscala(dbeDesVeM.Text, 0, 100)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Desconto máximo do vendedor master deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadCondLinGru.pCarregaLinGru;
begin
  pPesquisaLinGru(qryConGru, qryConGru, dbeCodGru.Text);
  With qryConGru Do
  Begin
    If cdsItens.State In [dsEdit, dsInsert] Then
      cdsItens.FieldByName('DESGRU').AsString := FieldByName('GRU_DESGRU').AsString;
  End;
end;

procedure TfrmCadCondLinGru.pInsereNovo;
begin
  cdsItens.Cancel;

  cdsItens.Append;
  cdsItens.FieldByName('CODCND').AsString := strCodCnd;
  cdsItens.FieldByName('DESCND').AsString := fRetDescricao(strCodCnd, 'CADCND', 'CND_CODIGO', 'CND_DESCRI');
  cdsItens.FieldByName('DESMAG').AsFloat  := 0.00;
  cdsItens.FieldByName('DESMAS').AsFloat  := 0.00;
  cdsItens.FieldByName('DESMAV').AsFloat  := 0.00;
  cdsItens.FieldByName('DESMGM').AsFloat  := 0.00;
  cdsItens.FieldByName('DESMSM').AsFloat  := 0.00;
  cdsItens.FieldByName('DESMVM').AsFloat  := 0.00;
end;

procedure TfrmCadCondLinGru.pSalvaItem;
begin
  If cdsItens.State In [dsEdit, dsInsert] Then
  Begin
    If fEmptyStr(cdsItens.FieldByName('CODCND').AsString) Then
    Begin
      cdsItens.FieldByName('CODCND').AsString := strCodCnd;
      cdsItens.FieldByName('DESCND').AsString := fRetDescricao(strCodCnd, 'CADCND', 'CND_CODIGO', 'CND_DESCRI');      
    End;

    cdsItens.Post;
  End;

  pInsereNovo;
end;

function TfrmCadCondLinGru.fValidaHierarquia(DataSet: TDataSet) : Boolean;
var
  objValidaHierarquia : TValidaHierarquia;
  recResultado        : TResultado;
begin

  Result := True;

  objValidaHierarquia := TValidaHierarquia.Create(Self);

  Try

    objValidaHierarquia.pSetVendedorJunior(DataSet.FieldByName('DESMAV').AsFloat);
    objValidaHierarquia.pSetVendedorMaster(DataSet.FieldByName('DESMVM').AsFloat);
    objValidaHierarquia.pSetSubGerenJunior(DataSet.FieldByName('DESMAS').AsFloat);
    objValidaHierarquia.pSetSubGerenMaster(DataSet.FieldByName('DESMSM').AsFloat);
    objValidaHierarquia.pSetGerente_Junior(DataSet.FieldByName('DESMAG').AsFloat);
    objValidaHierarquia.pSetGerente_Master(DataSet.FieldByName('DESMGM').AsFloat);

    recResultado := objValidaHierarquia.fValidarDescontoMaximoOperador;

    If recResultado.TemInconsistencia Then
    Begin
      fMensagem('ATENÇÃO!', recResultado.Mensagem, ['&Ok']);
      Result := False;
    End;

  Finally
    FreeAndNil(objValidaHierarquia);
  End;

end;

end.

