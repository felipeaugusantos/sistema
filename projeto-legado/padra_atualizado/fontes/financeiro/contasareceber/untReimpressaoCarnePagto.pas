unit untReimpressaoCarnePagto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  frxClass, frxDBSet, StrUtils,
  Math, BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider,
  Datasnap.DBClient, frxExportCSVTestabilidade;

type
  TfrmReimpressaoCarnePagto = class(TfrmPaiOrdena)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label20: TLabel;
    edtCodCli: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtNomCli: TEditFocus;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    Label4: TLabel;
    lblInformacao: TLabel;
    rdgDuplicatas: TRadioGroup;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtNomEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbgConsultaEnter(Sender: TObject);
    procedure dbgConsultaExit(Sender: TObject);
  private
    { Private declarations }

    procedure pCancela;
    Procedure pSetaRequeridos;
    procedure pImprimeContrato;
    function fDuplicataAVista(strNumDup, strEspDoc, strCodEmp,
      strCodCli, strTabela: String): Boolean;

  public
    { Public declarations }
  protected
    function fGetSql(blnLike: Boolean): String; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fAbreConsulta(blnLike: Boolean): Boolean; override;
  end;


implementation

uses  untPai, untFuncoesSimples, untTypesSistema,
      untCarnePagto,
      untConsultas, untConstantes;

{$R *.dfm}

Procedure TfrmReimpressaoCarnePagto.pSetaRequeridos;
  Var
    intIndex: Integer;
Begin
  With cdsConsulta Do
    For intIndex := 0 To FieldDefs.Count - 1 Do
      FieldDefs[intIndex].Required := FALSE;
End;

function TfrmReimpressaoCarnePagto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodCli) Then
    Begin
      If (Not fEmptyStr(edtCodCli.Text)) Then
      Begin
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);

        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&O k']);
          Result := False;
        End;

      End
      Else
        edtNomCli.Clear;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If (Not fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
          Result := False;
        End;

      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Informe o código da empresa!', ['&O k']);
        Result := False;
        edtNomEmp.Clear;
      End;
    End

    {*****************************************}
    {* VALIDA A DATA INICIAL                 *}
    {**************************************MV*}
    Else If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Clear;
        mskDtaFin.Enabled := False;
        Result := fAbreConsulta(False);
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
      End;

    End

    {*****************************************}
    {* VALIDA A DATA FINAL                   *}
    {**************************************MV*}
    Else If (Sender = mskDtaFin) And (mskDtaFin.Enabled) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End
        Else
          Result := fAbreConsulta(False);
      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmReimpressaoCarnePagto.fGetSql(blnLike: Boolean): String;
Begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '  CONCAT(CTR_NUMDUP, CTR_PARCEL) AS CTR_DUPPAR, ';
  Result := Result + '  CTR_NUMDUP, ';
  Result := Result + '  CTR_ESPDOC, ';
  Result := Result + '  CTR_PARCEL, ';
  Result := Result + '  CTR_CODEMP, ';
  Result := Result + '  CTR_CODCLI, ';
  Result := Result + '  CTR_SEQBAI, ';
  Result := Result + '  CLI_NOMCLI, ';
  Result := Result + '  CTR_DTACAD, ';
  Result := Result + '  CTR_DTAVEN, ';
  Result := Result + '  IF(CTR_DTAREC IS NULL, CTR_VALDUP, CTR_VALORI) AS CTR_VALDUP, ';
  Result := Result + '  CTR_DTAREC, ';
  Result := Result + '  CTR_VALREC, ';
  Result := Result + '  CTR_BARCON, ';
  Result := Result + '  "CADREC" AS CTR_NOMTAB, ';
  Result := Result + '  CADREC.AUTOINCREM ';
  Result := Result + 'FROM ';
  Result := Result + '  CADREC ';
  Result := Result + '  LEFT JOIN CADCLI ON CTR_CODCLI = CLI_CODCLI ';
  Result := Result + 'WHERE ';
  Result := Result + '  IFNULL(CTR_BARCON, "") <> "" ';  

  If Not (fEmptyStr(edtCodCli.Text)) Then
    Result := Result + ' AND CLI_CODCLI = ' + QuotedStr(edtCodCli.Text);

  If Not (fEmptyStr(edtCodEmp.Text)) Then
    Result := Result + ' AND CTR_CODEMP = ' + QuotedStr(edtCodEmp.Text);

  If Not (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
  Begin
    Result := Result + ' AND ( ( CTR_DTACAD BETWEEN ' + fCurrentDate(StrToDate(mskDtaIni.Text)) + ' AND ' +
                                                        fCurrentDate(StrToDate(mskDtaFin.Text)) + ' ) OR ';

    Result := Result + '       ( CTR_DTAVEN BETWEEN ' + fCurrentDate(StrToDate(mskDtaIni.Text)) + ' AND ' +
                                                        fCurrentDate(StrToDate(mskDtaFin.Text)) + ' ) ) ';
  End;

End;

function TfrmReimpressaoCarnePagto.fDuplicataAVista(strNumDup, strEspDoc, strCodEmp, strCodCli, strTabela: String): Boolean;
  var
    strSql: String;
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  strSql := '';
  strSql := strSql + ' SELECT SQL_NO_CACHE ';
  strSql := strSql + '   CTR_DTACAD,       ';
  strSql := strSql + '   CTR_DTAVEN        ';
  strSql := strSql + ' FROM                ';
  strSql := strSql + '   ' + strTabela + ' ';
  strSql := strSql + ' WHERE               ';
  strSql := strSql + '   CTR_NUMDUP = :NUMDUP AND ';
  strSql := strSql + '   CTR_ESPDOC = :ESPDOC AND ';
  strSql := strSql + '   CTR_CODEMP = :CODEMP AND ';
  strSql := strSql + '   CTR_CODCLI = :CODCLI AND ';
  strSql := strSql + '   CTR_SEQBAI = 0 ';
  strSql := strSql + ' ORDER BY         ';
  strSql := strSql + '   CTR_PARCEL     ';

  With qryGen, SQL Do
  Begin
    Close;
    Clear;
    Add(strSql);

    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;

    Open;

    Result := (RecordCount = 1) And
              (FieldByName('CTR_DTACAD').AsDateTime = FieldByName('CTR_DTAVEN').AsDateTime);
  End;

  FreeAndNil(qryGen);
end;

procedure TfrmReimpressaoCarnePagto.pCancela;
Begin
  If (Not cdsConsulta.Active) Then
    Close
  Else
  Begin
    pLimpaPesquisa;
    cdsConsulta.Close;
    pSetFocus(edtCodCli);
  End;
End;

procedure TfrmReimpressaoCarnePagto.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of

    VK_RETURN: Begin
                 If ((ActiveControl) = dbgConsulta) Then
                 Begin
                   pImprimeContrato;
                   Key := 0;
                 End
                                           
                 Else If ((ActiveControl) is TRadioButton) Then
                 Begin
                   SelectNext(ActiveControl, True, True);
                 End;
               End;

    VK_DELETE: Begin
                 If ((ActiveControl) = dbgConsulta) Then
                   Key := 0;
               End;

    VK_ESCAPE: Begin
                 If pnlPesquisa.Visible Then
                   inherited
                 Else
                    pCancela;
               end;

    Else inherited;
  End;

end;

procedure TfrmReimpressaoCarnePagto.FormShow(Sender: TObject);
begin
  inherited;
  blnSempreRelerBanco := FALSE;
  blnTemSelecao       := FALSE;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);  

  pSetFocus(edtCodCli);
end;

procedure TfrmReimpressaoCarnePagto.btnSairClick(Sender: TObject);
begin
  pCancela;
end;

procedure TfrmReimpressaoCarnePagto.dbgConsultaEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'Pressione [Enter] para imprimir o contrato';
end;

procedure TfrmReimpressaoCarnePagto.dbgConsultaExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmReimpressaoCarnePagto.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmReimpressaoCarnePagto.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmReimpressaoCarnePagto.edtNomEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmReimpressaoCarnePagto.fAbreConsulta(blnLike: Boolean): Boolean;
  var
    blnAVista: Boolean;
Begin
  Result := (inherited fAbreConsulta(blnLike));

  pSetaRequeridos;

  TFloatField(cdsConsulta.FieldByName('CTR_VALDUP')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsConsulta.FieldByName('CTR_VALREC')).DisplayFormat := fMskDigitos(2);

  If rdgDuplicatas.ItemIndex in [1,2] Then
  Begin
    With cdsConsulta Do
    Begin
      DisableControls;
      First;

      While Not Eof Do
      Begin
        blnAVista := fDuplicataAVista(FieldByName('CTR_NUMDUP').AsString,
                                      FieldByName('CTR_ESPDOC').AsString,
                                      FieldByName('CTR_CODEMP').AsString,
                                      FieldByName('CTR_CODCLI').AsString,
                                      FieldByName('CTR_NOMTAB').AsString);

        If ((rdgDuplicatas.ItemIndex = A_PRAZO) And (blnAVista)) Or
           ((rdgDuplicatas.ItemIndex = A_VISTA) And (Not blnAVista)) Then
        Begin
          Delete;
        End
        Else
          Next;
      End;

      First;
      EnableControls;
    End;
  End;

  If (Not cdsConsulta.IsEmpty) Then
    pSetFocus(dbgConsulta)
  Else
  Begin
    pMensagemOk('Nehuma duplicata foi encontrada!');
    Result := False;
  End;

End;

procedure TfrmReimpressaoCarnePagto.pImprimeContrato;
  Const
    INT_CONTRATO = 1;
    INT_CARNEPAG = 2;
    INT_AMBOSDOC = 3;

  var
    intOpcaoSel: Integer;
    objCarnePagto: TCarnePagamento;
begin
  If (Not cdsConsulta.IsEmpty) Then
  Begin
    intOpcaoSel := fMensagem('', 'Selecione a Impressão: ', ['&Contrato', 'C&arnê', 'A&mbos', 'Ca&ncelar']);

    objCarnePagto := TCarnePagamento.Create(Self, cdsConsulta.FieldByName('CTR_BARCON').AsString);

    Case intOpcaoSel Of

      INT_CONTRATO: objCarnePagto.fImprimirContrato;

      INT_CARNEPAG: objCarnePagto.fImprimirCarneRecibo;

      INT_AMBOSDOC: Begin
                      objCarnePagto.fImprimirContrato;
                      objCarnePagto.fImprimirCarneRecibo;
                    End;
    End;

    FreeAndNil(objCarnePagto);
  End;
end;

end.
