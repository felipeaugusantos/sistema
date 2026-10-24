unit untFatAltComissao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons,
  ExtCtrls, DB, Uni, BitBtnLockedIncrem, Grids, DBGridCitel, DBGrids, UniClientDataSet,
  frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmFatAltComissao = class(TfrmPai)
    pnlBusca: TPanel;
    lblDoc: TLabel;
    lblEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    edtDesEmp: TEditFocus;
    pnlDados: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    edtCodCli: TEditFocus;
    edtDtaFat: TEditFocus;
    edtConPag: TEditFocus;
    edtDesCli: TEditFocus;
    lblEsp: TLabel;
    lblVenAtu: TLabel;
    edtDesVen: TEditFocus;
    Label7: TLabel;
    edtValDoc: TEditFocus;
    edtDocum: TEditFocus;
    btnConfirma: TBitBtnLocked;
    edtCodVen: TEditFocus;
    lblRepAtu: TLabel;
    edtCodRep: TEditFocus;
    edtDesRep: TEditFocus;
    pnlComissao: TPanel;
    dbgProdutos: TDBGridCitel;
    cdsProdutos: TUniClientDataSet;
    dtsProdutos: TDataSource;
    cdsProdutosCODITE: TStringField;
    cdsProdutosDESCRI: TStringField;
    cdsProdutosUNIDAD: TStringField;
    cdsProdutosQTDITE: TFloatField;
    cdsProdutosUNITAR: TFloatField;
    cdsProdutosTOTITE: TFloatField;
    cdsProdutosCODVEN: TStringField;
    cdsProdutosPERCOM: TFloatField;
    cdsProdutosTOTCOM: TFloatField;
    cdsProdutosCODREP: TStringField;
    cdsProdutosPERREP: TFloatField;
    cdsProdutosCOMREP: TFloatField;
    btnComVenTodos: TBitBtnLocked;
    btnComRepTodos: TBitBtnLocked;
    cdsProdutosTABELA: TStringField;
    cdsProdutosAUTINC: TStringField;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure dbgProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsProdutosAfterPost(DataSet: TDataSet);
    procedure cdsProdutosAfterCancel(DataSet: TDataSet);
    procedure cdsProdutosAfterScroll(DataSet: TDataSet);
    procedure cdsProdutosBeforePost(DataSet: TDataSet);
    procedure btnComVenTodosClick(Sender: TObject);
  private
    { Private declarations }

    procedure pLimpaTela;
    procedure pCarregaDados(qryDados: TUniQuery);

    procedure pAlteraComissao;

    function fBuscaDocumento(strNumdoc, strEspDoc, strCodEmp: String): Boolean;

  public
    { Public declarations }

    blnBuscaDoc : Boolean; 

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    procedure pEscapePressed; Override;
    procedure pHabilitaBusca(blnHabilita: Boolean);

  end;

implementation

uses StrUtils, untConsultas, untFuncoesConsulta, untFuncoesSimples, untTypesSistema;

{$R *.dfm}

procedure TfrmFatAltComissao.cdsProdutosAfterCancel(DataSet: TDataSet);
begin
  inherited;
  dbgProdutos.Options := dbgProdutos.Options + [dgRowSelect];
end;

procedure TfrmFatAltComissao.cdsProdutosAfterPost(DataSet: TDataSet);
begin
  inherited;
  If dbgProdutos.SelectedField <> cdsProdutos.FieldByName('PERCOM') Then
    dbgProdutos.Options := dbgProdutos.Options + [dgRowSelect];
end;

procedure TfrmFatAltComissao.cdsProdutosAfterScroll(DataSet: TDataSet);
begin
  inherited;
  dbgProdutos.Options := dbgProdutos.Options + [dgRowSelect];
end;

procedure TfrmFatAltComissao.cdsProdutosBeforePost(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin
    If (FieldByName('PERCOM').AsFloat < 0) Then
    Begin
      cdsProdutos.FieldByName('PERCOM').FocusControl;
      fMensagem('ATENÇÃO!', 'Porcentagem de comissão para vendedor não pode ser negativa', ['&Ok']);
      Cancel;
      Abort;
      Exit;
    End;

    If (FieldByName('PERCOM').AsFloat > 100) Then
    Begin
      cdsProdutos.FieldByName('PERCOM').FocusControl;
      fMensagem('ATENÇÃO!', 'Porcentagem de comissão para vendedor não pode ser maior que 100%', ['&Ok']);
      Cancel;
      Abort;
      Exit;      
    End;

    If (FieldByName('PERREP').AsFloat < 0) Then
    Begin
      cdsProdutos.FieldByName('PERCOM').FocusControl;
      fMensagem('ATENÇÃO!', 'Porcentagem de comissão para representante não pode ser negativa', ['&Ok']);
      Cancel;
      Abort;
      Exit;
    End;

    If (FieldByName('PERREP').AsFloat > 100) Then
    Begin
      cdsProdutos.FieldByName('PERCOM').FocusControl;
      fMensagem('ATENÇÃO!', 'Porcentagem de comissão para representante não pode ser maior que 100%', ['&Ok']);
      Cancel;
      Abort;
      Exit;      
    End;

    FieldByName('TOTCOM').AsFloat := FieldByName('TOTITE').AsFloat * (FieldByName('PERCOM').AsFloat/100);
    FieldByName('COMREP').AsFloat := FieldByName('TOTITE').AsFloat * (FieldByName('PERREP').AsFloat/100);
  End;
end;

procedure TfrmFatAltComissao.dbgProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = Vk_Return) Then
  Begin

    If (cdsProdutos.State <> dsEdit) Then
    Begin
      dbgProdutos.Options := dbgProdutos.Options - [dgRowSelect];
      dbgProdutos.Options := dbgProdutos.Options + [dgEditing];
      dbgProdutos.SelectedField := cdsProdutos.FieldByName('PERCOM');
      cdsProdutos.Edit;
    End
    Else
    Begin
      If dbgProdutos.SelectedField = cdsProdutos.FieldByName('PERCOM') Then
      Begin
        cdsProdutos.Post;
        cdsProdutos.Edit;

        dbgProdutos.SelectedField := cdsProdutos.FieldByName('PERREP');
      End
      Else If dbgProdutos.SelectedField = cdsProdutos.FieldByName('PERREP') Then
      Begin
        cdsProdutos.Post;
      End;
    End;

  End

  Else If Key = Vk_Escape Then
    pSetFocus(btnConfirma);
end;

procedure TfrmFatAltComissao.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatAltComissao.fBuscaDocumento(strNumdoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    qryGen : TUniQuery;
    strSql : String;
    strSQLMovGer : String;
    strSQLNotGer : String;
begin
  If Not blnBuscaDoc Then
  Begin
    Result := True;
    Exit;
  End;

  strSQLMovGer := '';
  strSQLMovGer := strSQLMovGer + '  SELECT SQL_NO_CACHE                           ';
  strSQLMovGer := strSQLMovGer + '    GER_CODCLI AS CODCLI,                       ';
  strSQLMovGer := strSQLMovGer + '    CLI_NOMCLI AS NOMCLI,                       ';
  strSQLMovGer := strSQLMovGer + '    GER_CODREP AS CODREP,                       ';
  strSQLMovGer := strSQLMovGer + '    GER_DTAENT AS DTAENT,                       ';
  strSQLMovGer := strSQLMovGer + '    GER_VLRCON AS VALDOC,                       ';
  strSQLMovGer := strSQLMovGer + '    GER_CONPAG AS CONPAG,                       ';
  strSQLMovGer := strSQLMovGer + '    GER_CODVEN AS CODVEN,                       ';
  strSQLMovGer := strSQLMovGer + '    OPE_NOMOPE AS NOMVEN,                       ';
  strSQLMovGer := strSQLMovGer + '    (SELECT OPE_NOMOPE                          ';
  strSQLMovGer := strSQLMovGer + '     FROM                                       ';
  strSQLMovGer := strSQLMovGer + '       CADOPE                                   ';
  strSQLMovGer := strSQLMovGer + '     WHERE OPE_CODOPE = GER_CODREP) AS NOMREP   ';
  strSQLMovGer := strSQLMovGer + '  FROM                                          ';
  strSQLMovGer := strSQLMovGer + '    MOVGER                                      ';
  strSQLMovGer := strSQLMovGer + '    LEFT JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
  strSQLMovGer := strSQLMovGer + '    LEFT JOIN CADOPE ON OPE_CODOPE = GER_CODVEN ';
  strSQLMovGer := strSQLMovGer + '  WHERE                                         ';
  strSQLMovGer := strSQLMovGer + '    GER_NUMDOC =:NUMDOC AND                     ';
  strSQLMovGer := strSQLMovGer + '    GER_ESPDOC =:ESPDOC AND                     ';
  strSQLMovGer := strSQLMovGer + '    GER_CODEMP =:CODEMP AND                     ';
  strSQLMovGer := strSQLMovGer + '    GER_TIP_FC = "C"                            ';

  strSQLNotGer := AnsiReplaceStr(strSQLMovGer, 'MOVGER', 'NOTGER');

  strSQLNotGer := AnsiReplaceStr(strSQLNotGer, 'GER_CODREP', '""');
  strSql := strSQLMovGer + ' UNION ALL ' + strSQLNotGer;

  qryGen := fCriaQuery(Nil);

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumdoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    If IsEmpty Then
      Result := False
    Else
    Begin
      pCarregaDados(qryGen);
      Result := True;
    End;

  End;

  FreeAndNil(qryGen);
end;

procedure TfrmFatAltComissao.pCarregaDados(qryDados: TUniQuery);

  procedure pCarregaComissao;
    Var
      qryAux: TUniQuery;
      strSQL,
      strSQLN: String;
  Begin
    qryAux := fCriaQuery;
    cdsProdutos.EmptyDataSet;

    Try
      With qryAux Do
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT SQL_NO_CACHE                           ';
        strSQL := strSQL + '  DET_CODITE AS CODITE,                       ';
        strSQL := strSQL + '  DET_DESCRI AS DESCRI,                       ';
        strSQL := strSQL + '  UNI_DESUNI AS UNIDAD,                       ';
        strSQL := strSQL + '  DET_QTDITE AS QTDITE,                       ';
        strSQL := strSQL + '  DET_UNITAR AS UNITAR,                       ';
        strSQL := strSQL + ' (DET_TOTITE - DET_DESESP) AS TOTITE,         ';
        strSQL := strSQL + '  DET_CODVEN AS CODVEN,                       ';
        strSQL := strSQL + '  DET_PERCOM AS PERCOM,                       ';
        strSQL := strSQL + '  DET_TOTCOM AS TOTCOM,                       ';
        strSQL := strSQL + '  DET_CODREP AS CODREP,                       ';
        strSQL := strSQL + '  DET_COMREP AS COMREP,                       ';
        strSQL := strSQL + '  DET_PERREP AS PERREP,                       ';
        strSQL := strSQL + '  MOVDET.AUTOINCREM AS AUTINC,                ';
        strSQL := strSQL + '  "MOVDET" AS TABELA                          ';
        strSQL := strSQL + 'FROM                                          ';
        strSQL := strSQL + '  MOVDET LEFT JOIN CADUNI ON DET_UNIDAD = UNI_CODUNI ';
        strSQL := strSQL + 'WHERE                                         ';
        strSQL := strSQL + '  DET_NUMDOC =:NUMDOC AND                     ';
        strSQL := strSQL + '  DET_ESPDOC =:ESPDOC AND                     ';
        strSQL := strSQL + '  DET_CODEMP =:CODEMP AND                     ';
        strSQL := strSQL + '  DET_TIP_FC = "C"                            ';

        strSQLN := AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET');

        strSQL := strSQL + ' UNION ALL ' + strSQLN;

        SQL.Clear;        
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := edtCodEmp.Text;
        ParamByName('NUMDOC').AsString := edtDocum.Text;
        ParamByName('ESPDOC').AsString := edtEspDoc.Text;
        Open;
        First;
        
        If Not IsEmpty Then
        Begin
          While Not EOF Do
          Begin
            cdsProdutos.Insert;
            cdsProdutos.FieldByName('CODITE').AsString := FieldByName('CODITE').AsString;
            cdsProdutos.FieldByName('DESCRI').AsString := FieldByName('DESCRI').AsString;
            cdsProdutos.FieldByName('UNIDAD').AsString := FieldByName('UNIDAD').AsString;
            cdsProdutos.FieldByName('QTDITE').AsFloat  := FieldByName('QTDITE').AsFloat;
            cdsProdutos.FieldByName('UNITAR').AsFloat  := FieldByName('UNITAR').AsFloat;
            cdsProdutos.FieldByName('TOTITE').AsFloat  := FieldByName('TOTITE').AsFloat;
            cdsProdutos.FieldByName('CODVEN').AsString := FieldByName('CODVEN').AsString;
            cdsProdutos.FieldByName('PERCOM').AsFloat  := FieldByName('PERCOM').AsFloat;
            cdsProdutos.FieldByName('TOTCOM').AsFloat  := FieldByName('TOTCOM').AsFloat;
            cdsProdutos.FieldByName('CODREP').AsString := FieldByName('CODREP').AsString;
            cdsProdutos.FieldByName('PERREP').AsFloat  := FieldByName('PERREP').AsFloat;
            cdsProdutos.FieldByName('COMREP').AsFloat  := FieldByName('COMREP').AsFloat;
            cdsProdutos.FieldByName('AUTINC').AsString := FieldByName('AUTINC').AsString;
            cdsProdutos.FieldByName('TABELA').AsString := FieldByName('TABELA').AsString;
            cdsProdutos.Post;

            Next;
          End;
        End;
      End;
    Finally
      FreeAndNil(qryAux);
    End;

    cdsProdutos.IndexFieldNames := 'CODITE';    
    cdsProdutos.First;    
  End;

begin
  With qryDados Do
  Begin
    edtCodCli.Text := FieldByName('CODCLI').AsString;
    edtDesCli.Text := FieldByName('NOMCLI').AsString;
    edtDtaFat.Text := FormatDateTime('DD/MM/YY', FieldByName('DTAENT').AsDateTime);
    edtConPag.Text := fFormataCondPag(FieldByName('CONPAG').AsString);
    edtValDoc.Text := FormatFloat('##,#0.00', FieldByName('VALDOC').AsFloat);
    edtCodVen.Text := FieldByName('CODVEN').AsString ;
    edtDesVen.Text := FieldByName('NOMVEN').AsString;

      edtCodRep.Text := FieldByName('CODREP').AsString;
      edtDesRep.Text := FieldByName('NOMREP').AsString;

    pCarregaComissao;
    
    btnConfirma.Enabled := True;
    pHabilitaBusca(False);
  End;
end;

procedure TfrmFatAltComissao.pLimpaTela;
  Var
    intIdx: Integer;
begin
  For intIdx := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intIdx] Is TEditFocus Then
      (Self.Components[intIdx] As TEditFocus).Clear;
  End;

  cdsProdutos.EmptyDataSet;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  
  btnConfirma.Enabled := False;
  pHabilitaBusca(True);

  blnBuscaDoc := True;  

  pSetFocus(edtDocum);
end;

function TfrmFatAltComissao.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtDocum) Then
    Begin
      If fEmptyStr(edtDocum.Text) Then
      Begin
        fMensagem('','Digite o número do documento !',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtEspDoc) Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('','Digite a espécie do documento !',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('','Digite o código da empresa !',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('','Empresa digitada não foi encontrada, verifique !',['&O K']);
          Result := False;
        End
        Else If Not fBuscaDocumento(edtDocum.Text, edtEspDoc.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('','Documento digitado não foi encontrado, verifique !',['&O K']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatAltComissao.FormCreate(Sender: TObject);
begin
  inherited;
  edtDocum.TamCampo  := fTamDocCadRec;
  edtDocum.MaxLength := fTamDocCadRec;

  pSetaCodIte(cdsProdutosCODITE);
  cdsProdutos.CreateDataSet;
end;

procedure TfrmFatAltComissao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of

    VK_RETURN: Begin
                 If (ActiveControl) is TRadioButton Then
                   SelectNext(ActiveControl, True, True);
               End;

    VK_ESCAPE: Begin
                 If (ActiveControl) is TRadioButton Then
                   pEscapePressed;
               End;

    VK_F8 : btnComVenTodos.Click;
    VK_F9 : btnComRepTodos.Click;
  End;
end;

procedure TfrmFatAltComissao.FormShow(Sender: TObject);
begin
  inherited;
  
  pLimpaTela;
end;

procedure TfrmFatAltComissao.btnComVenTodosClick(Sender: TObject);
  Var
    fltComRep : Double;
    strNomCam,
    strCodIte : String;
begin
  inherited;

  strCodIte := cdsProdutos.FieldByName('CODITE').AsString; 

  If Sender = btnComVenTodos Then
    strNomCam := 'PERCOM'
  Else If Sender = btnComRepTodos Then
    strNomCam := 'PERREP';

  fltComRep := cdsProdutos.FieldByName(strNomCam).AsFloat;

  If fMensagem('','Deseja repassar a comissão de ' + FormatFloat('#,##0.00',fltComRep) +
                  ' para todos os produtos?', ['','']) = 2 Then
    Exit;

  Try
    With cdsProdutos DO
    Begin
      DisableControls;
      First;
      While Not Eof do
      Begin
        Edit;
        FieldByName(strNomCam).AsFloat := fltComRep;
        Post;
        Next;
      End;
      EnableControls;
    End;

    cdsProdutos.Locate('CODITE',strCodIte,[]);
  Except
    //
  End;
end;

procedure TfrmFatAltComissao.btnConfirmaClick(Sender: TObject);
Var
  strVenRep : String;
begin
  inherited;
  strVenRep := 'da Comissão';

  If fMensagem('','Confirma alteração ' + strVenRep + '?', ['','']) = 2 Then
    Exit;

  blnBuscaDoc := False;    

  If Not fVerificaCampos Then
    Exit
  Else
  Begin
    pAlteraComissao;
    pLimpaTela;
  End;
end;

procedure TfrmFatAltComissao.pAlteraComissao;
  Var
     strSqlMovGer,
     strSqlMovDet,
     strSqlCadRec,
     strSqlCtrCnf,
     strSqlDupAgr,
     strCndPag,
     strUPDTmp    : String;

     QryUpdate,
     QryTmp       : TUniQuery;

     fltTotComVen,
     fltCurValorV,
     fltValParV,     
     fltTotComRep,
     fltCurValorR,
     fltValParR,
     fltCurValVTmp,
     fltCurValRTmp,
     fltValDupTotPar: Double;

     intQtdDup,
     intContador  : Integer;

  function fValDup(blnDupAgr: Boolean = False): String;
  begin
    If (blnDupAgr) Then
      Result := ' ( IFNULL(CTR_VALDUP,0) - IFNULL(CTR_VALJUR,0) - IFNULL(CTR_VALCOB,0) + IFNULL(CTR_VALDES,0) ) '
    Else
      Result := ' ( IFNULL(CTR_VALDUP,0) + IFNULL(CTR_VALREC,0) - IFNULL(CTR_VALJUR,0) - IFNULL(CTR_VALCOB,0) + IFNULL(CTR_VALDES,0) ) ';
  end;

  function fGetValDupTotalParcela(strTabela, strParcela: String;
                                  blnDupAgr: Boolean = False): Double;
  Begin
    Result := fCampoTabela('SUM('+ fValDup(blnDupAgr) + ')',
                           strTabela,
                           ['CTR_PARCEL',
                            'CTR_NUMDUP',
                            'CTR_ESPDOC',
                            'CTR_CODEMP',
                            'CTR_CODCLI'],
                            [strParcela,
                             edtDocum.Text,
                             edtEspDoc.Text,
                             edtCodEmp.Text,
                             edtCodCli.Text]);
  End;

  function fGetQtdSeqBai(strTabela, strParcela: String; blnDupAgr: Boolean = False): Integer;
    Var
      strSQL: string;
  Begin
    strSQL := '';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + ' ' + strTabela + ' ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDOC AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI     ';

    If Assigned(QryTmp) Then
      FreeAndNil(QryTmp);

    QryTmp := fCriaQuery(nil);

    With QryTmp Do
    Begin
      SQL.Clear;
      SQL.Add(' SELECT COUNT(*) AS QTD ');
      SQL.Add(strSQL);

      ParamByName('PARCEL').AsString := strParcela;
      ParamByName('NUMDOC').AsString := edtDocum.Text;
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ParamByName('CODCLI').AsString := edtCodCli.Text;

      Open;

      If Not IsEmpty Then
        Result := FieldByName('QTD').AsInteger
      Else
        Result := 0;

      If Result > 0 Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT CTR_SEQBAI, ' + fValDup(blnDupAgr) + ' AS VALDUP ');
        SQL.Add(strSQL);

        ParamByName('PARCEL').AsString := strParcela;
        ParamByName('NUMDOC').AsString := edtDocum.Text;
        ParamByName('ESPDOC').AsString := edtEspDoc.Text;
        ParamByName('CODEMP').AsString := edtCodEmp.Text;
        ParamByName('CODCLI').AsString := edtCodCli.Text;

        Open;
      End;
    End;
  End;
begin
  fltTotComVen := 0;
  fltTotComRep := 0;
  strCndPag := fTiraCaracEspeciaisParenteses(edtConPag.Text);
  intQtdDup := StrToIntDef(Copy(strCndPag,0,2),0);  

  strSqlMovDet := '';
  strSqlMovDet := strSqlMovDet + 'UPDATE                     ';
  strSqlMovDet := strSqlMovDet + '  TABELA                   ';
  strSqlMovDet := strSqlMovDet + 'SET                        ';
  strSqlMovDet := strSqlMovDet + '  DET_PERCOM = :PERCOM,    ';
  strSqlMovDet := strSqlMovDet + '  DET_TOTCOM = :VRLCOM,    ';
  strSqlMovDet := strSqlMovDet + '  DET_PERREP = :PERREP,    ';
  strSqlMovDet := strSqlMovDet + '  DET_COMREP = :VLCORE     ';
  strSqlMovDet := strSqlMovDet + 'WHERE                      ';
  strSqlMovDet := strSqlMovDet + '  DET_NUMDOC = :NUMDOC AND ';
  strSqlMovDet := strSqlMovDet + '  DET_ESPDOC = :ESPDOC AND ';
  strSqlMovDet := strSqlMovDet + '  DET_CODEMP = :CODEMP AND ';
  strSqlMovDet := strSqlMovDet + '  DET_CODCLI = :CODCLI AND ';
  strSqlMovDet := strSqlMovDet + '  DET_TIP_FC = "C"     AND ';
  strSqlMovDet := strSqlMovDet + '  DET_CODITE = :CODITE AND ';
  strSqlMovDet := strSqlMovDet + '  AUTOINCREM = :AUTINC     ';

  strSqlCadRec := '';
  strSqlCadRec := strSqlCadRec + 'UPDATE                               ';
  strSqlCadRec := strSqlCadRec + '  TABELA                             ';
  strSqlCadRec := strSqlCadRec + 'SET                                  ';
  strSqlCadRec := strSqlCadRec + '  CTR_FATCOM = ROUND(:TOTCOM / (fValDup), 8), ';
  strSqlCadRec := strSqlCadRec + '  CTR_VALCOM = :TOTCOM,              ';
  strSqlCadRec := strSqlCadRec + '  CTR_FATREP = ROUND(:TOCORE / (fValDup), 8), ';
  strSqlCadRec := strSqlCadRec + '  CTR_COMREP = :TOCORE               ';
  strSqlCadRec := strSqlCadRec + 'WHERE                                ';
  strSqlCadRec := strSqlCadRec + '  CTR_PARCEL = :PARCEL AND           ';
  strSqlCadRec := strSqlCadRec + '  CTR_NUMDUP = :NUMDOC AND           ';
  strSqlCadRec := strSqlCadRec + '  CTR_ESPDOC = :ESPDOC AND           ';
  strSqlCadRec := strSqlCadRec + '  CTR_CODEMP = :CODEMP AND           ';
  strSqlCadRec := strSqlCadRec + '  CTR_CODCLI = :CODCLI               ';

  strSqlCtrCnf := AnsiReplaceStr(strSqlCadRec,'(fValDup)', fValDup);
  strSqlDupAgr := AnsiReplaceStr(strSqlCadRec,'(fValDup)', fValDup(True));
  strSqlCadRec := AnsiReplaceStr(strSqlCadRec,'(fValDup)', fValDup);

  strSqlMovGer := '';
  strSqlMovGer := strSqlMovGer + 'UPDATE TABGER G, TABAUX A            ';
  strSqlMovGer := strSqlMovGer + 'SET    A.AUX_ALTCOM = "S"            ';
  strSqlMovGer := strSqlMovGer + 'WHERE  A.AUX_SEQGER = G.AUTOINCREM   ';
  strSqlMovGer := strSqlMovGer + 'AND    G.GER_NUMDOC = :NUMDOC        ';
  strSqlMovGer := strSqlMovGer + 'AND    G.GER_ESPDOC = :ESPDOC        ';
  strSqlMovGer := strSqlMovGer + 'AND    G.GER_CODEMP = :CODEMP        ';
  strSqlMovGer := strSqlMovGer + 'AND    G.GER_CODCLI = :CODCLI        ';
  strSqlMovGer := strSqlMovGer + 'AND    G.GER_TIP_FC = "C"            ';

  QryUpdate := fCriaQuery(Nil);

  With QryUpdate Do
  Begin

    strSqlMovDet := AnsiReplaceStr(strSqlMovDet,'TABELA','MOVDET');
    strSqlCadRec := AnsiReplaceStr(strSqlCadRec,'TABELA','CADREC');
    strSqlCtrCnf := AnsiReplaceStr(strSqlCtrCnf,'TABELA','CTRCNF');
    strSqlDupAgr := AnsiReplaceStr(strSqlDupAgr,'TABELA','DUPAGR');
    strSqlMovGer := AnsiReplaceStr(AnsiReplaceStr(strSqlMovGer, 'TABGER', 'MOVGER'), 'TABAUX', 'AUXMOV');

    cdsProdutos.First;
    while Not cdsProdutos.Eof Do
    Begin
      fltTotComVen := fltTotComVen + cdsProdutos.FieldByName('TOTCOM').AsFloat;
      fltTotComRep := fltTotComRep + cdsProdutos.FieldByName('COMREP').AsFloat;

      SQL.Clear;
      SQL.Add(AnsiReplaceStr(strSqlMovDet, 'TABELA', cdsProdutos.FieldByName('TABELA').AsString));
      ParamByName('PERCOM').AsFloat  := cdsProdutos.FieldByName('PERCOM').AsFloat;
      ParamByName('VRLCOM').AsFloat  := cdsProdutos.FieldByName('TOTCOM').AsFloat;
      ParamByName('PERREP').AsFloat  := cdsProdutos.FieldByName('PERREP').AsFloat;
      ParamByName('VLCORE').AsFloat  := cdsProdutos.FieldByName('COMREP').AsFloat;
      ParamByName('NUMDOC').AsString := edtDocum.Text;
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ParamByName('CODCLI').AsString := edtCodCli.Text;
      ParamByName('CODITE').AsString := cdsProdutos.FieldByName('CODITE').AsString;
      ParamByName('AUTINC').AsString := cdsProdutos.FieldByName('AUTINC').AsString;
      ExecSQL;

      If cdsProdutos.FieldByName('TABELA').AsString = 'MOVDET' Then
      Begin
        SQL.Clear;
        SQL.Add(strSqlMovGer);
        ParamByName('NUMDOC').AsString := edtDocum.Text;
        ParamByName('ESPDOC').AsString := edtEspDoc.Text;
        ParamByName('CODEMP').AsString := edtCodEmp.Text;
        ParamByName('CODCLI').AsString := edtCodCli.Text;
        ExecSQL;
      End;

      cdsProdutos.Next;
    End;

    intContador := 0;
    While intContador <= intQtdDup -1 Do
    Begin
      fltValParV   := fFormataFloat(fltTotComVen / (intQtdDup - intContador),2);
      fltCurValorV := fltValParV;

      If ((fltValParV * intQtdDup) < fltTotComVen) Then
        fltCurValorV := fltValParV + (fltTotComVen - (fltValParV * intQtdDup));

      fltValParR   := fFormataFloat(fltTotComRep / (intQtdDup - intContador),2);
      fltCurValorR := fltValParR;

      If ((fltValParR * intQtdDup) < fltTotComRep) Then
        fltCurValorR := fltValParR + (fltTotComRep - (fltValParR * intQtdDup));

      fltValDupTotPar := fGetValDupTotalParcela('CADREC',
                                                String(arrLetras[intContador]));

      fltValDupTotPar := fltValDupTotPar +
                         fGetValDupTotalParcela('CTRCNF',
                                                String(arrLetras[intContador]));

      If fGetQtdSeqBai('CADREC',
                       String(arrLetras[intContador])) > 1 Then
      Begin
        QryTmp.First;

        While Not QryTmp.Eof Do
        Begin
          If fFormataFloat(fltValDupTotPar, 2) <> 0 Then
          Begin
            fltCurValVTmp := (fltCurValorV * QryTmp.FieldByName('VALDUP').AsFloat) / fltValDupTotPar;
            fltCurValRTmp := (fltCurValorR * QryTmp.FieldByName('VALDUP').AsFloat) / fltValDupTotPar;
          End
          Else
          Begin
            fltCurValVTmp := fltCurValorV;
            fltCurValRTmp := fltCurValorR;
          end;

          strUPDTmp := strSqlCadRec + ' AND CTR_SEQBAI = :SEQBAI ';

          SQL.Clear;
          SQL.Add(strUPDTmp);
          ParamByName('TOTCOM').AsFloat   := fltCurValVTmp;
          ParamByName('TOCORE').AsFloat   := fltCurValRTmp;
          ParamByName('PARCEL').AsString  := String(arrLetras[intContador]);
          ParamByName('SEQBAI').AsInteger := QryTmp.FieldByName('CTR_SEQBAI').AsInteger;
          ParamByName('NUMDOC').AsString  := edtDocum.Text;
          ParamByName('ESPDOC').AsString  := edtEspDoc.Text;
          ParamByName('CODEMP').AsString  := edtCodEmp.Text;
          ParamByName('CODCLI').AsString  := edtCodCli.Text;
          ExecSQL;

          QryTmp.Next;
        End;
      End
      Else
      Begin
        QryTmp.First;

        If (fFormataFloat(fltValDupTotPar, 2) <> 0) And
           (QryTmp.FindField('VALDUP') <> Nil)  Then
        Begin
          fltCurValVTmp := (fltCurValorV * QryTmp.FieldByName('VALDUP').AsFloat) / fltValDupTotPar;
          fltCurValRTmp := (fltCurValorR * QryTmp.FieldByName('VALDUP').AsFloat) / fltValDupTotPar;
        End
        Else
        Begin
          fltCurValVTmp := fltCurValorV;
          fltCurValRTmp := fltCurValorR;
        end;

        SQL.Clear;
        SQL.Add(strSqlCadRec);
        ParamByName('TOTCOM').AsFloat   := fltCurValVTmp;
        ParamByName('TOCORE').AsFloat   := fltCurValRTmp;
        ParamByName('PARCEL').AsString  := String(arrLetras[intContador]);
        ParamByName('NUMDOC').AsString  := edtDocum.Text;
        ParamByName('ESPDOC').AsString  := edtEspDoc.Text;
        ParamByName('CODEMP').AsString  := edtCodEmp.Text;
        ParamByName('CODCLI').AsString  := edtCodCli.Text;
        ExecSQL;
      End;

      If fGetQtdSeqBai('CTRCNF', String(arrLetras[intContador])) > 1 Then
      Begin
        QryTmp.First;

        While Not QryTmp.Eof Do
        Begin
          If fltValDupTotPar <> 0 Then
          Begin
            fltCurValVTmp := (fltCurValorV * QryTmp.FieldByName('VALDUP').AsFloat) / fltValDupTotPar;
            fltCurValRTmp := (fltCurValorR * QryTmp.FieldByName('VALDUP').AsFloat) / fltValDupTotPar;
          End
          Else
          Begin
            fltCurValVTmp := fltCurValorV;
            fltCurValRTmp := fltCurValorR;
          end;

          strUPDTmp := strSqlCtrCnf + ' AND CTR_SEQBAI = :SEQBAI ';

          SQL.Clear;
          SQL.Add(strUPDTmp);
          ParamByName('TOTCOM').AsFloat   := fltCurValVTmp;
          ParamByName('TOCORE').AsFloat   := fltCurValRTmp;
          ParamByName('PARCEL').AsString  := String(arrLetras[intContador]);
          ParamByName('SEQBAI').AsInteger := QryTmp.FieldByName('CTR_SEQBAI').AsInteger;
          ParamByName('NUMDOC').AsString  := edtDocum.Text;
          ParamByName('ESPDOC').AsString  := edtEspDoc.Text;
          ParamByName('CODEMP').AsString  := edtCodEmp.Text;
          ParamByName('CODCLI').AsString  := edtCodCli.Text;
          ExecSQL;

          QryTmp.Next;
        End;
      End
      Else
      Begin
        QryTmp.First;

        If (fFormataFloat(fltValDupTotPar, 2) <> 0) And
           (QryTmp.FindField('VALDUP') <> Nil) Then
        Begin
          fltCurValVTmp := (fltCurValorV * QryTmp.FieldByName('VALDUP').AsFloat) / fltValDupTotPar;
          fltCurValRTmp := (fltCurValorR * QryTmp.FieldByName('VALDUP').AsFloat) / fltValDupTotPar;
        End
        Else
        Begin
          fltCurValVTmp := fltCurValorV;
          fltCurValRTmp := fltCurValorR;
        end;

        SQL.Clear;
        SQL.Add(strSqlCtrCnf);
        ParamByName('TOTCOM').AsFloat  := fltCurValVTmp;
        ParamByName('TOCORE').AsFloat  := fltCurValRTmp;
        ParamByName('PARCEL').AsString := String(arrLetras[intContador]);
        ParamByName('NUMDOC').AsString := edtDocum.Text;
        ParamByName('ESPDOC').AsString := edtEspDoc.Text;
        ParamByName('CODEMP').AsString := edtCodEmp.Text;
        ParamByName('CODCLI').AsString := edtCodCli.Text;
        ExecSQL;
      End;

      // FOI COMENTADO, POIS HOJE O AGRUPAMENTO NÃO FUNCIONA CORRETAMENTE O CALCULO DE COMISSÃO
      // ASSIM QUE REVER ESSA QUESTÃO, SERÁ MEXIDO NESTA TELA O UPDATE TAMBÉM. FOI DEIXADO DO JEITO ORIGINAL
      {If fGetQtdSeqBai('DUPAGR',
                       String(arrLetras[intContador]),
                       True) > 1 Then
      Begin
        QryTmp.First;

        While Not QryTmp.Eof Do
        Begin
          If fltValDupTotPar <> 0 Then
          Begin
            fltCurValVTmp := (fltCurValorV * QryTmp.FieldByName('VALDUP').AsFloat) / fltValDupTotPar;
            fltCurValRTmp := (fltCurValorR * QryTmp.FieldByName('VALDUP').AsFloat) / fltValDupTotPar;
          End
          Else
          Begin
            fltCurValVTmp := fltCurValorV;
            fltCurValRTmp := fltCurValorR;
          end;

          strUPDTmp := strSqlDupAgr + ' AND CTR_SEQBAI = :SEQBAI ';

          SQL.Clear;
          SQL.Add(strUPDTmp);
          ParamByName('TOTCOM').AsFloat   := fltCurValVTmp;
          ParamByName('TOCORE').AsFloat   := fltCurValRTmp;
          ParamByName('PARCEL').AsString  := String(arrLetras[intContador]);
          ParamByName('SEQBAI').AsInteger := QryTmp.FieldByName('CTR_SEQBAI').AsInteger;
          ParamByName('NUMDOC').AsString  := edtDocum.Text;
          ParamByName('ESPDOC').AsString  := edtEspDoc.Text;
          ParamByName('CODEMP').AsString  := edtCodEmp.Text;
          ParamByName('CODCLI').AsString  := edtCodCli.Text;
          ExecSQL;

          QryTmp.Next;
        End;
      End
      Else
      Begin
        QryTmp.First;

        If (fFormataFloat(fltValDupTotPar, 2) <> 0) And
           (QryTmp.FindField('VALDUP') <> Nil) Then
        Begin
          fltCurValVTmp := (fltCurValorV * QryTmp.FieldByName('VALDUP').AsFloat) / fltValDupTotPar;
          fltCurValRTmp := (fltCurValorR * QryTmp.FieldByName('VALDUP').AsFloat) / fltValDupTotPar;
        End
        Else
        Begin
          fltCurValVTmp := fltCurValorV;
          fltCurValRTmp := fltCurValorR;
        end; }

      SQL.Clear;
      SQL.Add(strSqlDupAgr);
      ParamByName('TOTCOM').AsFloat  := fltCurValorV;
      ParamByName('TOCORE').AsFloat  := fltCurValorR;
      ParamByName('PARCEL').AsString := String(arrLetras[intContador]);
      ParamByName('NUMDOC').AsString := edtDocum.Text;
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ParamByName('CODCLI').AsString := edtCodCli.Text;
      ExecSQL;
      //End;

      fltTotComVen := fltTotComVen - fltCurValorV;
      fltTotComRep := fltTotComRep - fltCurValorR;

      Inc(intContador);
    End;
  End;

  FreeAndNil(QryUpdate);

  If Assigned(QryTmp) Then
    FreeAndNil(QryTmp);
end;

procedure TfrmFatAltComissao.pEscapePressed;
begin
  If ((ActiveControl) = edtCodEmp) Or ((ActiveControl) = edtEspDoc) Or ((ActiveControl) is TRadioButton) Then
    pLimpaTela
  Else
    inherited;
end;

procedure TfrmFatAltComissao.pHabilitaBusca(blnHabilita: Boolean);
begin
  edtDocum.Enabled  := blnHabilita;
  lblDoc.Enabled    := blnHabilita;
  edtEspDoc.Enabled := blnHabilita;
  lblEsp.Enabled    := blnHabilita;
  edtCodEmp.Enabled := blnHabilita;
  lblEmp.Enabled    := blnHabilita;
  edtDesEmp.Enabled := blnHabilita;
end;

end.
