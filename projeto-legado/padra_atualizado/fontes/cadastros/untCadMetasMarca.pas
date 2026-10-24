unit untCadMetasMarca;

interface

uses
  Windows, Classes, Controls, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids,
  Buttons, ExtCtrls, untModulo, BitBtnLockedIncrem, MemDS, DBAccess, Provider,
  frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmCadMetasMarca = class(TfrmPaiOrdena)
    qryCadMar: TUniQuery;
    cdsConsultaMET_CODMAR: TStringField;
    cdsConsultaMET_PERMAR: TFloatField;
    cdsConsultaMAR_DESMAR: TStringField;
    cdsConsultaAUTOINCREM: TStringField;
    cdsConsultaMET_CODEMP: TStringField;
    cdsConsultaMET_MESANO: TStringField;
    cdsConsultaMET_CODVEN: TStringField;
    cdsConsultaTOT_PERMAR: TAggregateField;
    Label3: TLabel;
    edtTotPer: TEditFocus;
    btnExcluir: TBitBtnLocked;
    edtCodMar: TEditFocus;
    Label4: TLabel;
    edtDesMar: TEditFocus;
    qryCadMarMAR_CODMAR: TStringField;
    qryCadMarMAR_DESMAR: TStringField;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure cdsConsultaBeforeDelete(DataSet: TDataSet);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure dbgConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure cdsConsultaMET_PERMARSetText(Sender: TField; const Text: string);
  private
    { Private declarations }
    function  fRetTotPerMar: Double;

    function  fMarcaJaInserida(const strMesAno, strCodVen, strCodMar: String) : Boolean;

    procedure pInsereMarca(strMesAno : String;
                           strCodVen : String;
                           strCodMar : String;
                           fltPerMar : Double);

  public
    { Public declarations }
    cdsCadMet: TUniClientDataSet;
    strMesAno: String;
    strCodVen: String;

    Procedure pLimpaDados(blnSetFocus: Boolean = True);
    procedure pAbreConsulta;

    function  fValidaTotalMarca: Boolean;

  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadMetasMarca: TfrmCadMetasMarca;

implementation

uses SysUtils, Variants, Math, untPai, untConsultas, untFuncoesSimples, untTypesSistema,
  untCadMetasValor;

{$R *.dfm}

function TfrmCadMetasMarca.fGetSql(blnLike: Boolean): String;
Begin
  Result := '';
  Result := Result + ' SELECT * FROM METMAR ';
  Result := Result + ' WHERE MET_MESANO = ' + QuotedStr(strMesAno);
End;

function TfrmCadMetasMarca.fMarcaJaInserida(const strMesAno, strCodVen, strCodMar: String): Boolean;
begin

  If Not cdsConsulta.Active Then
    Exit(False);

  If cdsConsulta.IsEmpty Then
    Exit(False);

  Result := cdsConsulta.Locate('MET_MESANO;MET_CODVEN;MET_CODMAR', VarArrayOf([strMesAno, strCodVen, strCodMar]), []);

end;

procedure TfrmCadMetasMarca.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Key = '-' Then
    Key := #0;
end;

procedure TfrmCadMetasMarca.pAbreConsulta;
Begin
  fAbreConsulta;
End;

procedure TfrmCadMetasMarca.FormShow(Sender: TObject);
begin
  inherited;

  blnTemPesquisa      := False;
  blnSempreRelerBanco := False;
  blnTemSelecao       := False;
  
  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;                

  If cdsConsulta.Active Then
    cdsConsulta.CancelUpdates;

  fAbreConsulta;

  btnMudaOrdem.Visible := False;
  btnPesquisar.Visible := False;
  btnSair.Visible      := False;
end;

Procedure TfrmCadMetasMarca.pLimpaDados(blnSetFocus: Boolean = True);
Begin

  If blnSetFocus Then
  Begin
    blnMudarFoco := False;
    pSetFocus(edtCodMar);
  End;

  edtCodMar.Clear;
  edtDesMar.Clear;
End;

function TfrmCadMetasMarca.fRetTotPerMar: Double;
Begin
  If TAggregateField(cdsConsulta.FieldByName('TOT_PERMAR')).Value = Null Then
    Result := 0
  Else
    Result := TAggregateField(cdsConsulta.FieldByName('TOT_PERMAR')).Value;
End;

function TfrmCadMetasMarca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strDesMar,
    strCodMar  : String;
begin
  Result      := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodMar) Then
    Begin
      If fEmptyStr(edtCodMar.Text) Then
      Begin
        fMensagem('', 'Informe a Marca para a meta!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        strCodMar := edtCodMar.Text;
        strDesMar := fRetNomMarca(strCodMar);

        If fEmptyStr(strDesMar) Then
        Begin
          fMensagem('', 'Marca não encontrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          edtDesMar.Text := strDesMar;
          blnMudarFoco   := False;

          If blnBuscaPorChave Then
          Begin
            strCodMar := edtCodMar.Text;

            If fMarcaJaInserida(strMesAno, strCodVen, strCodMar) Then
            Begin
              fMensagem('', 'Esta marca já foi inserida!', ['&Ok']);
              Result := False;
            End
            Else
            Begin
              pInsereMarca(strMesAno,
                           strCodVen,
                           strCodMar,
                           0.0);
              pLimpaDados;
            End;

          End;

        End;

      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadMetasMarca.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.Active And (Not cdsConsulta.IsEmpty) Then
  Begin
    If fPergunta('Confirma a exclusão da meta para a marca?') Then
      cdsConsulta.Delete;
  End;
end;

procedure TfrmCadMetasMarca.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadMar.Open;
end;

procedure TfrmCadMetasMarca.pInsereMarca(strMesAno, strCodVen, strCodMar: String; fltPerMar: Double);
begin

  cdsConsulta.Tag := 1;

  Try
    cdsConsulta.Insert;
    cdsConsulta.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('METMAR', VS_strCodEmp);
    cdsConsulta.FieldByName('MET_MESANO').AsString := strMesAno;
    cdsConsulta.FieldByName('MET_CODVEN').AsString := strCodVen;
    cdsConsulta.FieldByName('MET_CODEMP').AsString := VS_strCodEmp;
    cdsConsulta.FieldByName('MET_CODMAR').AsString := strCodMar;
    cdsConsulta.FieldByName('MET_PERMAR').AsFloat  := fltPerMar;
    cdsConsulta.Post;
  Finally
    cdsConsulta.Tag := 0;
  End;

end;

procedure TfrmCadMetasMarca.edtCodMarKeyPress(Sender: TObject; var Key: Char);
  Var
    arrMarca    : TConsultasArray;
    intPercorre : Integer;
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin

    If Length(arrMarca) > 1 Then
    Begin
      For intPercorre := 0 To Length(arrMarca) -1 Do
      Begin

        cdsConsultaMET_PERMAR.OnSetText := Nil;

        Try

          If fMarcaJaInserida(strMesAno, strCodVen, arrMarca[intPercorre].strCodigo) Then
            fMensagem('', 'Esta marca já foi inserida, Cód. Marca: ' + arrMarca[intPercorre].strCodigo, ['&Ok'])
          Else
            pInsereMarca(strMesAno,
                         strCodVen,
                         arrMarca[intPercorre].strCodigo,
                         0.0);

        Finally
          cdsConsultaMET_PERMAR.OnSetText := cdsConsultaMET_PERMARSetText;
        End;

      End;

      edtCodMar.Clear;
      edtDesMar.Clear;

    End
    Else If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);

  End;

end;

procedure TfrmCadMetasMarca.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  edtTotPer.Text := FormatFloat('#,##0.00', fRetTotPerMar);
end;

procedure TfrmCadMetasMarca.cdsConsultaAfterPost(DataSet: TDataSet);
begin
  inherited;
  edtTotPer.Text := FormatFloat('#,##0.00', fRetTotPerMar);
end;

procedure TfrmCadMetasMarca.cdsConsultaBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  edtTotPer.Text := FormatFloat('#,##0.00', fRetTotPerMar);
end;

procedure TfrmCadMetasMarca.cdsConsultaMET_PERMARSetText(Sender: TField; const Text: string);

  var
    fltTotal : Double;

begin

  inherited;

  If (TFloatField(Sender).AsFloat > 0)Then
    fltTotal := (fRetTotPerMar - TFloatField(Sender).AsFloat) + fStrToFloat(Text)
  Else
    fltTotal := fRetTotPerMar + TFloatField(Sender).AsFloat;

  If (fStrToFloat(Text) <= 0) Or
     (fStrToFloat(Text) > 100) Then
  Begin
    fMensagem('', 'O percentual deve ser maior que zero e menor ou igual a 100!', ['&Ok']);
    TFloatField(Sender).DataSet.Cancel;
  End

  Else If (fltTotal > 100) Then
  Begin
    fMensagem('', 'A Soma dos grupos deve ser igual a 100%!', ['&Ok']);
    TFloatField(Sender).DataSet.Cancel;
  End

  Else
    TFloatField(Sender).AsFloat := fStrToFloat(Text);

end;

procedure TfrmCadMetasMarca.dbgConsultaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If (Key = #13) Then
    If cdsConsulta.Active Then
      If (cdsConsulta.State in [dsEdit]) Then
        cdsConsulta.Post;

end;

function TfrmCadMetasMarca.fValidaTotalMarca: Boolean;
Begin
  If (RoundTo(fRetTotPerMar, -2) <> 100) And (RoundTo(fRetTotPerMar, -2) <> 0) Then
  Begin
    fMensagem('', 'A Soma dos grupos deve ser igual a 100%!', ['&Ok']);
    Result := False;
  End

  Else Result := True;
End;

end.
