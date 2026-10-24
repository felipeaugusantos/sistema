unit untCadRapidoFreteTranspRegiao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Data.DB,
  Datasnap.DBClient, UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, MemDS, DBAccess, Uni,
  cxCurrencyEdit, cxCalc, cxProgressBar;

type
  TfrmCadRapidoFreteTranspRegiao = class(TfrmPaiConfirma)
    pnlGeral: TPanel;
    gpbCalculoFrete: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    dbeMinFre: TDBEditFocus;
    dbePerTot: TDBEditFocus;
    dbeValKil: TDBEditFocus;
    dbePd100K: TDBEditFocus;
    dbeMinGri: TDBEditFocus;
    dbePerGri: TDBEditFocus;
    dbeValTas: TDBEditFocus;
    cdsTraReg: TUniClientDataSet;
    dscTraReg: TDataSource;
    Label31: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    dbeCodTra: TDBEditFocus;
    edtNomTra: TEditFocus;
    dbeCodReg: TDBEditFocus;
    edtRegiao: TEditFocus;
    dbeValIse: TDBEditFocus;
    cxFrete: TcxGrid;
    cxTblFrete: TcxGridDBTableView;
    cxFreteLvl: TcxGridLevel;
    cxTblFreteNOMTRA: TcxGridDBColumn;
    cxTblFreteNOMREG: TcxGridDBColumn;
    cxTblFreteVALISE: TcxGridDBColumn;
    cxTblFreteMINFRE: TcxGridDBColumn;
    cxTblFretePERTOT: TcxGridDBColumn;
    cxTblFreteVALKIL: TcxGridDBColumn;
    cxTblFretePD100K: TcxGridDBColumn;
    cxTblFretePERGRI: TcxGridDBColumn;
    cxTblFreteMINGRI: TcxGridDBColumn;
    cxTblFreteVALTAS: TcxGridDBColumn;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    pnlCabecalho: TPanel;
    lblTraCid: TLabel;
    edtNomTraReg: TEditFocus;
    edtCodTraReg: TEditFocus;
    cdsTraRegCODTRA: TStringField;
    cdsTraRegNOMTRA: TStringField;
    cdsTraRegCODREG: TStringField;
    cdsTraRegNOMREG: TStringField;
    cdsTraRegVALISE: TFloatField;
    cdsTraRegMINFRE: TFloatField;
    cdsTraRegPERTOT: TFloatField;
    cdsTraRegVALKIL: TFloatField;
    cdsTraRegPD100K: TFloatField;
    cdsTraRegPERGRI: TFloatField;
    cdsTraRegMINGRI: TFloatField;
    cdsTraRegVALTAS: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodTraRegKeyPress(Sender: TObject; var Key: Char);
    procedure cdsTraRegAfterScroll(DataSet: TDataSet);
    procedure btnSairClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbeCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbeCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure cdsTraRegNewRecord(DataSet: TDataSet);
    procedure cdsTraRegBeforePost(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  protected
    procedure pLiberaEdicao(blnLiberaEdicao : Boolean);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fCarregarTraReg(pgbStatus: TcxProgressBar = Nil) : Boolean;
    function fGravarTRAREG(pgbStatus: TcxProgressBar = Nil) : Boolean;
  public
    intConfirma : Integer;
    strOpcTela : String;
    class function fCadRapidoTraReg(strOpcao : String) : Boolean;
  end;

implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas, untGravando;

{$R *.dfm}

{ TfrmCadRapidoFreteTranspRegiao }

procedure TfrmCadRapidoFreteTranspRegiao.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If cdsTraReg.Active And (Not cdsTraReg.IsEmpty) Then
    cdsTraReg.Edit;
end;

procedure TfrmCadRapidoFreteTranspRegiao.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If cdsTraReg.Active And (Not cdsTraReg.IsEmpty) And (cdsTraReg.State in [dsInsert, dsEdit]) Then
    cdsTraReg.Cancel;
end;

procedure TfrmCadRapidoFreteTranspRegiao.btnConfirmaClick(Sender: TObject);
var
  frmAguarde: TfrmGravando;
  blnGravou : Boolean;
begin

  If (Not cdsTraReg.IsEmpty) And fPergunta('Deseja realmente atualizar essas informações?') Then
  Begin

    Try

      Try
        pCriarFormularios(TfrmGravando, frmAguarde);
        frmAguarde.fExecutarAcao := fGravarTRAREG;
        frmAguarde.ShowModal;
        blnGravou := frmAguarde.blnConfirma;
      Except
        On E: Exception Do
        Begin
          blnGravou := False;
          pMensagensErro(E.Message, '');
        End;
      End;

    Finally
      pFreeAndNil(frmAguarde);
    End;

    If (blnGravou) Then
      ModalResult := mrOk
    Else
      ModalResult := mrCancel;

  End
  Else
    ModalResult := mrCancel;

end;

procedure TfrmCadRapidoFreteTranspRegiao.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If cdsTraReg.Active And (Not cdsTraReg.IsEmpty) Then
    If fPergunta('Deseja realmente excluir este registro?') Then
      cdsTraReg.Delete;
end;

procedure TfrmCadRapidoFreteTranspRegiao.btnGravarClick(Sender: TObject);
begin

  inherited;

  Try

    If cdsTraReg.Active And (cdsTraReg.State in [dsInsert, dsEdit]) Then
    Begin

      If fEmptyStr(cdsTraRegCODTRA.AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Transportadora" é obrigatório!', ['&Ok']);
        Exit;
      End;

      If fEmptyStr(cdsTraRegCODREG.AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Região" é obrigatório!', ['&Ok']);
        Exit;
      End;

      cdsTraReg.Post;

    End;

  Except
  End;

end;

procedure TfrmCadRapidoFreteTranspRegiao.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If cdsTraReg.Active Then
  Begin

    cdsTraReg.Append;

    If (strOpcTela = 'T') Then
    Begin
      cdsTraRegCODTRA.AsString := edtCodTraReg.Text;
      cdsTraRegNOMTRA.AsString := fRetNomTransportadora(cdsTraRegCODTRA.AsString);
      edtNomTra.Text := cdsTraRegNOMTRA.AsString;

      pSetFocus(dbeCodReg);

    End
    Else
    If (strOpcTela = 'R') Then
    Begin
      cdsTraRegCODREG.AsString := edtCodTraReg.Text;
      cdsTraRegNOMREG.AsString := fRetNomRegiao(cdsTraRegCODREG.AsString);
      edtRegiao.Text := cdsTraRegNOMREG.AsString;

      pSetFocus(dbeCodTra);

    End;

  End;
end;

procedure TfrmCadRapidoFreteTranspRegiao.btnSairClick(Sender: TObject);
begin

  If Not (pnlCabecalho.Enabled) Then
    pLiberaEdicao(False)
  Else
    Close;

end;

procedure TfrmCadRapidoFreteTranspRegiao.cdsTraRegAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If cdsTraReg.Active And (Not cdsTraReg.IsEmpty) Then
  Begin
    edtNomTra.Text := cdsTraRegNOMTRA.AsString;
    edtRegiao.Text := cdsTraRegNOMREG.AsString;
  End
  Else
  Begin
    edtNomTra.Clear;
    edtRegiao.Clear;
  End;
end;

procedure TfrmCadRapidoFreteTranspRegiao.cdsTraRegBeforePost(DataSet: TDataSet);
begin

  inherited;

  If fEmptyStr(cdsTraRegVALISE.AsString) Then
    cdsTraRegVALISE.AsFloat := 0;

  If fEmptyStr(cdsTraRegMINFRE.AsString) Then
    cdsTraRegMINFRE.AsFloat := 0;

  If fEmptyStr(cdsTraRegPERTOT.AsString) Then
    cdsTraRegPERTOT.AsFloat := 0;

  If fEmptyStr(cdsTraRegVALKIL.AsString) Then
    cdsTraRegVALKIL.AsFloat := 0;

  If fEmptyStr(cdsTraRegPD100K.AsString) Then
    cdsTraRegPD100K.AsFloat := 0;

  If fEmptyStr(cdsTraRegPERGRI.AsString) Then
    cdsTraRegPERGRI.AsFloat := 0;

  If fEmptyStr(cdsTraRegMINGRI.AsString) Then
    cdsTraRegMINGRI.AsFloat := 0;

  If fEmptyStr(cdsTraRegVALTAS.AsString) Then
    cdsTraRegVALTAS.AsFloat := 0;

  If fEmptyStr(cdsTraRegCODTRA.AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'O campo "Transportadora" é obrigatório!', ['&Ok']);
    DataSet.Cancel;
    Abort;
  End;

  If fEmptyStr(cdsTraRegCODREG.AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'O campo "Região" é obrigatório!', ['&Ok']);
    DataSet.Cancel;
    Abort;
  End;

  If (cdsTraRegVALISE.AsFloat < 0) Or
     (cdsTraRegMINFRE.AsFloat < 0) Or
     (cdsTraRegPERTOT.AsFloat < 0) Or
     (cdsTraRegVALKIL.AsFloat < 0) Or
     (cdsTraRegPD100K.AsFloat < 0) Or
     (cdsTraRegPERGRI.AsFloat < 0) Or
     (cdsTraRegMINGRI.AsFloat < 0) Or
     (cdsTraRegVALTAS.AsFloat < 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Todos os valores devem ser maior ou igual a Zero.', ['&Ok']);
    DataSet.Cancel;
    Abort;
  End;

end;

procedure TfrmCadRapidoFreteTranspRegiao.cdsTraRegNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsTraRegVALISE.AsFloat := 0;
  cdsTraRegMINFRE.AsFloat := 0;
  cdsTraRegPERTOT.AsFloat := 0;
  cdsTraRegVALKIL.AsFloat := 0;
  cdsTraRegPD100K.AsFloat := 0;
  cdsTraRegPERGRI.AsFloat := 0;
  cdsTraRegMINGRI.AsFloat := 0;
  cdsTraRegVALTAS.AsFloat := 0;
end;

procedure TfrmCadRapidoFreteTranspRegiao.dbeCodRegKeyPress(Sender: TObject; var Key: Char);
Var
  arrRegiao: TConsultasArray;
begin

  inherited;

  If fPesqRegiao(Self, dbeCodReg, edtRegiao, Nil, Key, arrRegiao) Then
  Begin
    If fValidaCampos(dbeCodReg, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadRapidoFreteTranspRegiao.dbeCodTraKeyPress(Sender: TObject; var Key: Char);
Var
  arrTransp: TConsultasArray;
begin

  inherited;

  If fPesqTransportadora(conTraSimples, Self, dbeCodTra, edtNomTra, Nil, Key, arrTransp) Then
  Begin
    If fValidaCampos(dbeCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadRapidoFreteTranspRegiao.edtCodTraRegKeyPress(Sender: TObject; var Key: Char);
Var
  arrTransp: TConsultasArray;
  arrRegiao: TConsultasArray;
begin

  If (strOpcTela = 'T') Then
  Begin
    If fPesqTransportadora(conTraSimples, Self, edtCodTraReg, edtNomTraReg, Nil, Key, arrTransp) Then
    Begin
      If fValidaCampos(edtCodTraReg, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End
  Else
  If (strOpcTela = 'R') Then
  Begin
    If fPesqRegiao(Self, edtCodTraReg, edtNomTraReg, Nil, Key, arrRegiao) Then
    Begin
      If fValidaCampos(edtCodTraReg, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;

end;

class function TfrmCadRapidoFreteTranspRegiao.fCadRapidoTraReg(strOpcao : String) : Boolean;
var
  frmCadRapidoFreteTranspRegiao: TfrmCadRapidoFreteTranspRegiao;
begin

  Result := False;

  frmCadRapidoFreteTranspRegiao := TfrmCadRapidoFreteTranspRegiao.Create(Nil);

  Try

    With frmCadRapidoFreteTranspRegiao Do
    Begin

      strOpcTela := strOpcao;
      lblTraCid.Caption := IIF(strOpcao = 'T', 'Transportadora', 'Região');

      cxTblFreteNOMTRA.Visible := IIF(strOpcao = 'R', True, False);
      cxTblFreteNOMREG.Visible := IIF(strOpcao = 'T', True, False);

      If (cxTblFreteNOMTRA.Visible) Then
        cxTblFreteNOMTRA.Width := cxTblFreteNOMTRA.Width * 2;

      If (cxTblFreteNOMREG.Visible) Then
        cxTblFreteNOMREG.Width := cxTblFreteNOMREG.Width * 2;

      If (strOpcao = 'T') Then
      Begin
        dbeCodTra.Color    := $00FFDFB8;
        dbeCodTra.ReadOnly := True;
        dbeCodTra.TabStop  := False;
      End
      Else
      If (strOpcao = 'R') Then
      Begin
        dbeCodReg.Color    := $00FFDFB8;
        dbeCodReg.ReadOnly := True;
        dbeCodReg.TabStop  := False;
      End;

      If ShowModal = mrOk Then
        Result := True;

    End;

  Finally
    pFreeAndNil(frmCadRapidoFreteTranspRegiao);
  End;

end;

procedure TfrmCadRapidoFreteTranspRegiao.FormCreate(Sender: TObject);
begin
  inherited;
  intConfirma := -1;
  cdsTraReg.CreateDataSet;
  cdsTraReg.EmptyDataSet;
  blnFecharComEscape := False;
end;

procedure TfrmCadRapidoFreteTranspRegiao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Not cdsTraReg.IsEmpty) And (Key = VK_INSERT) Then
    btnIncluirClick(Self);
end;

procedure TfrmCadRapidoFreteTranspRegiao.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodTraReg);

end;

function TfrmCadRapidoFreteTranspRegiao.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  frmAguarde: TfrmGravando;
begin

  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin

    If (Sender = edtCodTraReg) Then
    Begin

      If fEmptyStr(edtCodTraReg.Text) Then
        edtNomTraReg.Clear
      Else
      Begin

        {Transportadora}
        If (strOpcTela = 'T') Then
        Begin

          edtNomTraReg.Text := fRetNomTransportadora(edtCodTraReg.Text);

          If fEmptyStr(edtNomTraReg.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa transportadora não está cadastrada!', ['&Ok']);
            Result := False;
          End;

        End
        Else
        {Região}
        If (strOpcTela = 'R') Then
        Begin

          edtNomTraReg.Text := fRetNomRegiao(edtCodTraReg.Text);

          If fEmptyStr(edtNomTraReg.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa região não está cadastrada!', ['&Ok']);
            Result := False;
          End;

        End;

        {Carregar TRAREG}
        If (Result) Then
        Begin

          Try
            pCriarFormularios(TfrmGravando, frmAguarde);
            frmAguarde.fExecutarAcao := fCarregarTraReg;
            frmAguarde.ShowModal;
            Result := frmAguarde.blnConfirma;
          Except
            On E: Exception Do
            Begin
              Result := False;
              pMensagensErro(E.Message, '');
            End;
          End;

          pFreeAndNil(frmAguarde);

        End;

      End;

    End
    Else
    If (Sender = dbeCodTra) Then
    Begin

      If fEmptyStr(dbeCodTra.Text) Then
        edtNomTra.Clear
      Else
      Begin

        If (cdsTraReg.Active) And (cdsTraReg.State in [dsInsert, dsEdit]) Then
        Begin

          edtNomTra.Text := fRetNomTransportadora(dbeCodTra.Text);
          cdsTraRegNOMTRA.AsString := edtNomTra.Text;

          If fEmptyStr(edtNomTra.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa transportadora não está cadastrada!', ['&Ok']);
            Result := False;
          End;

        End;

      End;

    End
    Else
    If (Sender = dbeCodReg) Then
    Begin

      If fEmptyStr(dbeCodReg.Text) Then
      Begin
        edtRegiao.Clear;
      End
      Else
      Begin

        If (cdsTraReg.Active) And (cdsTraReg.State in [dsInsert, dsEdit]) Then
        Begin

          edtRegiao.Text := fRetNomRegiao(dbeCodReg.Text);
          cdsTraRegNOMREG.AsString := edtRegiao.Text;

          If fEmptyStr(edtRegiao.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa região não está cadastrada!', ['&Ok']);
            Result := False;
          End;

        End;

      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadRapidoFreteTranspRegiao.pLiberaEdicao(blnLiberaEdicao: Boolean);
begin
  If (blnLiberaEdicao) Then
  Begin
    pnlCabecalho.Enabled := False;
    pnlGeral.Enabled     := True;
  End
  Else
  Begin

    cdsTraReg.EmptyDataSet;
    pnlCabecalho.Enabled := True;
    pnlGeral.Enabled     := False;

    pSetFocus(edtCodTraReg);

  End;
end;

function TfrmCadRapidoFreteTranspRegiao.fCarregarTraReg(pgbStatus: TcxProgressBar = Nil) : Boolean;
const
  strSQL_TRA = 'SELECT * FROM TRAREG WHERE TRE_CODTRA = :COD';
  strSQL_REG = 'SELECT * FROM TRAREG WHERE TRE_CODREG = :COD';
var
  qryAux : TUniQuery;
begin

  pInformacao('Carregando ' + IIF(strOpcTela = 'T', 'Regiões', 'Transportadoras') + ', Aguarde...', pgbStatus);
  Result := True;

  Try

    If Not fEmptyStr(edtCodTraReg.Text) Then
    Begin

      cdsTraReg.EmptyDataSet;

      qryAux := fCriaQuery;

      Try

        qryAux.Close;
        qryAux.SQL.Clear;

        If (strOpcTela = 'T') Then
          qryAux.SQL.Add(strSQL_TRA)
        Else
          qryAux.SQL.Add(strSQL_REG);

        qryAux.ParamByName('COD').AsString := edtCodTraReg.Text;
        qryAux.Open;

        If Not qryAux.IsEmpty Then
        Begin
          qryAux.First;
          While Not qryAux.Eof Do
          Begin

            cdsTraReg.Append;

            If (strOpcTela = 'T') Then
            Begin
              cdsTraRegCODTRA.AsString := edtCodTraReg.Text;
              cdsTraRegNOMTRA.AsString := fRetNomTransportadora(cdsTraRegCODTRA.AsString);
              cdsTraRegCODREG.AsString := qryAux.FieldByName('TRE_CODREG').AsString;
              cdsTraRegNOMREG.AsString := fRetNomRegiao(cdsTraRegCODREG.AsString);
            End
            Else
            If (strOpcTela = 'R') Then
            Begin
              cdsTraRegCODTRA.AsString := qryAux.FieldByName('TRE_CODTRA').AsString;
              cdsTraRegNOMTRA.AsString := fRetNomTransportadora(cdsTraRegCODTRA.AsString);
              cdsTraRegCODREG.AsString := edtCodTraReg.Text;
              cdsTraRegNOMREG.AsString := fRetNomRegiao(cdsTraRegCODREG.AsString);
            End;

            cdsTraRegVALISE.AsFloat  := qryAux.FieldByName('TRE_VALISE').AsFloat;
            cdsTraRegMINFRE.AsFloat  := qryAux.FieldByName('TRE_MINFRE').AsFloat;
            cdsTraRegPERTOT.AsFloat  := qryAux.FieldByName('TRE_PERTOT').AsFloat;
            cdsTraRegVALKIL.AsFloat  := qryAux.FieldByName('TRE_VALKIL').AsFloat;
            cdsTraRegPD100K.AsFloat  := qryAux.FieldByName('TRE_PD100K').AsFloat;
            cdsTraRegPERGRI.AsFloat  := qryAux.FieldByName('TRE_PERGRI').AsFloat;
            cdsTraRegMINGRI.AsFloat  := qryAux.FieldByName('TRE_MINGRI').AsFloat;
            cdsTraRegVALTAS.AsFloat  := qryAux.FieldByName('TRE_VALTAS').AsFloat;
            cdsTraReg.Post;

            qryAux.Next;

          End;

          cdsTraReg.First;

        End;

        pLiberaEdicao(True);

        If cdsTraReg.IsEmpty Then
          btnIncluirClick(Self);

      Finally
        FreeAndNil(qryAux);
      End;

    End;

  Except
    Result := False;
  End;

end;

function TfrmCadRapidoFreteTranspRegiao.fGravarTRAREG(pgbStatus: TcxProgressBar): Boolean;
const
  strSQL_TRA = 'DELETE FROM TRAREG WHERE TRE_CODTRA = :COD';
  strSQL_REG = 'DELETE FROM TRAREG WHERE TRE_CODREG = :COD';
  strInsert_TRAREG = 'INSERT INTO TRAREG (TRE_CODTRA, ' +
                     '                    TRE_CODREG, ' +
                     '                    TRE_VALISE, ' +
                     '                    TRE_MINFRE, ' +
                     '                    TRE_PERTOT, ' +
                     '                    TRE_VALKIL, ' +
                     '                    TRE_PD100K, ' +
                     '                    TRE_PERGRI, ' +
                     '                    TRE_MINGRI, ' +
                     '                    TRE_VALTAS, ' +
                     '                    AUTOINCREM) VALUES ' +
                     '                   (:CODTRA,    ' +
                     '                    :CODREG,    ' +
                     '                    :VALISE,    ' +
                     '                    :MINFRE,    ' +
                     '                    :PERTOT,    ' +
                     '                    :VALKIL,    ' +
                     '                    :PD100K,    ' +
                     '                    :PERGRI,    ' +
                     '                    :MINGRI,    ' +
                     '                    :VALTAS,    ' +
                     '                    :AUTINC)    ';

var
  qryAux : TUniQuery;
begin

  Result := True;
  If (cdsTraReg.Active) And (Not cdsTraReg.IsEmpty) Then
  Begin

    fStartTransaction();

    Try

      qryAux := fCriaQuery;

      Try

        {DELETE}
        qryAux.Close;
        qryAux.SQL.Clear;

        If (strOpcTela = 'T') Then
          qryAux.SQL.Add(strSQL_TRA)
        Else
          qryAux.SQL.Add(strSQL_REG);

        qryAux.ParamByName('COD').AsString := edtCodTraReg.Text;
        qryAux.ExecSQL;

        {INSERT}
        cdsTraReg.First;
        While Not cdsTraReg.Eof Do
        Begin

          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Add(strInsert_TRAREG);

          qryAux.ParamByName('CODTRA').AsString := cdsTraRegCODTRA.AsString;
          qryAux.ParamByName('CODREG').AsString := cdsTraRegCODREG.AsString;
          qryAux.ParamByName('VALISE').AsFloat  := cdsTraRegVALISE.AsFloat;
          qryAux.ParamByName('MINFRE').AsFloat  := cdsTraRegMINFRE.AsFloat;
          qryAux.ParamByName('PERTOT').AsFloat  := cdsTraRegPERTOT.AsFloat;
          qryAux.ParamByName('VALKIL').AsFloat  := cdsTraRegVALKIL.AsFloat;
          qryAux.ParamByName('PD100K').AsFloat  := cdsTraRegPD100K.AsFloat;
          qryAux.ParamByName('PERGRI').AsFloat  := cdsTraRegPERGRI.AsFloat;
          qryAux.ParamByName('MINGRI').AsFloat  := cdsTraRegMINGRI.AsFloat;
          qryAux.ParamByName('VALTAS').AsFloat  := cdsTraRegVALTAS.AsFloat;
          qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('TRAREG', VS_strCodEmp);

          qryAux.ExecSQL;

          cdsTraReg.Next;
        End;


      Finally
        FreeAndNil(qryAux);
      End;

      fCommit();

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmCadRapidoFreteTranspRegiao.fGravarTRAREG]');
      End;
    End;

  End;

end;

end.
