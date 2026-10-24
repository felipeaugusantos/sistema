unit untEtiquetasItemCPF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, StdCtrls, ExtCtrls, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons,
  frxClass, frxDBSet, StrUtils, untTypesSistema, TypesRel, BitBtnLockedIncrem,
  MemDS, DBAccess, Provider, frxExportCSVTestabilidade, untFuncMacro,
  untFuncoesSimples, untConsultas, untCfgRel, Datasnap.DBClient;

type
  TfrmEtiquetasItemCPF = class(TfrmPaiOrdena)
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    Label2: TLabel;
    edtEspDoc: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    rdgTipEti: TRadioGroup;
    edtDesEmpresa: TEditFocus;
    btnImprimir: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    btnConfCnf: TBitBtnLocked;
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnMarDesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rdgTipEtiClick(Sender: TObject);
    procedure btnConfCnfClick(Sender: TObject);
    procedure edtNumDocEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    strNumDoc,
    strEspDoc,
    strCodEmp: String;
    blnVerDoc: Boolean;

    intColAtu: Integer;

    strNomImp: String;
    strNomPro: String;
    strDesPro: string;

    strArqTxt: String;

    // VARIAVEIS DA ETIQUETA MATRICIAL
    cpuCampos: TCamposUso;

    {*****************************************}
    {* MATRIZ QUE REPRESENTARÁ 1 LINHA DE    *}
    {* ETIQUETAS. Ex: EM UMA IMPRESSÃO DE 2  *}
    {* COLUNAS, A MATRIZ CONTERÁ 2 ETIQUETAS *}
    {**************************************MV*}
    arrLinhasEti: Array Of String;

    Function fSQLItens(strTabela: String): String;
    function fDocumentoExite: Boolean;
    Function fNomeImpressora: String;
    Function fImpEtiquetasMatricial(cdsEtique: TUniClientDataSet): Boolean;
    Function fImpEtiquetasLaser(cdsEtique: TUniClientDataSet; tipTipEti: TTipoEtiqueta): Boolean;
    Function fImprimeEtiquetasLaser(cdsEtique: TUniClientDataSet; tipTipEti: TTipoEtiqueta): Boolean;

    procedure pConfiguraImpressora;
    procedure pCriaCdsItensCPF(Var cdsEtique: TUniClientDataSet);
    procedure pPreview(cdsEtique: TUniClientDataSet);
    procedure pSalvaSequencial(intSeqEti: Integer);
    procedure pMontaCdsEtiqueta(Var cdsEtique: TUniClientDataSet; Var intSeqEti: Integer);

    procedure pImpRegistro(cdsEtique: TUniClientDataSet);
    procedure pImpArrLinhasEti;
    procedure pConfiguraCNFETI;

  public
    { Public declarations }
    blnPreview: Boolean;

    pShowPreview: TprcShowPreview;

  protected  
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmEtiquetasItemCPF: TfrmEtiquetasItemCPF;

implementation

uses untFuncoesGenerica, untCadConfRelatorios,
  untConstantes, untImprimeEtiquetas, untEditorFast, untModulo;

{$R *.dfm}

function TfrmEtiquetasItemCPF.fDocumentoExite: Boolean;
Begin
  blnVerDoc := True;

  With qryConsulta Do
  Begin
    SQL.Text := fGetSql(True);
    fSetParametros;
    Open;

    Result := Not IsEmpty;

    qryConsulta.Close;
  End;

End;

function TfrmEtiquetasItemCPF.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin

      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário informar o Número do Documento!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtEspDoc) Then
    Begin

      If Pos(edtEspDoc.Text, 'NF_PD_') = 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A espécie do documento deve ser NF ou PD!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário informar o código da Empresa!', ['&Ok']);
        Result := False;
      End Else
      Begin
        edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

        If fEmptyStr(edtCodEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
          Result := False;
        End Else
        Begin
          strNumDoc := edtNumDoc.Text;
          strEspDoc := edtEspDoc.Text;
          strCodEmp := edtCodEmpresa.Text;

          If fDocumentoExite Then
          Begin
            blnVerDoc := False;
            pLimpaPesquisa;
            fAbreConsulta;
            pMarcaTodos;

            If cdsConsulta.IsEmpty Then
            Begin
              fMensagem('ATENÇÃO!', 'Não há itens com obrigatoriedade de CPF nesse documento!', ['&Ok']);
              Result := False;
            End Else
            Begin
              blnMudarFoco := False;
              pSetFocus(rdgTipEti.Controls[0] As TWinControl);
            End;

          End Else
          Begin
            fMensagem('ATENÇÃO!', 'Nota de Entrada não encontrada!', ['&Ok']);
            Result := False;
          End;

        End;

      End;

    End;

    If Not Result Then
      pSetFocus(Sender);

  End;
end;

Function TfrmEtiquetasItemCPF.fSQLItens(strTabela: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  D.AUTOINCREM, ';
  strSQL := strSQL + '  DET_DESCRI AS DESITE, ';
  strSQL := strSQL + '  DET_REFERE AS REFERE, ';
  strSQL := strSQL + '  DET_CODITE AS CODITE, ';
  strSQL := strSQL + '  UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '  DET_QTDITE AS QTDITE, ';
  strSQL := strSQL + '  DET_UNITAR AS VALITE, ';

  If Pos('MOVDET', strTabela) > 0 Then
    strSQL := strSQL + '  DET_DTADOC AS DTAENT, '
  Else
    strSQL := strSQL + '  DET_DTAENT AS DTAENT, ';
 
  strSQL := strSQL + '  ITE_LOCFIS AS LOCFIS, ';
  strSQL := strSQL + '  MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '  ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '  ITE_CODBAR AS CODBAR, ';
  strSQL := strSQL + '  FOR_NOMFOR AS NOMFOR, ';

  strSQL := strSQL + '  (SELECT MOE_DOLCOM FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DOLCOM, ';
  strSQL := strSQL + '  (SELECT MOE_DOLVEN FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DOLVEN, ';
  strSQL := strSQL + '  (SELECT MOE_CODEMP FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS MOEEMP, ';
  strSQL := strSQL + '  (SELECT MOE_DTAMOE FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DTAMOE  ';

  strSQL := strSQL + 'FROM        ';

  strSQL := strSQL +  strTabela + ' D ';

  strSQL := strSQL + ' INNER JOIN CADITE I ON ';
  strSQL := strSQL + '   DET_CODITE = I.ITE_CODITE ';

  strSQL := strSQL + ' LEFT JOIN CADFOR ON ';
  strSQL := strSQL + '   FOR_CODFOR = DET_CODFOR ';
  
  strSQL := strSQL + ' INNER JOIN ITEGER T ON ';
  strSQL := strSQL + '   DET_CODITE = T.ITE_CODITE AND ';
  strSQL := strSQL + '   DET_CODEMP = T.ITE_CODEMP     ';

  strSQL := strSQL + ' LEFT JOIN CADMAR M ON ';
  strSQL := strSQL + '   MAR_CODMAR = I.ITE_CODMAR  ';

  strSQL := strSQL + ' LEFT JOIN CADUNI U ON ';
  strSQL := strSQL + '    UNI_CODUNI = DET_UNIDAD ';

  strSQL := strSQL + 'WHERE       ';

  strSQL := strSQL + '  DET_TIP_FC = "F"     AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  DET_ESPDOC = :ESPDOC     ';

  If Not blnVerDoc Then
    strSQL := strSQL + '  AND ITE_OBRCPF = "S"     ';

  Result := strSQL;
End;

function TfrmEtiquetasItemCPF.fSetParametros: Boolean;
Begin
  With qryConsulta Do
  Begin
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
  End;
  Result := True;
End;

procedure TfrmEtiquetasItemCPF.btnConfCnfClick(Sender: TObject);
  Var
    strSenha: String;
begin
  inherited;

  If ffrmSenha(strSenha) And (strSenha = SEN_CNF) Then
    pConfiguraCNFETI;

end;

procedure TfrmEtiquetasItemCPF.btnConfigurarClick(Sender: TObject);
begin
  inherited;

  pConfiguraImpressora;
end;

procedure TfrmEtiquetasItemCPF.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  pDesmarcaTodos;
end;

procedure TfrmEtiquetasItemCPF.btnImprimirClick(Sender: TObject);
  Var
    cdsEtique: TUniClientDataSet;
    intSeqEti: Integer;
    blnImpEti: Boolean;
begin
  inherited;

  If cdsConsulta.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar um Documento!', ['&Ok']);

    If (Self.Visible) Then
      pSetFocus(edtNumDoc);

    Exit;
  End;

  If stlListSelecao.Count = 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar pelo menos um produto para ' +
                          'imprimir a etiqueta!', ['&Ok']);
    Exit;                          
  End;

  pMontaCdsEtiqueta(cdsEtique, intSeqEti);
  
  cdsEtique.IndexFieldNames := 'SEQETI';
  Case rdgTipEti.ItemIndex Of 
    0:   blnImpEti := fImpEtiquetasLaser(cdsEtique, tpeItensCPFArgox);
    1:   blnImpEti := fImpEtiquetasLaser(cdsEtique, tpeItensCPF);
    Else blnImpEti := fImpEtiquetasMatricial(cdsEtique);
  End;

 If blnImpEti And (Not blnPreview) Then
    pSalvaSequencial(intSeqEti);

  cdsEtique.EmptyDataSet;
  FreeAndNil(cdsEtique);

  cdsConsulta.EmptyDataSet;
  cdsConsulta.Close;

  edtEspDoc.Clear;
  edtNumDoc.Clear;
  pSetFocus(edtNumDoc);
end;

procedure TfrmEtiquetasItemCPF.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  pMarcaTodos;
end;

procedure TfrmEtiquetasItemCPF.btnMarDesClick(Sender: TObject);
begin
  inherited;

  pAddListaQuery;
end;

procedure TfrmEtiquetasItemCPF.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, nil, Key, arrSel) Then
  Begin
    fValidaCampos(edtCodEmpresa, True);
  End;
  
end;

procedure TfrmEtiquetasItemCPF.edtNumDocEnter(Sender: TObject);
begin
  inherited;
  pLimpaPesquisa;
end;

function TfrmEtiquetasItemCPF.fGetSql(blnLike: Boolean): String;
Begin

  Result := fSQLItens('MOVDET')  + fFiltraSQL(blnLike) + ' UNION ALL ' +
            fSQLItens('NOTDET')  + fFiltraSQL(blnLike) ;

  If blnVerDoc Then
  Begin

    Result := Result + ' LIMIT 1 ';

  End;

End;

procedure TfrmEtiquetasItemCPF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(cpuCampos);
end;

procedure TfrmEtiquetasItemCPF.FormCreate(Sender: TObject);
begin
  inherited;

  blnPreview := False;
  cpuCampos := TCamposUso.Create;

  edtNumDoc.MaxLength := fTamNumdoc();
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
end;

procedure TfrmEtiquetasItemCPF.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin


  Case Key Of
    VK_F4    : btnConfigurar.Click;
    VK_F6    : btnMarcaTodos.Click;
    VK_F7    : btnDesmarcaTodos.Click;
    VK_F8    : btnConfCnf.Click;
    VK_F10   : btnImprimir.Click;
    VK_ESCAPE: If Not cdsConsulta.IsEmpty Then
               Begin
                 cdsConsulta.EmptyDataSet;
                 cdsConsulta.Close;
                 edtEspDoc.Clear;
                 edtNumDoc.Clear;
                 inherited;
                 pSetFocus(edtNumDoc);
               End
               Else inherited;

     Else inherited;

    End;
  End;

procedure TfrmEtiquetasItemCPF.FormShow(Sender: TObject);
begin
  inherited;

  blnSelecionaComEnter   := False;
  lflLastField.intIndCol := 2;
  lflLastField.strNomCam := dbgConsulta.Columns[2].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[2].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  blnSelecionaComEspaco := True;
  blnSempreRelerBanco   := False;

  pSetFocus(edtNumDoc);
end;

procedure TfrmEtiquetasItemCPF.pConfiguraImpressora;
begin
  inherited;

  Try
    pCriarFormularios(TfrmCadConfRelatorios, frmCadConfRelatorios);
    frmCadConfRelatorios.strNomeForm   := Self.Name;
    frmCadConfRelatorios.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmImpEtiDespacho.btnConfigurarClick]');
    End;
  End;

  pFreeAndNil(frmCadConfRelatorios);
end;

procedure TfrmEtiquetasItemCPF.pCriaCdsItensCPF(Var cdsEtique: TUniClientDataSet);
Begin

  cdsEtique := TUniClientDataSet.Create(Self);
  With cdsEtique, FieldDefs do
  Begin
    With AddFieldDef Do Begin Name := 'QTDETI'; DataType := ftInteger; Required := False; End;
    With AddFieldDef Do Begin Name := 'DESITE'; DataType := ftString; Size := 080; Required := False; End;
    With AddFieldDef Do Begin Name := 'CODITE'; DataType := ftString; Size := fTamCodIte; Required := False; End;
    With AddFieldDef Do Begin Name := 'CODFAB'; DataType := ftString; Size := 035; Required := False; End;
    With AddFieldDef Do Begin Name := 'CODBAR'; DataType := ftString; Size := 030; Required := False; End;
    With AddFieldDef Do Begin Name := 'DESMAR'; DataType := ftString; Size := 050; Required := False; End;
    With AddFieldDef Do Begin Name := 'REFERE'; DataType := ftString; Size := 060; Required := False; End;
    With AddFieldDef Do Begin Name := 'SIGUNI'; DataType := ftString; Size := 006; Required := False; End;
    With AddFieldDef Do Begin Name := 'QTDITE'; DataType := ftFloat;               Required := False; End;
    With AddFieldDef Do Begin Name := 'SEQETI'; DataType := ftInteger;             Required := False; End;
    With AddFieldDef Do Begin Name := 'NUMETI'; DataType := ftInteger;             Required := False; End;
    With AddFieldDef Do Begin Name := 'NOMFOR'; DataType := ftString; Size := 050; Required := False; End;

    With AddFieldDef Do Begin Name := 'NUMDOC'; DataType := ftString; Size := 012; Required := False; End;
    With AddFieldDef Do Begin Name := 'ESPDOC'; DataType := ftString; Size := 002; Required := False; End;
    With AddFieldDef Do Begin Name := 'CODEMP'; DataType := ftString; Size := 003; Required := False; End;

    With AddFieldDef Do Begin Name := 'NOMEMP'; DataType := ftString; Size := 060; Required := False; End;
    With AddFieldDef Do Begin Name := 'C_G_C_'; DataType := ftString; Size := 030; Required := False; End;
    With AddFieldDef Do Begin Name := 'ENDERE'; DataType := ftString; Size := 040; Required := False; End;
    With AddFieldDef Do Begin Name := 'ENDCMP'; DataType := ftString; Size := 030; Required := False; End;
    With AddFieldDef Do Begin Name := 'ENDNUM'; DataType := ftString; Size := 030; Required := False; End;
    With AddFieldDef Do Begin Name := 'BAIRRO'; DataType := ftString; Size := 030; Required := False; End;
    With AddFieldDef Do Begin Name := 'CIDEMP'; DataType := ftString; Size := 100; Required := False; End;
    With AddFieldDef Do Begin Name := 'ESTEMP'; DataType := ftString; Size := 002; Required := False; End;
    With AddFieldDef Do Begin Name := 'FONEMP'; DataType := ftString; Size := 025; Required := False; End;
    With AddFieldDef Do Begin Name := 'DTAENT'; DataType := ftDate;                Required := False; End;

    With AddFieldDef Do Begin Name := 'DOLCOM'; DataType := ftString; Size := 020; Required := False; End;
    With AddFieldDef Do Begin Name := 'DOLVEN'; DataType := ftString; Size := 020; Required := False; End;
    With AddFieldDef Do Begin Name := 'MOEEMP'; DataType := ftString; Size := 060; Required := False; End;
    With AddFieldDef Do Begin Name := 'DTAMOE'; DataType := ftDate;                Required := False; End;

    CreateDataSet;

    Open;
  End;
End;

Function TfrmEtiquetasItemCPF.fNomeImpressora: String;
  Var
    qryCfgRel: TUniQuery;
Begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, Self.Name);
  Result := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
  strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;
  FreeAndNil(qryCfgRel);
End;

Function TfrmEtiquetasItemCPF.fImprimeEtiquetasLaser(cdsEtique: TUniClientDataSet; tipTipEti: TTipoEtiqueta): Boolean;
  Var
    strNomFil: String;
    prmDllEtq: TParamDllEtiquetas;
begin
  inherited;

  Try
    strNomFil := fNomeImpressora;

    prmDllEtq := TParamDllEtiquetas.Create;

    prmDllEtq.tpeTipEtq := tipTipEti;
    prmDllEtq.dtsImpres := cdsEtique;
    prmDllEtq.strNomFil := strNomFil;
    prmDllEtq.strNomFrm := Self.Name;
    prmDllEtq.intNumCop := 1;
    prmDllEtq.blnImpEti := True;

    Result := fImprimeEtiquetaGeralAux(prmDllEtq, False);

    FreeAndNil(prmDllEtq);

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmEtiquetasItemCPF.fImprimeEtiquetasLaser]');
    End;

  End;

End;

procedure TfrmEtiquetasItemCPF.pSalvaSequencial(intSeqEti: Integer);
  Var
    qryCfgSis: TUniQuery;
Begin
  qryCfgSis := fCriaQuery(Self);
  With qryCfgSis, SQL Do
  Begin
    Add('UPDATE CFGSIS SET SIS_VALCFG = :VALCFG ');
    Add('WHERE');
    Add('  SIS_CODCFG = "CFG_ETICPF" AND ');
    Add('  SIS_CODEMP = :CODEMP     ');

    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('VALCFG').AsString := IntToStr(intSeqEti);

    ExecSQL;
  End;

  FreeAndNil(qryCfgSis);
End;

procedure TfrmEtiquetasItemCPF.rdgTipEtiClick(Sender: TObject);
begin
  inherited;

  btnConfCnf.Visible := rdgTipEti.ItemIndex = 2;

end;

procedure TfrmEtiquetasItemCPF.pMontaCdsEtiqueta(Var cdsEtique: TUniClientDataSet;
                      Var intSeqEti: Integer);
  Var
    qryCadEmp: TUniQuery;
    intQtdEti,
    intContador: Integer;
    strIdxSav: String;

    Procedure pLeEmpresa;
    Begin
      With qryCadEmp, SQL Do
      Begin
        Add('SELECT * FROM CADEMP');
        Add('INNER JOIN CADCID ON CID_CODCID = EMP_CODCID');
        Add('WHERE EMP_CODEMP = :CODEMP');
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;
      End;
    End;

    Procedure pIncluiEtiqueta(intPosEti: Integer);
    Begin

      With cdsEtique Do
      Begin
        Insert;

        FieldByName('NUMETI').AsInteger := intPosEti;
        FieldByName('SEQETI').AsInteger := intSeqEti;

        FieldByName('NUMDOC').AsString  := strNumDoc;
        FieldByName('ESPDOC').AsString  := strEspDoc;
        FieldByName('CODEMP').AsString  := strCodEmp;

        FieldByName('NOMEMP').AsString  := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
        FieldByName('C_G_C_').AsString  := fFormataCpfCgc(qryCadEmp.FieldByName('EMP_C_G_C_').AsString, fSetaPais);
        FieldByName('ENDERE').AsString  := qryCadEmp.FieldByName('EMP_ENDERE').AsString;
        FieldByName('ENDCMP').AsString  := qryCadEmp.FieldByName('EMP_ENDCMP').AsString;
        FieldByName('ENDNUM').AsString  := qryCadEmp.FieldByName('EMP_ENDNUM').AsString;
        FieldByName('BAIRRO').AsString  := qryCadEmp.FieldByName('EMP_BAIRRO').AsString;
        FieldByName('FONEMP').AsString  := qryCadEmp.FieldByName('EMP_FONE01').AsString;
        FieldByName('CIDEMP').AsString  := qryCadEmp.FieldByName('CID_NOMCID').AsString;
        FieldByName('ESTEMP').AsString  := qryCadEmp.FieldByName('CID_ESTADO').AsString;

        FieldByName('QTDETI').AsInteger := Trunc(cdsConsulta.FieldByName('QTDITE').AsFloat);
        FieldByName('QTDITE').AsFloat   := cdsConsulta.FieldByName('QTDITE').AsFloat;
        FieldByName('DESITE').AsString  := cdsConsulta.FieldByName('DESITE').AsString;
        FieldByName('CODITE').AsString  := cdsConsulta.FieldByName('CODITE').AsString;
        FieldByName('CODFAB').AsString  := cdsConsulta.FieldByName('CODFAB').AsString;
        FieldByName('CODBAR').AsString  := cdsConsulta.FieldByName('CODBAR').AsString;
        FieldByName('DESMAR').AsString  := cdsConsulta.FieldByName('DESMAR').AsString;
        FieldByName('REFERE').AsString  := cdsConsulta.FieldByName('REFERE').AsString;
        FieldByName('SIGUNI').AsString  := cdsConsulta.FieldByName('SIGUNI').AsString;
        FieldByName('NOMFOR').AsString  := cdsConsulta.FieldByName('NOMFOR').AsString;
        FieldByName('DTAENT').AsDateTime:= cdsConsulta.FieldByName('DTAENT').AsDateTime;

        FieldByName('DOLCOM').AsString  := cdsConsulta.FieldByName('DOLCOM').AsString;
        FieldByName('DOLVEN').AsString  := cdsConsulta.FieldByName('DOLVEN').AsString;
        FieldByName('MOEEMP').AsString  := cdsConsulta.FieldByName('MOEEMP').AsString;
        FieldByName('DTAMOE').AsDateTime:= cdsConsulta.FieldByName('DTAMOE').AsDateTime;

        Post;
      End;

      inc(intSeqEti);
    End;

Begin

  pCriaCdsItensCPF(cdsEtique);
  qryCadEmp := fCriaQuery(Self);
  pLeEmpresa;

  intSeqEti := fCfgSis('ETICPF');

  With cdsConsulta Do
  Begin
    DisableControls;

    strIdxSav       := IndexFieldNames;
    IndexFieldNames := 'DESITE';

    First;

    While Not Eof Do
    Begin
      If fInLista Then
      Begin
        intQtdEti := Trunc(FieldByName('QTDITE').AsFloat);

        For intContador := 1 To intQtdEti Do
          pIncluiEtiqueta(intContador);
      End;

      Next;
    End;

    cdsEtique.IndexFieldNames := 'DESITE';
    IndexFieldNames := strIdxSav;

    cdsEtique.First;

    EnableControls;
  End;

  FreeAndNil(qryCadEmp);
End;

Function TfrmEtiquetasItemCPF.fImpEtiquetasLaser(cdsEtique: TUniClientDataSet; tipTipEti: TTipoEtiqueta): Boolean;
begin
  Result := False;

  If blnPreview Then
    pPreview(cdsEtique)
  Else
    Result := fImprimeEtiquetasLaser(cdsEtique, tipTipEti);

End;

procedure TfrmEtiquetasItemCPF.pPreview(cdsEtique: TUniClientDataSet);
Begin
  pShowPreview(cdsEtique);
End;

Function TfrmEtiquetasItemCPF.fImpEtiquetasMatricial(cdsEtique: TUniClientDataSet): Boolean;
begin
  Try
    intColAtu := 1;

    Result := False;
    strNomImp := fNomeImpressora;

    If Not fVerificaImpressora(strNomImp) Then
    Begin
      fMensagem('','Impressora configurada incorretamente!',['&OK']);
      Exit;
    End;

    cpuCampos.AdicionaCampos(cdsEtique, 'ETQ');

    With cdsEtique Do
    Begin
      First;
      While Not Eof Do
      Begin

        Application.ProcessMessages;
        pImpRegistro(cdsEtique);
        Application.ProcessMessages;
        Next;
      End;
      {**********************************************************************************}
      {* É NECESSARIO CHAMAR ESSA PROCEDURE NESSE PONTO PARA QUE SAIA A ÚLTIMA ETIQUETA *}
      {*******************************************************************************MV*}
      pImpArrLinhasEti;
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmEtiquetasItemCPF.fImpEtiquetasMatricial]');
    End;
  End;

End;

procedure TfrmEtiquetasItemCPF.pImpRegistro(cdsEtique: TUniClientDataSet);
  Var
    intQtdCol: Integer;
    intQtdColOri: Integer;
    intContador: Integer;
    intLinhaAtu: Integer;
    intLinha : Integer;

    intTamLinAnt: Integer;

    intNumCol: Integer;
    intQtdEti: Integer;
    intLinhaEti: Integer;
    strNumCol: String;
    strLinha : String;
    strSQL: String;
    qryCnfGen: TUniQuery;
begin

  intLinhaAtu := 1;
  intLinha    := 0;

  intLinhaEti := 0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CNFETI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CNF_TIPETI = :TIPETI AND';
  strSQL := strSQL + '  CNF_CODEMP = :CODEMP    ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  CNF_IDENTI, CNF_LINIMP, CNF_COL001 ';

  qryCnfGen := fCriaQuery(Self);
  With qryCnfGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('TIPETI').AsString := 'IOC';
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    intQtdEti := 1;

    While (intQtdEti > 0) Do
    Begin
      First;

      intQtdColOri := FieldByName('CNF_QTDCOL').AsInteger;
      intQtdCol := intQtdColOri;

      If (intQtdCol > intQtdEti) And (intColAtu <= 1) Then
        intQtdCol := intQtdEti;

      {*****************************************}
      {* LÊ E INTERPRETA O ID = '00'           *}
      {**************************************MV*}
      If intColAtu <= 1 Then
      Begin
        pI_LinhasEti(Self, cpuCampos, strLinha, intLinhaAtu, intLinha, strNomImp, strNomPro, strDesPro, 0, qryCnfGen);
        {*****************************************}
        {* ESCREVE COM WRITE, MAS NÃO IMPRIME    *}
        {**************************************MV*}
        pEscreveLinha(strArqTxt, AnsiString(strLinha), not VS_SpoolImpressaoCitel, strNomImp, strNomPro, strDesPro);
      End;
      Next;

      If (Length(arrLinhasEti) = 0) Then
      Begin
        SetLength(arrLinhasEti, RecordCount-1);
      End;

      While (Not Eof) Do
      Begin

       // If cpuCampos <> Nil Then
       //   il(cpuCampos);

        cpuCampos.LimparCampos;
        cpuCampos.AdicionaCampos(cdsEtique, 'ETQ');

        strLinha := '';
        For intContador := intColAtu To intQtdCol Do
        Begin

          strNumCol := fStrZero(IntToStr(intContador), 03);
          intNumCol := FieldByName('CNF_COL' + strNumCol).AsInteger;

          intTamLinAnt := Length(arrLinhasEti[intLinhaEti]);
          pI_LinhasEti(Self, cpuCampos, strLinha, intLinhaAtu, intLinha, strNomImp, strNomPro, strDesPro, (intNumCol - intTamLinAnt), qryCnfGen);

          arrLinhasEti[intLinhaEti] := arrLinhasEti[intLinhaEti] + strLinha;
          strLinha := ''; //Se desistir da matriz, tirar essa linha

        End;
        Inc(intLinhaEti);

        {*****************************************}
        {* NEXT NO ARQUIVO DE CNF                *}
        {**************************************MV*}
        Next;

      End;

      intLinhaEti := 0;
      Dec(intQtdEti, (intQtdColOri+1) - intColAtu);

      Inc(intColAtu, intQtdCol);
      If intColAtu >= intQtdColOri+1 Then
      Begin
        pImpArrLinhasEti;
        intColAtu := 1;
      End;

    End;

  End;

  FreeAndNil(qryCnfGen);
end;

procedure TfrmEtiquetasItemCPF.pImpArrLinhasEti;
  Var
    intContador1: Integer;
    intLength1: Integer;
    blnUltimoReg: Boolean;
    strLinhaAtu: String;
    blnImprime: Boolean;
begin
  strLinhaAtu := '';
  blnUltimoReg := False;
  intLength1 := Length(arrLinhasEti);
  blnImprime := False;

  For intContador1 := 0 To intLength1-1 Do
  Begin
    If arrLinhasEti[intContador1] <> '' Then
    Begin
      blnImprime := True;
      Break;
    End;
  End;

  If Not blnImprime Then
    Exit;

  For intContador1 := 0 To intLength1-1 Do
  Begin
    If (intContador1 = intLength1-1) Then
      blnUltimoReg := True;

    pEscreveLinha(strArqTxt, AnsiString(arrLinhasEti[intContador1]), blnUltimoReg, strNomImp, strNomPro, strDesPro);
    strLinhaAtu := '';
  End;

  SetLength(arrLinhasEti, 0);
end;

procedure TfrmEtiquetasItemCPF.pConfiguraCNFETI;
Begin
  pCnfEtiqueta(etiItensCPF);
End;

end.
