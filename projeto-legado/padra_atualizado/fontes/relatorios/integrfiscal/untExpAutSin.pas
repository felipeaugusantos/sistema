unit untExpAutSin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, MaskEditFocus, Menus, Uni,
  Buttons, ExtCtrls, rxToolEdit, DirectoryEditFocus, StrUtils, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, 
  untFrameDirectoryEditFocus;

type
  TfrmExpAutSin = class(TfrmPai)
    pnlFundo: TPanel;
    Label5: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    lblPathExp: TLabel;
    fraPathExpAutSin: TfraDirectoryEditFocus;
    chkNF: TCheckBox;
    chkIF: TCheckBox;
    btnConfirma: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);

    procedure btnConfirmaClick(Sender: TObject);

    function fRetCepCliFor(strCliFor, strTip_FC, strCodEmp, strNumDoc, strEspDoc:String):String;

  private
    { Private declarations }
    blnEnviaCliCon: Boolean;
    function fGetClienteConsumidor: String;

    procedure pGeraArqCadFisc;
    procedure pGeraArqDelCadFisc;
    procedure pGeraArqCadCli;
    procedure pGeraArqCadFor;
    procedure pGeraArqCadIte;
    procedure pGeraArqMovGer;
    procedure pGeraArqDelMovGer;
    procedure pGeraArqMovDet(strTipMov: String);
    procedure pGeraArqDelMovDet(strTipMov: String);
    procedure pGeraArqNotGer;
    procedure pGeraArqDelNotGer;
    procedure pGeraArqNotDet;
    procedure pGeraArqDelNotDet;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;

var
  frmExpAutSin: TfrmExpAutSin;

implementation

uses untFuncoes, untFuncoesSimples, untConsultas,
   DB, untPesqAux, untEntFreCon,
  untFuncoesConsulta;

{$R *.dfm}

procedure TfrmExpAutSin.FormShow(Sender: TObject);
begin
  inherited;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyy', VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  chkNF.Checked := True;
  chkIF.Checked := True;
end;

procedure TfrmExpAutSin.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmExpAutSin.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODOS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtCodEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresa.Clear;
    pSetFocus(edtCodEmpresa);
  End;

end;

function TfrmExpAutSin.fValidaCampos(Sender: TWinControl;
           blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave )) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO','A Data Inicial deve ser preenchida!',['&O K']);
        Result := False;
      End;
    End

    Else
    If (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO','A Data Final deve ser preenchida!',['&O K']);
        Result := False;
      End
      Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO','A Data Inicial deve ser menor que a Data Final!',['&O K']);
        Result := False;
      End;
    End

    Else
    If (Sender = edtCodEmpresa) Then
    Begin

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        fMensagem('ATENÇÃO','O código da empresa deve ser preenchido!',['&O K']);
        Result := False;
      End;

    End

    Else
    If (Sender  = fraPathExpAutSin) Then
    Begin

      If fEmptyStr(fraPathExpAutSin.edtDirectory.text) Then
      Begin
        fMensagem('ATENÇÃO','O Path para geração do arquivo deve ser preenchido!',['&O K']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmExpAutSin.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  btnConfirma.Enabled := False;
  pnlInfo.Caption := 'Gerando Arquivos...';
  pnlInfo.Repaint;

  Application.ProcessMessages;


  //*****************************************************//
  // FUNCOES QUE EFETIVAMENTE GERAM O TXT's              //
  //**************************************************ED*//
  pGeraArqCadFisc;
  pGeraArqCadCli;
  pGeraArqCadFor;
  pGeraArqCadIte;
  pGeraArqMovGer;
  pGeraArqMovDet('S'); // GERA O FATDET.TXT - MOVIMENTACAO DE SAIDA CLIENTE/FORNECEDOR
  pGeraArqMovDet('N'); // GERA O CADMOV.TXT - MOVIMENTACAO DE ENTRADA
  pGeraArqNotGer;
  pGeraArqNotDet;

  {******************************************}
  {* GERA ARQUIVOS DE DOCUMENTOS CANCELADOS *}
  {***************************************AF*}
  If fTabelaExiste('DEL_CADFIS') Then pGeraArqDelCadFisc;
  If fTabelaExiste('DEL_MOVGER') Then pGeraArqDelMovGer;
  If fTabelaExiste('DEL_MOVDET') Then pGeraArqDelMovDet('S');
  If fTabelaExiste('DEL_MOVDET') Then pGeraArqDelMovDet('N');
  If fTabelaExiste('DEL_NOTGER') Then pGeraArqDelNotGer;
  If fTabelaExiste('DEL_NOTDET') Then pGeraArqDelNotDet;

  fMensagem('','O arquivo de exportação para AutSin foi gerado com sucesso!',['&O K']);

  pnlInfo.Caption := '';
  btnConfirma.Enabled := True;
  Close;

  btnConfirma.Enabled := True;

end;



procedure TfrmExpAutSin.pGeraArqCadFisc;
  Var
    strSQL      : String;
    strTransacao: String;
    strNomArq   : String;
    strDtaDoc   : String;
    strDtaEnt   : String;
    strNotCom   : String;
    strNotEsp   : String;
    StrModDoc   : String;
    strC_e_p_   : String;
    strDoc      : String;
    strEsp      : String;
    strEmp      : String;
    strSer      : String;
    strFor      : String;
    fltValSer   : Double;
    fltValIss   : Double;
    fltPerIss   : Double;
    lstTexto    : TStringList;
    qryGenFis : TUniQuery;

begin
  qryGenFis := fCriaQuery(Self);

  strNomArq := 'CADFISC.TXT';

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  CADFIS.*, ';
  strSQL := strSQL + '  IFNULL(IFNULL(M.GER_CONPAG, N.GER_CONPAG), "01000") AS FIS_CONPAG, ';
  strSQL := strSQL + '  IFNULL(IFNULL(M.GER_TIPFRE, N.GER_TIPFRE), "0")     AS FIS_TIPFRE, ';
  strSQL := strSQL + '  IFNULL(IFNULL(M.GER_TOTFRE, N.GER_TOTFRE), "0,00")  AS FIS_TOTFRE, ';
  strSQL := strSQL + '  IFNULL(IFNULL(M.GER_ORIDOC, N.GER_ORIDOC), "")      AS ORIDOC ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIS ';
  strSQL := strSQL + '  LEFT JOIN MOVGER M ON M.GER_NUMDOC = FIS_NUMDOC AND ';
  strSQL := strSQL + '                        M.GER_ESPDOC = FIS_ESPDOC AND ';
  strSQL := strSQL + '                        M.GER_CODEMP = FIS_CODEMP AND ';
  strSQL := strSQL + '                        IFNULL(M.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") AND ';
  strSQL := strSQL + '                        M.GER_TIP_FC = FIS_TIP_FC AND ';
  strSQL := strSQL + '                        IF(M.GER_TIP_FC = "C", M.GER_CODCLI, M.GER_CODFOR) = FIS_FORCLI ';
  strSQL := strSQL + '  LEFT JOIN NOTGER N ON N.GER_NUMDOC = FIS_NUMDOC AND ';
  strSQL := strSQL + '                        N.GER_ESPDOC = FIS_ESPDOC AND ';
  strSQL := strSQL + '                        N.GER_CODEMP = FIS_CODEMP AND ';
  strSQL := strSQL + '                        IFNULL(N.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") AND ';
  strSQL := strSQL + '                        N.GER_TIP_FC = FIS_TIP_FC AND ';
  strSQL := strSQL + '                        IF(N.GER_TIP_FC = "C", N.GER_CODCLI, N.GER_CODFOR) = FIS_FORCLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';

  If Not chkNF.Checked Then
  Begin
    strSQL := strSQL + '  AND FIS_ESPDOC <> "NF" ';
    strSQL := strSQL + '  AND FIS_ESPDOC <> "EL" ';
    strSQL := strSQL + '  AND FIS_ESPDOC <> "D1" ';    
  End;

  If Not chkIF.Checked Then
  Begin
    strSQL := strSQL + '  AND FIS_ESPDOC <> "IF" ';
    strSQL := strSQL + '  AND FIS_ESPDOC <> "IV" ';
  End;

  With qryGenFis Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
    Open;
  End;

  If Not qryGenFis.IsEmpty Then
  Begin

    lstTexto := TStringList.Create;

    {**************************}
    {* TRANSAÇÃO DO ARQUIVO   *}
    {***********************LB*}
    With qryGenFis Do
    Begin
      strTransacao := '';

      blnEnviaCliCon := False;
      While Not Eof Do
      Begin
        Application.ProcessMessages;

        {*****************************************}
        {* VERIFICA SE É NECESSÁRIO ENVIAR O     *}
        {* CLIENTE CONSUMIDOR.                   *}
        {**************************************MV*}
        If (SameText(FieldByName('FIS_TIP_FC').AsString, 'F')) And (SameText(FieldByName('ORIDOC').AsString, 'V')) Then
        Begin
          blnEnviaCliCon := True;
        End;

        {**************************************}
        {* CALCULA VALORES DO SERVIÇO         *}
        {***********************************AF*}
        fltValSer := 0;
        fltPerIss := 0;
        fltValIss := FieldByName('FIS_VALIS1').AsFloat + FieldByName('FIS_VALIS2').AsFloat +
                     FieldByName('FIS_VALIS3').AsFloat + FieldByName('FIS_VALIS4').AsFloat +
                     FieldByName('FIS_VALIS5').AsFloat;

        If RightStr(FieldByName('FIS_CLFSC1').AsString,3) = '933' Then
          fltValSer := FieldByName('FIS_VLCON1').AsFloat

        Else If RightStr(FieldByName('FIS_CLFSC2').AsString,3) = '933' Then
          fltValSer := FieldByName('FIS_VLCON2').AsFloat

        Else If RightStr(FieldByName('FIS_CLFSC3').AsString,3) = '933' Then
          fltValSer := FieldByName('FIS_VLCON3').AsFloat

        Else If RightStr(FieldByName('FIS_CLFSC4').AsString,3) = '933' Then
          fltValSer := FieldByName('FIS_VLCON4').AsFloat

        Else If RightStr(FieldByName('FIS_CLFSC5').AsString,3) = '933' Then
          fltValSer := FieldByName('FIS_VLCON5').AsFloat;

        If fltValSer > 0 Then
        Begin
          fltPerIss := fFormataFloat( (fltValIss/fltValSer) * 100 ,1);
        End;

        {**************************************}
        {* CARREGA VARIAVEIS                  *}
        {***********************************LB*}
        If fEmptyStr(FieldByName('FIS_DTAENT').AsString) Then
          strDtaEnt := ''
        Else
          strDtaEnt := FormatDateTime('yyyy',FieldByName('FIS_DTAENT').AsDateTime) +
                       FormatDateTime('mm',FieldByName('FIS_DTAENT').AsDateTime)   +
                       FormatDateTime('dd',FieldByName('FIS_DTAENT').AsDateTime);

        If fEmptyStr(FieldByName('FIS_DTADOC').AsString) Then
          strDtaDoc := ''
        Else
          strDtaDoc := FormatDateTime('yyyy',FieldByName('FIS_DTADOC').AsDateTime) +
                       FormatDateTime('mm',FieldByName('FIS_DTADOC').AsDateTime)   +
                       FormatDateTime('dd',FieldByName('FIS_DTADOC').AsDateTime);

        strNotCom := 'F';
        If FieldByName('FIS_NFCOMP').AsString = 'S' Then
          strNotCom := 'T';

        strNotEsp := 'F';
        If FieldByName('FIS_NOTESP').AsString = 'S' Then
          strNotEsp := 'T';

        If FieldByName('FIS_ESPDOC').AsString = 'IF' Then
          StrModDoc := '2D'
        Else
        Begin
          If fEmptyStr(FieldByName('FIS_ACESSO').AsString) Then
            StrModDoc := '01'
          Else
            StrModDoc := '55';
        End;

        strC_e_p_ := fRetCepCliFor(FieldByName('FIS_FORCLI').AsString,
                                   FieldByName('FIS_TIP_FC').AsString,
                                   FieldByName('FIS_CODEMP').AsString,
                                   FieldByName('FIS_NUMDOC').AsString,
                                   FieldByName('FIS_ESPDOC').AsString);

        strTransacao := fPadR      (strDtaEnt                                   , 08)     + //DATA ENTRADA
                        fPadR      (FieldByName('FIS_ESPDOC').AsString          , 02)     + //ESPECIE
                        fPadR      (FieldByName('FIS_SERIE_').AsString          , 03)     + //SERIE
                        fPadR      (FieldByName('FIS_NUMDOC').AsString          , 06)     + //NUMERO DOCUMENTO
                        fPadR      (FieldByName('FIS_NUMDO2').AsString          , 06)     + //NUMERO DOCUMENTO2
                        fPadR      (FieldByName('FIS_ENTSAI').AsString          , 01)     + //ENTRADA OU SAIDA
                        fPadR      (StrDtaDoc                                   , 08)     + //DATA DOCUMENTO

                        IIF((SameText(FieldByName('FIS_TIP_FC').AsString, 'F')) And (SameText(FieldByName('ORIDOC').AsString, 'V')),
                          fPadR(fGetClienteConsumidor, 08),
                          fPadR(FieldByName('FIS_FORCLI').AsString              , 08))    + //FORNECEDOR OU CLIENTE

                        fPadR      (FieldByName('FIS_HISTOR').AsString          , 17)     + //HISTORICO
                        fPadR      (strC_e_p_                                   , 08)     + //CEP
                        fPadR      (FieldByName('FIS_ESTADO').AsString          , 02)     + //estado
                        fPadR      (FieldByName('FIS_CODEMP').AsString          , 03)     + //numloj


                        IIF((SameText(FieldByName('FIS_TIP_FC').AsString, 'F'))
                          And (SameText(FieldByName('ORIDOC').AsString, 'V')),
                          'C',
                          fPadR(FieldByName('FIS_TIP_FC').AsString              , 01))    + //tip_fc

                        fPadR      (strNotCom                                   , 01)     + //nfcomp
                        fPadR      (strNotEsp                                   , 01);      //notesp

                        strDoc := FieldByName('FIS_NUMDOC').AsString;
                        strEsp := FieldByName('FIS_ESPDOC').AsString;
                        strEmp := FieldByName('FIS_CODEMP').AsString;
                        strSer := FieldByName('FIS_SERIE_').AsString;
                        strFor := FieldByName('FIS_FORCLI').AsString;

                        If (FieldByName('FIS_ENTSAI').AsString = 'S') Then
                          strTransacao := strTransacao + fPadR(FieldByName('FIS_TIPFRE').AsString, 01) //ciffob
                        Else
                        Begin
                          If fEmptyStr(FieldByName('FIS_MODFRE').AsString) Then
                          Begin
                            If (fStrToFloat(FieldByName('FIS_TOTFRE').AsString) <= 0) And (Not TFreCon.fTemFreConhecimento(strDoc, strEsp, strEmp, strSer, strFor)) Then
                              strTransacao := strTransacao + fPadR('1', 01)
                            Else
                              strTransacao := strTransacao + fPadR('2', 01); //ciffob
                          End
                          Else
                            strTransacao := strTransacao + fPadR(FieldByName('FIS_MODFRE').AsString, 01); //ciffob
                        End;

                        strTransacao := strTransacao +
                        fPadR      (FieldByName('FIS_NUMSER').AsString          , 20)     + //Número de Série do ECF
                        fPadR      (StrModDoc                                   , 02)     + //moddoc
                        fPadR      (FieldByName('FIS_NUMCOO').AsString          , 06)     + //Número do COO
                        fPadR      (''                                          , 02)     + //subser
                        fPadR      (FieldByName('FIS_CONPAG').AsString          , 38)     + //cndpag
                        fPadR      (''                                          , 18)     + //cgcqpt
                        fPadR      (''                                          , 18)     + //iesqpt
                        fPadR      (''                                          , 02)     + //estqpt
                        fPadR      (''                                          , 18)     + //cgcqnp
                        fPadR      (''                                          , 18)     + //iesqnp
                        fPadR      (''                                          , 02)     + //estqnp
                        fPadR      (''                                          , 08)     + //dtanot
                        fPadR      (''                                          , 02)     + //modnot
                        fPadR      (''                                          , 03)     + //sernot
                        fPadR      (''                                          , 06)     + //numnot
                        fStrZero   (0                                           , 12)     + //valnot
                        fPadR      (FieldByName('FIS_CLFSC1').AsString          , 04)     + //clas. fiscal 1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLCON1').AsFloat),',','.'), 12) + //vlcon1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIC1').AsFloat),',','.'), 12) + //basic1
                        fPadL      (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ALQIC1').AsFloat),',','.'), 05), 05) + //alqic1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIC1').AsFloat),',','.'), 12) + //vlric1
                        fPadL      (IIF(RightStr(FieldByName('FIS_CLFSC1').AsString,3) = '933','0',AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_OUTRA1').AsFloat),',','.')), 12) + //outra1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ISENT1').AsFloat),',','.'), 12) + //isent1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BCRET1').AsFloat),',','.'), 12) + //bcret1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_RETID1').AsFloat),',','.'), 12) + //retid1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIP1').AsFloat),',','.'), 12) + //basip1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIP1').AsFloat),',','.'), 12) + //vlrip1
                        fPadR      (''                                                                           , 01) + //dicla1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_DACES1').AsFloat),',','.'), 12) + //daces1
                        fPadL      ('0'                                                                          , 12) + //outras ipi
                        fPadL      ('0'                                                                          , 12) + //isentas ipi
                        fPadR      (FieldByName('FIS_CLFSC2').AsString                                           , 04) + //clas. fiscal 2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLCON2').AsFloat),',','.'), 12) + //vlcon2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIC2').AsFloat),',','.'), 12) + //basic2
                        fPadL      (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ALQIC2').AsFloat),',','.'), 05), 05) + //alqic2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIC2').AsFloat),',','.'), 12) + //vlric2
                        fPadL      (IIF(RightStr(FieldByName('FIS_CLFSC2').AsString,3) = '933','0',AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_OUTRA2').AsFloat),',','.')), 12) + //outra2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ISENT2').AsFloat),',','.'), 12) + //isent2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BCRET2').AsFloat),',','.'), 12) + //bcret2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_RETID2').AsFloat),',','.'), 12) + //retid2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIP2').AsFloat),',','.'), 12) + //basip2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIP2').AsFloat),',','.'), 12) + //vlrip2
                        fPadR      (''                                                                           , 01) + //dicla2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_DACES2').AsFloat),',','.'), 12) + //daces2
                        fPadL      ('0'                                                                          , 12) + //outras ipi
                        fPadL      ('0'                                                                          , 12) + //isentas ipi
                        fPadR      (FieldByName('FIS_CLFSC3').AsString                                           , 04) + //clas. fiscal 3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLCON3').AsFloat),',','.'), 12) + //vlcon3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIC3').AsFloat),',','.'), 12) + //basic3
                        fPadL      (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ALQIC3').AsFloat),',','.'), 05), 05) + //alqic3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIC3').AsFloat),',','.'), 12) + //vlric3
                        fPadL      (IIF(RightStr(FieldByName('FIS_CLFSC3').AsString,3) = '933','0',AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_OUTRA3').AsFloat),',','.')), 12) + //outra3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ISENT3').AsFloat),',','.'), 12) + //isent3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BCRET3').AsFloat),',','.'), 12) + //bcret3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_RETID3').AsFloat),',','.'), 12) + //retid3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIP3').AsFloat),',','.'), 12) + //basip3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIP3').AsFloat),',','.'), 12) + //vlrip3
                        fPadR      (''                                                                           , 01) + //dicla3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_DACES3').AsFloat),',','.'), 12) + //daces3
                        fPadL      ('0'                                                                          , 12) + //outras ipi
                        fPadL      ('0'                                                                          , 12) + //isentas ipi
                        fPadR      (FieldByName('FIS_CLFSC4').AsString                                           , 04) + //clas. fiscal 4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLCON4').AsFloat),',','.'), 12) + //vlcon4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIC4').AsFloat),',','.'), 12) + //basic4
                        fPadL      (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ALQIC4').AsFloat),',','.'), 05), 05) + //alqic4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIC4').AsFloat),',','.'), 12) + //vlric4
                        fPadL      (IIF(RightStr(FieldByName('FIS_CLFSC4').AsString,3) = '933','0',AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_OUTRA4').AsFloat),',','.')), 12) + //outra4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ISENT4').AsFloat),',','.'), 12) + //isent4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BCRET4').AsFloat),',','.'), 12) + //bcret4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_RETID4').AsFloat),',','.'), 12) + //retid4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIP4').AsFloat),',','.'), 12) + //basip4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIP4').AsFloat),',','.'), 12) + //vlrip4
                        fPadR      (''                                                                           , 01) + //dicla4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_DACES4').AsFloat),',','.'), 12) + //daces4
                        fPadL      ('0'                                                                          , 12) + //outras ipi
                        fPadL      ('0'                                                                          , 12) + //isentas ipi
                        fPadR      (FieldByName('FIS_CLFSC5').AsString                                           , 04) + //clas. fiscal 5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLCON5').AsFloat),',','.'), 12) + //vlcon5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIC5').AsFloat),',','.'), 12) + //basic5
                        fPadL      (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ALQIC5').AsFloat),',','.'), 05), 05) + //alqic5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIC5').AsFloat),',','.'), 12) + //vlric5
                        fPadL      (IIF(RightStr(FieldByName('FIS_CLFSC5').AsString,3) = '933','0',AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_OUTRA5').AsFloat),',','.')), 12) + //outra5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ISENT5').AsFloat),',','.'), 12) + //isent5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BCRET5').AsFloat),',','.'), 12) + //bcret5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_RETID5').AsFloat),',','.'), 12) + //retid5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIP5').AsFloat),',','.'), 12) + //basip5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIP5').AsFloat),',','.'), 12) + //vlrip5
                        fPadR      (''                                                                           , 01) + //dicla5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_DACES5').AsFloat),',','.'), 12) + //daces5
                        fPadL      ('0'                                                                          , 12) + //outras ipi
                        fPadL      ('0'                                                                          , 12) + //isentas ipi
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',fltValSer                        ),',','.'), 12) + //VALSER
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',fltValIss                        ),',','.'), 12) + //VALISS
                        fPadL      (RightStr(AnsiReplaceStr(FormatFloat('0.00',fltPerIss                        ),',','.'), 06), 06) + //PERISS
                        fPadR      (FieldByName('FIS_CODCON').AsString                                           , 08) +  //Codigo Contabil
                        fPadR      (''                                                                           , 40) + //FIS_ENDNOT
                        fPadR      (''                                                                           , 25) + //FIS_cidnot
                        fPadR      (''                                                                           , 02) + //FIS_ESTNOT
                        fPadR      ('0'                                                                          , 01) + //FIS_NCCNOT
                        fPadR      (''                                                                           , 18) + //FIS_cgcnot
                        fPadR      (''                                                                           , 18) + //IESNOT
                        fPadR      (''                                                                           , 01);  //FIS_NOTELE

        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {***************************LB*}
        lstTexto.Add(strTransacao);

        Next;
      End;
    End;

    lstTexto.SaveToFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);

  End;

  FreeAndNil(qryGenFis);
  FreeAndNil(lstTexto);

end;

procedure TfrmExpAutSin.pGeraArqDelCadFisc;
  Var
    strSQL      : String;
    strTransacao: String;
    strNomArq   : String;
    strDtaDoc   : String;
    strDtaEnt   : String;
    strDtaDel   : String;
    strNotCom   : String;
    strNotEsp   : String;
    strC_e_p_   : String;
    StrModDoc   : String;
    strDoc      : String;
    strEsp      : String;
    strEmp      : String;
    strSer      : String;
    strFor      : String;
    fltValSer   : Double;
    fltValIss   : Double;
    fltPerIss   : Double;
    lstTexto    : TStringList;
    qryGenFis : TUniQuery;
begin
  qryGenFis := fCriaQuery(Self);

  strNomArq := 'DELFIS.TXT';

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  DEL_CADFIS.*, ';
  strSQL := strSQL + '  IFNULL(IFNULL(M.GER_CONPAG, N.GER_CONPAG), "01000") AS FIS_CONPAG, ';
  strSQL := strSQL + '  IFNULL(IFNULL(M.GER_TIPFRE, N.GER_TIPFRE), "0")     AS FIS_TIPFRE, ';
  strSQL := strSQL + '  IFNULL(IFNULL(M.GER_TOTFRE, N.GER_TOTFRE), "0,00")  AS FIS_TOTFRE, ';
  strSQL := strSQL + '  IFNULL(IFNULL(M.GER_ORIDOC, N.GER_ORIDOC), "")      AS ORIDOC ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DEL_CADFIS ';
  strSQL := strSQL + '  LEFT JOIN DEL_MOVGER M ON M.GER_NUMDOC = FIS_NUMDOC AND ';
  strSQL := strSQL + '                            M.GER_ESPDOC = FIS_ESPDOC AND ';
  strSQL := strSQL + '                            M.GER_CODEMP = FIS_CODEMP AND ';
  strSQL := strSQL + '                            IFNULL(M.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") AND ';
  strSQL := strSQL + '                            M.GER_TIP_FC = FIS_TIP_FC AND ';
  strSQL := strSQL + '                            IF(M.GER_TIP_FC = "C", M.GER_CODCLI, M.GER_CODFOR) = FIS_FORCLI ';
  strSQL := strSQL + '  LEFT JOIN DEL_NOTGER N ON N.GER_NUMDOC = FIS_NUMDOC AND ';
  strSQL := strSQL + '                            N.GER_ESPDOC = FIS_ESPDOC AND ';
  strSQL := strSQL + '                            N.GER_CODEMP = FIS_CODEMP AND ';
  strSQL := strSQL + '                            IFNULL(N.GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") AND ';
  strSQL := strSQL + '                            N.GER_TIP_FC = FIS_TIP_FC AND ';
  strSQL := strSQL + '                            IF(N.GER_TIP_FC = "C", N.GER_CODCLI, N.GER_CODFOR) = FIS_FORCLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DEL_CADFIS.DTADEL BETWEEN :DTAINI AND :DTAFIN ';
  strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';

  If Not chkNF.Checked Then
  Begin
    strSQL := strSQL + '  AND FIS_ESPDOC <> "NF" ';
    strSQL := strSQL + '  AND FIS_ESPDOC <> "EL" ';
    strSQL := strSQL + '  AND FIS_ESPDOC <> "D1" ';
  End;

  If Not chkIF.Checked Then
  Begin
    strSQL := strSQL + '  AND FIS_ESPDOC <> "IF" ';
    strSQL := strSQL + '  AND FIS_ESPDOC <> "IV" ';
  End;

  With qryGenFis Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
    Open;
  End;

  If Not qryGenFis.IsEmpty Then
  Begin

    lstTexto := TStringList.Create;

    {**************************}
    {* TRANSAÇÃO DO ARQUIVO   *}
    {***********************LB*}
    With qryGenFis Do
    Begin
      strTransacao := '';

      blnEnviaCliCon := False;
      While Not Eof Do
      Begin
        Application.ProcessMessages;

        {*****************************************}
        {* VERIFICA SE É NECESSÁRIO ENVIAR O     *}
        {* CLIENTE CONSUMIDOR.                   *}
        {**************************************MV*}
        If (SameText(FieldByName('FIS_TIP_FC').AsString, 'F')) And (SameText(FieldByName('ORIDOC').AsString, 'V')) Then
        Begin
          blnEnviaCliCon := True;
        End;

        {**************************************}
        {* CALCULA VALORES DO SERVIÇO         *}
        {***********************************AF*}
        fltValSer := 0;
        fltPerIss := 0;
        fltValIss := FieldByName('FIS_VALIS1').AsFloat + FieldByName('FIS_VALIS2').AsFloat +
                     FieldByName('FIS_VALIS3').AsFloat + FieldByName('FIS_VALIS4').AsFloat +
                     FieldByName('FIS_VALIS5').AsFloat;

        If RightStr(FieldByName('FIS_CLFSC1').AsString,3) = '933' Then
          fltValSer := FieldByName('FIS_VLCON1').AsFloat

        Else If RightStr(FieldByName('FIS_CLFSC2').AsString,3) = '933' Then
          fltValSer := FieldByName('FIS_VLCON2').AsFloat

        Else If RightStr(FieldByName('FIS_CLFSC3').AsString,3) = '933' Then
          fltValSer := FieldByName('FIS_VLCON3').AsFloat

        Else If RightStr(FieldByName('FIS_CLFSC4').AsString,3) = '933' Then
          fltValSer := FieldByName('FIS_VLCON4').AsFloat

        Else If RightStr(FieldByName('FIS_CLFSC5').AsString,3) = '933' Then
          fltValSer := FieldByName('FIS_VLCON5').AsFloat;

        If fltValSer > 0 Then
        Begin
          fltPerIss := fFormataFloat( (fltValIss/fltValSer) * 100 ,1);
        End;

        {**************************************}
        {* CARREGA VARIAVEIS                  *}
        {***********************************LB*}
        If fEmptyStr(FieldByName('FIS_DTAENT').AsString) Then
          strDtaEnt := ''
        Else
          strDtaEnt := FormatDateTime('yyyy',FieldByName('FIS_DTAENT').AsDateTime) +
                       FormatDateTime('mm',FieldByName('FIS_DTAENT').AsDateTime)   +
                       FormatDateTime('dd',FieldByName('FIS_DTAENT').AsDateTime);

        If fEmptyStr(FieldByName('FIS_DTADOC').AsString) Then
          strDtaDoc := ''
        Else
          strDtaDoc := FormatDateTime('yyyy',FieldByName('FIS_DTADOC').AsDateTime) +
                       FormatDateTime('mm',FieldByName('FIS_DTADOC').AsDateTime)   +
                       FormatDateTime('dd',FieldByName('FIS_DTADOC').AsDateTime);

        If fEmptyStr(FieldByName('DTADEL').AsString) Then
          strDtaDel := ''
        Else
          strDtaDel := FormatDateTime('yyyy',FieldByName('DTADEL').AsDateTime) +
                       FormatDateTime('mm',FieldByName('DTADEL').AsDateTime)   +
                       FormatDateTime('dd',FieldByName('DTADEL').AsDateTime);

        strNotCom := 'F';
        If FieldByName('FIS_NFCOMP').AsString = 'S' Then
          strNotCom := 'T';

        strNotEsp := 'F';
        If FieldByName('FIS_NOTESP').AsString = 'S' Then
          strNotEsp := 'T';

        If FieldByName('FIS_ESPDOC').AsString = 'IF' Then
          StrModDoc := '2D'
        Else
        Begin
          If fEmptyStr(FieldByName('FIS_ACESSO').AsString) Then
            StrModDoc := '01'
          Else
            StrModDoc := '55';
        End;

        strC_e_p_ := fRetCepCliFor(FieldByName('FIS_FORCLI').AsString,
                                   FieldByName('FIS_TIP_FC').AsString,
                                   FieldByName('FIS_CODEMP').AsString,
                                   FieldByName('FIS_NUMDOC').AsString,
                                   FieldByName('FIS_ESPDOC').AsString);

        strTransacao := fPadR      (strDtaEnt                                   , 08)     + //DATA ENTRADA
                        fPadR      (FieldByName('FIS_ESPDOC').AsString          , 02)     + //ESPECIE
                        fPadR      (FieldByName('FIS_SERIE_').AsString          , 03)     + //SERIE
                        fPadR      (FieldByName('FIS_NUMDOC').AsString          , 06)     + //NUMERO DOCUMENTO
                        fPadR      (FieldByName('FIS_NUMDO2').AsString          , 06)     + //NUMERO DOCUMENTO2
                        fPadR      (FieldByName('FIS_ENTSAI').AsString          , 01)     + //ENTRADA OU SAIDA
                        fPadR      (StrDtaDoc                                   , 08)     + //DATA DOCUMENTO

                        IIF((SameText(FieldByName('FIS_TIP_FC').AsString, 'F')) And (SameText(FieldByName('ORIDOC').AsString, 'V')),
                          fGetClienteConsumidor,
                          fPadR(FieldByName('FIS_FORCLI').AsString              , 08))    + //FORNECEDOR OU CLIENTE

                        fPadR      (FieldByName('FIS_HISTOR').AsString          , 17)     + //HISTORICO
                        fPadR      (strC_e_p_                                   , 08)     + //CEP
                        fPadR      (FieldByName('FIS_ESTADO').AsString          , 02)     + //estado
                        fPadR      (FieldByName('FIS_CODEMP').AsString          , 03)     + //numloj

                        IIF((SameText(FieldByName('FIS_TIP_FC').AsString, 'F')) And (SameText(FieldByName('ORIDOC').AsString, 'V')),
                          'C',
                          fPadR(FieldByName('FIS_TIP_FC').AsString              , 01))    + //tip_fc

                        fPadR      (strNotCom                                   , 01)     + //nfcomp
                        fPadR      (strNotEsp                                   , 01);      //notesp

                        strDoc := FieldByName('FIS_NUMDOC').AsString;
                        strEsp := FieldByName('FIS_ESPDOC').AsString;
                        strEmp := FieldByName('FIS_CODEMP').AsString;
                        strSer := FieldByName('FIS_SERIE_').AsString;
                        strFor := FieldByName('FIS_FORCLI').AsString;

                        If (FieldByName('FIS_ENTSAI').AsString = 'S') Then
                          strTransacao := strTransacao + fPadR(FieldByName('FIS_TIPFRE').AsString, 01) //ciffob
                        Else
                        Begin
                          If fEmptyStr(FieldByName('FIS_MODFRE').AsString) Then
                          Begin
                            If (fStrToFloat(FieldByName('FIS_TOTFRE').AsString) <= 0) And (Not TFreCon.fTemFreConhecimento(strDoc, strEsp, strEmp, strSer, strFor)) Then
                              strTransacao := strTransacao + fPadR('1', 01)
                            Else
                              strTransacao := strTransacao + fPadR('2', 01); //ciffob
                          End
                          Else
                            strTransacao := strTransacao + fPadR(FieldByName('FIS_MODFRE').AsString, 01); //ciffob
                        End;

                        strTransacao := strTransacao +
                        fPadR      (FieldByName('FIS_NUMSER').AsString          , 20)     + //Número de Série do ECF
                        fPadR      (''                                          , 02)     + //moddoc
                        fPadR      (FieldByName('FIS_NUMCOO').AsString          , 06)     + //Número do COO
                        fPadR      (''                                          , 02)     + //subser
                        fPadR      (FieldByName('FIS_CONPAG').AsString          , 38)     + //cndpag
                        fPadR      (''                                          , 18)     + //cgcqpt
                        fPadR      (''                                          , 18)     + //iesqpt
                        fPadR      (''                                          , 02)     + //estqpt
                        fPadR      (''                                          , 18)     + //cgcqnp
                        fPadR      (''                                          , 18)     + //iesqnp
                        fPadR      (''                                          , 02)     + //estqnp
                        fPadR      (''                                          , 08)     + //dtanot
                        fPadR      (''                                          , 02)     + //modnot
                        fPadR      (''                                          , 03)     + //sernot
                        fPadR      (''                                          , 06)     + //numnot
                        fStrZero   (0                                           , 12)     + //valnot

                        fPadR      (FieldByName('FIS_CLFSC1').AsString          , 04)     + //clas. fiscal 1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLCON1').AsFloat),',','.'), 12) + //vlcon1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIC1').AsFloat),',','.'), 12) + //basic1
                        fPadL      (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ALQIC1').AsFloat),',','.'), 05), 05) + //alqic1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIC1').AsFloat),',','.'), 12) + //vlric1
                        fPadL      (IIF(RightStr(FieldByName('FIS_CLFSC1').AsString,3) = '933','0',AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_OUTRA1').AsFloat),',','.')), 12) + //outra1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ISENT1').AsFloat),',','.'), 12) + //isent1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BCRET1').AsFloat),',','.'), 12) + //bcret1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_RETID1').AsFloat),',','.'), 12) + //retid1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIP1').AsFloat),',','.'), 12) + //basip1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIP1').AsFloat),',','.'), 12) + //vlrip1
                        fPadR      (''                                                                           , 01) + //dicla1
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_DACES1').AsFloat),',','.'), 12) + //daces1
                        fPadL      ('0'                                                                          , 12) + //outras ipi
                        fPadL      ('0'                                                                          , 12) + //isentas ipi

                        fPadR      (FieldByName('FIS_CLFSC2').AsString                                           , 04) + //clas. fiscal 2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLCON2').AsFloat),',','.'), 12) + //vlcon2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIC2').AsFloat),',','.'), 12) + //basic2
                        fPadL      (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ALQIC2').AsFloat),',','.'), 05), 05) + //alqic2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIC2').AsFloat),',','.'), 12) + //vlric2
                        fPadL      (IIF(RightStr(FieldByName('FIS_CLFSC2').AsString,3) = '933','0',AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_OUTRA2').AsFloat),',','.')), 12) + //outra2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ISENT2').AsFloat),',','.'), 12) + //isent2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BCRET2').AsFloat),',','.'), 12) + //bcret2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_RETID2').AsFloat),',','.'), 12) + //retid2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIP2').AsFloat),',','.'), 12) + //basip2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIP2').AsFloat),',','.'), 12) + //vlrip2
                        fPadR      (''                                                                           , 01) + //dicla2
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_DACES2').AsFloat),',','.'), 12) + //daces2
                        fPadL      ('0'                                                                          , 12) + //outras ipi
                        fPadL      ('0'                                                                          , 12) + //isentas ipi

                        fPadR      (FieldByName('FIS_CLFSC3').AsString                                           , 04) + //clas. fiscal 3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLCON3').AsFloat),',','.'), 12) + //vlcon3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIC3').AsFloat),',','.'), 12) + //basic3
                        fPadL      (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ALQIC3').AsFloat),',','.'), 05), 05) + //alqic3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIC3').AsFloat),',','.'), 12) + //vlric3
                        fPadL      (IIF(RightStr(FieldByName('FIS_CLFSC3').AsString,3) = '933','0',AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_OUTRA3').AsFloat),',','.')), 12) + //outra3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ISENT3').AsFloat),',','.'), 12) + //isent3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BCRET3').AsFloat),',','.'), 12) + //bcret3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_RETID3').AsFloat),',','.'), 12) + //retid3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIP3').AsFloat),',','.'), 12) + //basip3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIP3').AsFloat),',','.'), 12) + //vlrip3
                        fPadR      (''                                                                           , 01) + //dicla3
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_DACES3').AsFloat),',','.'), 12) + //daces3
                        fPadL      ('0'                                                                          , 12) + //outras ipi
                        fPadL      ('0'                                                                          , 12) + //isentas ipi

                        fPadR      (FieldByName('FIS_CLFSC4').AsString                                           , 04) + //clas. fiscal 4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLCON4').AsFloat),',','.'), 12) + //vlcon4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIC4').AsFloat),',','.'), 12) + //basic4
                        fPadL      (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ALQIC4').AsFloat),',','.'), 05), 05) + //alqic4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIC4').AsFloat),',','.'), 12) + //vlric4
                        fPadL      (IIF(RightStr(FieldByName('FIS_CLFSC4').AsString,3) = '933','0',AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_OUTRA4').AsFloat),',','.')), 12) + //outra4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ISENT4').AsFloat),',','.'), 12) + //isent4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BCRET4').AsFloat),',','.'), 12) + //bcret4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_RETID4').AsFloat),',','.'), 12) + //retid4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIP4').AsFloat),',','.'), 12) + //basip4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIP4').AsFloat),',','.'), 12) + //vlrip4
                        fPadR      (''                                                                           , 01) + //dicla4
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_DACES4').AsFloat),',','.'), 12) + //daces4
                        fPadL      ('0'                                                                          , 12) + //outras ipi
                        fPadL      ('0'                                                                          , 12) + //isentas ipi

                        fPadR      (FieldByName('FIS_CLFSC5').AsString                                           , 04) + //clas. fiscal 5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLCON5').AsFloat),',','.'), 12) + //vlcon5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIC5').AsFloat),',','.'), 12) + //basic5
                        fPadL      (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ALQIC5').AsFloat),',','.'), 05), 05) + //alqic5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIC5').AsFloat),',','.'), 12) + //vlric5
                        fPadL      (IIF(RightStr(FieldByName('FIS_CLFSC5').AsString,3) = '933','0',AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_OUTRA5').AsFloat),',','.')), 12) + //outra5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_ISENT5').AsFloat),',','.'), 12) + //isent5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BCRET5').AsFloat),',','.'), 12) + //bcret5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_RETID5').AsFloat),',','.'), 12) + //retid5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_BASIP5').AsFloat),',','.'), 12) + //basip5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_VLRIP5').AsFloat),',','.'), 12) + //vlrip5
                        fPadR      (''                                                                           , 01) + //dicla5
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',FieldByName('FIS_DACES5').AsFloat),',','.'), 12) + //daces5
                        fPadL      ('0'                                                                          , 12) + //outras ipi
                        fPadL      ('0'                                                                          , 12) + //isentas ipi
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',fltValSer),',','.')                        , 12) + //VALSER
                        fPadL      (AnsiReplaceStr(FormatFloat('0.00',fltValIss),',','.')                        , 12) + //VALISS
                        fPadL      (RightStr(AnsiReplaceStr(FormatFloat('0.00',fltPerIss),',','.')                        ,06) , 06) + //PERISS
                        fPadR      (FieldByName('FIS_CODCON').AsString                                           , 08) + //Codigo Contabil
                        fPadR      (''                                                                           , 40) + //ENDNOT
                        fPadR      (''                                                                           , 25) + //CIDNOT
                        fPadR      (''                                                                           , 02) + //ESTNOT
                        fPadR      (''                                                                           , 01) + //NCCNOT
                        fPadR      (''                                                                           , 18) + //CGCNOT
                        fPadR      (''                                                                           , 18) + //IESNOT
                        fPadR      (''                                                                           , 01) +  //FIS_NOTELE
                        fPadR      (''                                                                           , 02) +
                        fPadR      (''                                                                           , 08) +
                        fPadR      (''                                                                           , 08) +
                        fPadR      (strDtaDel                                                                    , 08); //DATA DELEÇÃO

        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {***************************LB*}
        lstTexto.Add(strTransacao);

        Next;
      End;
    End;

    lstTexto.SaveToFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);

  End;

  FreeAndNil(qryGenFis);
  FreeAndNil(lstTexto);

end;

function TfrmExpAutSin.fRetCepCliFor(strCliFor, strTip_FC, strCodEmp, strNumDoc, strEspDoc:String):String;

  Var
    strSQL   : String;
    strNome  : String;
    qryGenFor: TUniQuery;
    qryGenGer: TUniQuery;

Begin
  qryGenFor := fCriaQuery(Self);
  qryGenGer := fCriaQuery(Self);

  If strTip_FC = 'C' Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CLI_C_E_P_ AS CEP, ';
    strSQL := strSQL + '  CLI_NOMCLI AS NOME ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CLI_CODCLI = :CLIFOR ';
  End
  Else
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  FOR_C_E_P_ AS CEP, ';
    strSQL := strSQL + '  FOR_NOMFOR AS NOME ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADFOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FOR_CODFOR = :CLIFOR ';
  End;

  With qryGenFor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CLIFOR').AsString := strCliFor;
    Open;
    Result  := qryGenFor.FieldByName('CEP').AsString;
    strNome := qryGenFor.FieldByName('NOME').AsString;
    Close;
  End;

  If (strTip_FC = 'C') And (fClienteConsumidor(strNome, False, True)) Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_CEPCON AS CEP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_CODCLI = :CLIFOR AND ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CLIFOR').AsString := strCliFor;
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      Result := FieldByName('CEP').AsString;
      Close;
    End;
  End;

  FreeAndNil(qryGenFor);
  FreeAndNil(qryGenGer);

End;

procedure TfrmExpAutSin.pGeraArqCadCli;
  Var
    strSQL      : String;
    strTransacao: String;
    strNomArq   : String;
    strDtaCad   : String;
    strDtaNasCim: String;
    strDtaUltCom: String;
//    txtTexto    : TextFile;
    lstTexto    : TStringList;
    qryExpCli   : TUniQuery;

begin
  Try
    qryExpCli := fCriaQuery(Self);

    strNomArq := 'CADCLI.TXT';

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  DISTINCT CADCLI.*, ';
    strSQL := strSQL + '  CID_COIBGE AS CLI_COIBGE, ';
    strSQL := strSQL + '  CID_NOMCID AS CLI_CIDADE, ';
    strSQL := strSQL + '  CID_ESTADO AS CLI_ESTADO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADFIS, ';
    strSQL := strSQL + '  CADCLI, ';
    strSQL := strSQL + '  CADCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FIS_TIP_FC = "C" AND ';
    strSQL := strSQL + '  FIS_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  FIS_FORCLI = CLI_CODCLI AND ';
    strSQL := strSQL + '  CLI_CODCID = CID_CODCID ';

    If Not chkNF.Checked Then
    Begin
      strSQL := strSQL + '  AND FIS_ESPDOC <> "NF" ';
      strSQL := strSQL + '  AND FIS_ESPDOC <> "EL" ';
      strSQL := strSQL + '  AND FIS_ESPDOC <> "D1" ';      
    End;

    If Not chkIF.Checked Then
    Begin
      strSQL := strSQL + '  AND FIS_ESPDOC <> "IF" ';
      strSQL := strSQL + '  AND FIS_ESPDOC <> "IV" ';
    End;

    If (blnEnviaCliCon) Then
    Begin

      strSQL := strSQL + ' UNION ALL ';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  CADCLI.*, ';
      strSQL := strSQL + '  CID_COIBGE AS CLI_COIBGE, ';
      strSQL := strSQL + '  CID_NOMCID AS CLI_CIDADE, ';
      strSQL := strSQL + '  CID_ESTADO AS CLI_ESTADO ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADCLI ';
      strSQL := strSQL + 'JOIN CADCID ON CID_CODCID = CLI_CODCID ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CLI_NOMCLI LIKE "%CONSUMIDOR%" OR ';
      strSQL := strSQL + '  CLI_NOMCLI LIKE "%BALCAO%" OR ';
      strSQL := strSQL + '  CLI_NOMCLI LIKE "%BALCÃO%" OR     ';
      strSQL := strSQL + '  CLI_NOMCLI LIKE "%SEGURADORA%"    ';

    End;

    With qryExpCli Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      Open;
    End;

    If Not qryExpCli.IsEmpty Then
    Begin

//      AssignFile(txtTexto, fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);
//      Rewrite(txtTexto);

      lstTexto := TStringList.Create;

      {**************************}
      {* TRANSAÇÃO DO ARQUIVO   *}
      {***********************LB*}
      With qryExpCli Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          If fEmptyStr(FieldByName('CLI_DTACAD').AsString) Then
            strDtaCad := ''
          Else
            strDtaCad := FormatDateTime('yyyy',FieldByName('CLI_DTACAD').AsDateTime) +
                         FormatDateTime('mm',FieldByName('CLI_DTACAD').AsDateTime)   +
                         FormatDateTime('dd',FieldByName('CLI_DTACAD').AsDateTime);

          If fEmptyStr(FieldByName('CLI_NASCIM').AsString) Then
            strDtaNasCim := ''
          Else
            strDtaNasCim := FormatDateTime('yyyy',FieldByName('CLI_NASCIM').AsDateTime) +
                            FormatDateTime('mm',FieldByName('CLI_NASCIM').AsDateTime)   +
                            FormatDateTime('dd',FieldByName('CLI_NASCIM').AsDateTime);

          If fEmptyStr(FieldByName('CLI_ULTCOM').AsString) Then
            strDtaUltCom := ''
          Else
            strDtaUltCom := FormatDateTime('yyyy',FieldByName('CLI_ULTCOM').AsDateTime) +
                            FormatDateTime('mm',FieldByName('CLI_ULTCOM').AsDateTime)   +
                            FormatDateTime('dd',FieldByName('CLI_ULTCOM').AsDateTime);


          strTransacao := fPadR      (FieldByName('CLI_CODCLI').AsString          , 08)     + //codigo cliente
                          fPadR      (strDtaCad                                   , 08)     + //data cadastro
                          fPadR      (FieldByName('CLI_NOMCLI').AsString          , 40)     + //nome cliente
                          fPadR      (FieldByName('CLI_FANSOB').AsString          , 20)     + //nome fantasia
                          fPadR      (FieldByName('CLI_ENDERE').AsString          , 40)     + //endereco
                          fPadR      (FieldByName('CLI_BAIRRO').AsString          , 18)     + //bairro
                          fPadR      (FieldByName('CLI_C_E_P_').AsString          , 08)     + //cep
                          fPadR      (FieldByName('CLI_CIDADE').AsString          , 25)     + //cidade
                          fPadR      (FieldByName('CLI_ESTADO').AsString          , 02)     + //estado
                          fPadR      (FieldByName('CLI_CGCCPF').AsString          , 01)     + //cgccpf
                          fPadR      (FieldByName('CLI_C_G_C_').AsString          , 18)     + //cgc
                          fPadR      (FieldByName('CLI_I_E_S_').AsString          , 18)     + //ies
                          fPadR      (FieldByName('CLI_I_M_P_').AsString          , 15)     + //imp
                          fPadL      (FieldByName('CLI_FONE01').AsString          , 11)     + //fone01
                          fPadL      (FieldByName('CLI_FONE02').AsString          , 11)     + //fone02
                          fPadL      (FieldByName('CLI_F_A_X_').AsString          , 11)     + //fax
                          fPadR      (FieldByName('CLI_CONTAT').AsString          , 25)     + //contato
                          fPadR      (FieldByName('CLI_STATUS').AsString          , 01)     + //status
                          fPadR      (FieldByName('CLI_EMAIL_').AsString          , 50)     + //e-mail
                          fPadR      (FieldByName('CLI_HOMEPA').AsString          , 50)     + //homepage
                          fPadR      (strDtaNasCim                                , 08)     + //data nascimento
                          fPadR      (FieldByName('CLI_CAIPOS').AsString          , 05)     + //caipos
                          fPadR      (FieldByName('CLI_NUMR_G').AsString          , 12)     + //rg
                          fPadR      (strDtaUltCom                                , 08)     + //ultima compra
                          fPadR      (FieldByName('CLI_COIBGE').AsString          , 07)     + //ibge
                          fPadR      (''                                          , 01)     + //SUFRAM
                          fPadR      (FieldByName('CLI_CONSUM').AsString          , 01);      //CLI_CONSUM

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************LB*}
//          Writeln(txtTexto,strTransacao);
          lstTexto.Add(strTransacao);

          Next;
        End;
      End;

//      CloseFile(txtTexto);
    lstTexto.SaveToFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);

    End;

  Finally
    FreeAndNil(qryExpCli);
    FreeAndNil(lstTexto);
  End;

end;

procedure TfrmExpAutSin.pGeraArqCadFor;
  Var
    strSQL      : String;
    strTransacao: String;
    strNomArq   : String;
    strDtaCad   : String;
//    txtTexto    : TextFile;
    lstTexto    : TStringList;
    qryCadFor: TUniQuery;
begin
  Try
    qryCadFor := fCriaQuery(nil);

    strNomArq := 'CADFOR.TXT';

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  DISTINCT CADFOR.*, ';
    strSQL := strSQL + '  CID_COIBGE AS FOR_COIBGE, ';
    strSQL := strSQL + '  CID_NOMCID AS FOR_CIDADE, ';
    strSQL := strSQL + '  CID_ESTADO AS FOR_ESTADO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADFIS, ';
    strSQL := strSQL + '  CADFOR, ';
    strSQL := strSQL + '  CADCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FIS_TIP_FC = "F" AND ';
    strSQL := strSQL + '  FIS_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  FIS_FORCLI = FOR_CODFOR AND ';
    strSQL := strSQL + '  FOR_CODCID = CID_CODCID ';

    If Not chkNF.Checked Then
    Begin
      strSQL := strSQL + '  AND FIS_ESPDOC <> "NF" ';
      strSQL := strSQL + '  AND FIS_ESPDOC <> "EL" ';
      strSQL := strSQL + '  AND FIS_ESPDOC <> "D1" ';      
    End;

    If Not chkIF.Checked Then
    Begin
      strSQL := strSQL + '  AND FIS_ESPDOC <> "IF" ';
      strSQL := strSQL + '  AND FIS_ESPDOC <> "IV" ';
    End;

    With qryCadFor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      Open;
    End;

    If Not qryCadFor.IsEmpty Then
    Begin

//      AssignFile(txtTexto, fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);
//      Rewrite(txtTexto);

      lstTexto := TStringList.Create;

      {**************************}
      {* TRANSAÇÃO DO ARQUIVO   *}
      {***********************LB*}
      With qryCadFor Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          If fEmptyStr(FieldByName('FOR_DTACAD').AsString) Then
            strDtaCad := ''
          Else
            strDtaCad := FormatDateTime('yyyy',FieldByName('FOR_DTACAD').AsDateTime) +
                         FormatDateTime('mm',FieldByName('FOR_DTACAD').AsDateTime)   +
                         FormatDateTime('dd',FieldByName('FOR_DTACAD').AsDateTime);

          strTransacao := fPadR      (FieldByName('FOR_CODFOR').AsString          , 08)     + //codigo fornecedor
                          fPadR      (FieldByName('FOR_NOMFOR').AsString          , 40)     + //nome fornecedor
                          fPadR      (FieldByName('FOR_NOMFAN').AsString          , 20)     + //nome fantasia
                          fPadR      (FieldByName('FOR_ENDERE').AsString          , 40)     + //endereco
                          fPadR      (FieldByName('FOR_BAIRRO').AsString          , 18)     + //bairro
                          fPadR      (FieldByName('FOR_CIDADE').AsString          , 25)     + //cidade
                          fPadR      (FieldByName('FOR_C_E_P_').AsString          , 08)     + //cep
                          fPadR      (FieldByName('FOR_ESTADO').AsString          , 02)     + //estado
                          fPadR      (FieldByName('FOR_C_G_C_').AsString          , 18)     + //cgc
                          fPadR      (FieldByName('FOR_CGCCPF').AsString          , 01)     + //cgccpf
                          fPadR      (FieldByName('FOR_I_E_S_').AsString          , 18)     + //ies
                          fPadR      (FieldByName('FOR_CONTAT').AsString          , 25)     + //contato
                          fPadR      (FieldByName('FOR_CAIPOS').AsString          , 06)     + //caipos
                          fPadL      (FieldByName('FOR_FONE01').AsString          , 11)     + //fone01
                          fPadL      (FieldByName('FOR_F_A_X_').AsString          , 11)     + //fax
                          fPadR      (FieldByName('FOR_EMAIL_').AsString          , 30)     + //e-mail
                          fPadR      (FieldByName('FOR_HOMEPA').AsString          , 50)     + //homepage
                          fPadR      (strDtaCad                                   , 08)     + //data cadastro
                          fPadR      (FieldByName('FOR_COIBGE').AsString          , 07);      //ibge

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************LB*}
//          Writeln(txtTexto,strTransacao);
          lstTexto.Add(strTransacao);

          Next;
        End;
      End;

//      CloseFile(txtTexto);
    lstTexto.SaveToFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);

    End;

  Finally
    FreeAndNil(qryCadFor);
    FreeAndNil(lstTexto);
  End;

end;


//*****************************************************//
// FUNCAO QUE GERA A EXPORTACAO DO ARQUIVO CADITE.TXT  //
//**************************************************ED*//
procedure TfrmExpAutSin.pGeraArqCadIte;
  Var
    strSQL      : String;
    strTransacao: String;
    strNomArq   : String;
    strDtaCad   : String;
//    txtTexto    : TextFile;
    lstTexto    : TStringList;
    qryCadIte: TUniQuery;

begin
  Try
    qryCadIte := fCriaQuery(nil);

    strNomArq := 'CADITE.TXT';

    strSQL := '';
    strSQL := strSQL + 'SELECT DISTINCT ';
    strSQL := strSQL + '  I.ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '  U.UNI_SIGUNI AS SIGUNI, ';
    strSQL := strSQL + '  I.ITE_DTACAD AS DTACAD, ';
    strSQL := strSQL + '  I.ITE_CLAIPI AS CLAIPI, ';
    strSQL := strSQL + '  I.ITE_CLAIPI AS CLAIPI, ';
    strSQL := strSQL + '  A.ABF_CODSIT AS COSTDE, ';
    strSQL := strSQL + '  A.ABF_BASE_S AS PERBAS, ';
    strSQL := strSQL + '  A.ABF_ALQ__S AS ICMSAI, ';
    strSQL := strSQL + '  G.ITE_IPISAI AS IPISAI, ';
    strSQL := strSQL + '  G.ITE_PRECUS AS PRECUS, ';
    strSQL := strSQL + '  G.ITE_SALDOS AS SALDOS ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  CADABF A, ';
    strSQL := strSQL + '  CADUNI U  ';
    strSQL := strSQL + 'WHERE ';

    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + '  A.ABF_CODABF = I.ITE_CODABF AND '
    Else
      strSQL := strSQL + '  A.ABF_CODABF = G.ITE_CODABF AND ';

    strSQL := strSQL + '  G.ITE_CODITE = I.ITE_CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP      AND ';
    strSQL := strSQL + '  A.ABF_ESTADO = :ESTADO      AND ';
    strSQL := strSQL + '  U.UNI_CODUNI = I.ITE_CODUNI     ';
    //strSQL := strSQL + 'I.ITE_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

    With qryCadIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
      ParamByName('ESTADO').AsString := fCadEmp('ESTADO');
  //    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
  //    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      Open;
    End;

    If Not qryCadIte.IsEmpty Then
    Begin

//      AssignFile(txtTexto, fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);
//      Rewrite(txtTexto);

      lstTexto := TStringList.Create;

      {**************************}
      {* TRANSAÇÃO DO ARQUIVO   *}
      {***********************LB*}
      With qryCadIte Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          If fEmptyStr(FieldByName('DTACAD').AsString) Then
            strDtaCad := ''
          Else
            strDtaCad  := FormatDateTime('yyyy',FieldByName('DTACAD').AsDateTime) +
                          FormatDateTime('mm',FieldByName('DTACAD').AsDateTime)   +
                          FormatDateTime('dd',FieldByName('DTACAD').AsDateTime);

          strTransacao := fPadR (FieldByName('CODITE').AsString          , 14)     + //
                          fPadR (FieldByName('DESITE').AsString          , 40)     + //
                          fPadR (FieldByName('REFERE').AsString          , 16)     + //
                          fPadR (FieldByName('SIGUNI').AsString          , 02)     + //
                          fPadR (FieldByName('COSTDE').AsString          , 03)     + //
                          fPadR (FieldByName('PERBAS').AsString          , 06)     + //
                          fPadR (FieldByName('IPISAI').AsString          , 06)     + //
                          fPadR (FieldByName('ICMSAI').AsString          , 06)     + //
                          fPadR (strDtaCad                               , 08)     + //
                          fPadR (FieldByName('CLAIPI').AsString          , 10)     + //
                          fPadR (FieldByName('PRECUS').AsString          , 12)     + //
                          fPadR (FieldByName('SALDOS').AsString          , 12)     + //
                          fPadR (FieldByName('CLAIPI').AsString          , 08)     + //
                          fPadR (''                                      , 06)     + //
                          fPadR ('0.00'                                  , 12)     + //
                          fPadR ('0.00'                                  , 12);      //

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************LB*}
//          Writeln(txtTexto,strTransacao);
          lstTexto.Add(strTransacao);

          Next;
        End;
      End;

    lstTexto.SaveToFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);
//    CloseFile(txtTexto);

    End;

  Finally
    FreeAndNil(qryCadIte);
    FreeAndNil(lstTexto);
  End;

  { 'ITE_CODITE', 'C', 14, 00 }
  { 'ITE_DESCRI', 'C', 40, 00 }
  { 'ITE_REFERE', 'C', 16, 00 }
  { 'ITE_UNIDAD', 'C', 02, 00 }
  { 'ITE_CODFIS', 'C', 03, 00 }
  { 'ITE_PERBAS', 'N', 06, 02 }
  { 'ITE_IPISAI', 'N', 06, 02 }
  { 'ITE_ALQICM', 'N', 06, 02 }
  { 'ITE_DTACAD', 'D', 08, 00 }
  { 'ITE_CLAIPI', 'C', 10, 00 }
  { 'ITE_PRECUS', 'N', 12, 02 }
  { 'ITE_SALDOS', 'N', 12, 02 }
  { 'ITE_CODNCM', 'C', 08, 00 }
  { 'ITE_DTAINV', 'C', 06, 00 }
  { 'ITE_QTDINV', 'N', 12, 02 }
  { 'ITE_PREINV', 'N', 12, 02 }

end;

procedure TfrmExpAutSin.pGeraArqMovGer;
  Var
    strSQL      : String;
    strTransacao: String;
    strNomArq   : String;
    strDtaCad   : String;
    lstTexto    : TStringList;
    qryMovGer   : TUniQuery;
    qryCliCon   : TUniQuery;
begin
  Try
    qryMovGer := fCriaQuery;
    qryCliCon := fCriaQuery;

    strNomArq := 'FATGER.TXT';

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  0.00 AS GER_TOTFRE, '; //Nao enviar o valor do frete
    strSQL := strSQL + '  G.GER_TOTPRO + G.GER_TOTFRE AS GER_TOTPRO, ';//O valor do frete estara dissolvido nos produtos
    strSQL := strSQL + '  G.*, ';
    strSQL := strSQL + '  F.*, ';
    strSQL := strSQL + '  CIDFOR.CID_NOMCID AS FOR_NOMCID, ';
    strSQL := strSQL + '  CIDFOR.CID_ESTADO AS FOR_ESTADO, ';
    strSQL := strSQL + '  CADCID.CID_NOMCID, ';
    strSQL := strSQL + '  CLI_NOMCLI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVGER G ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CADCID.CID_CODCID = GER_CIDCON ';
    strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADFOR F ON FOR_CODFOR = GER_CODFOR ';
    strSQL := strSQL + '  LEFT JOIN CADCID AS CIDFOR ON CIDFOR.CID_CODCID = FOR_CODCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  (G.GER_CLAFIS > 5000 OR IFNULL(G.GER_ORIDOC, "") = "D" OR IFNULL(G.GER_ORIDOC, "") = "V") AND ';
    strSQL := strSQL + '  G.GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  G.GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    If Not chkNF.Checked Then
    Begin
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "NF" ';
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "EL" ';
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "D1" ';
    End;

    If Not chkIF.Checked Then
    Begin
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "IF" ';
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "IV" ';
    End;

    strSQL := strSQL + 'ORDER BY G.GER_TIP_FC ';

    With qryMovGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      Open;
    End;

    If Not qryMovGer.IsEmpty Then
    Begin
      lstTexto := TStringList.Create;

      {**************************}
      {* TRANSAÇÃO DO ARQUIVO   *}
      {***********************LB*}
      With qryMovGer Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          If fEmptyStr(FieldByName('GER_DTAENT').AsString) Then
            strDtaCad := ''
          Else
            strDtaCad  := FormatDateTime('yyyy',FieldByName('GER_DTAENT').AsDateTime) +
                          FormatDateTime('mm',FieldByName('GER_DTAENT').AsDateTime)   +
                          FormatDateTime('dd',FieldByName('GER_DTAENT').AsDateTime);

          strTransacao := fPadR (FieldByName('GER_NUMDOC').AsString , 06) +                                           // FTG_NUMDOC', 'C', 06, 00
                          fPadR (strDtaCad                          , 08) +                                           // FTG_DTAENT', 'D', 08, 00
                          fPadR (FieldByName('GER_ESPDOC').AsString , 02) +                                           // FTG_ESPDOC', 'C', 02, 00
                          fPadR (FieldByName('GER_CONPAG').AsString , 38) +                                           // FTG_CNDPAG', 'C', 38, 00  // VERIFICAR

                          fPadR (IIF((SameText(FieldByName('GER_TIP_FC').AsString, 'F')) And (SameText(FieldByName('GER_ORIDOC').AsString, 'V')),
                                 fGetClienteConsumidor, FieldByName('GER_CODCLI').AsString), 08) +                    // FTG_CODCLI', 'C', 08, 00

                          fPadR(FieldByName('GER_ESTADO').AsString , 02) +                                           // FTG_ESTADO', 'C', 02, 00

                          fPadR (''                                 , 03) +                                           // FTG_CODATI', 'C', 03, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VLRCON').AsFloat),',','.') , 12) + // FTG_VLCONT', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_DESESP').AsFloat),',','.') , 12) + // FTG_DESESP', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTPRO').AsFloat),',','.') , 12) + // FTG_VLPROD', 'N', 12, 02      // VERIFICAR
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_BASIPI').AsFloat),',','.') , 12) + // FTG_BASIPI', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTIPI').AsFloat),',','.') , 12) + // FTG_TOTIPI', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_BASICM').AsFloat),',','.') , 12) + // FTG_BASICM', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTICM').AsFloat),',','.') , 12) + // FTG_TOTICM', 'N', 12, 02
                          fPadR (FieldByName('GER_CLAFIS').AsString , 04) +                                           // FTG_CLAFIS', 'C', 04, 00
                          fPadR (''                                 , 03) +                                           // FTG_CODARE', 'C', 03, 00
                          fPadR ('0'                             , 05) +                                           // FTG_PERARE', 'N', 05, 02
                          fPadR ('0'                             , 12) +                                           // FTG_COMARE', 'N', 12, 02
                          fPadR (''                                 , 03) +                                           // FTG_CODREP', 'C', 03, 00  // DETALHADO
                          fPadR ('0'                             , 05) +                                           // FTG_PERREP', 'N', 05, 02
                          fPadR ('0'                             , 12) +                                           // FTG_COMREP', 'N', 12, 02
                          fPadR (FieldByName('GER_CODVEN').AsString , 03) +                                           // FTG_CODVEN', 'C', 03, 00
                          fPadR ('0'                             , 05) +                                           // FTG_PERVEN', 'N', 05, 02
                          fPadR ('0'                             , 12) +                                           // FTG_COMVEN', 'N', 12, 02
                          fPadR (''                                 , 08) +                                           // FTG_PROFIS', 'C', 08, 00
                          fPadR (''                                 , 06) +                                           // FTG_NUMORC', 'C', 06, 00
                          fPadR (FieldByName('GER_CODTRA').AsString , 05) +                                           // FTG_CODTRA', 'C', 05, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.000',FieldByName('GER_PESBRU').AsFloat),',','.') , 12) + // FTG_PESOBR', 'N', 12, 03
                          fPadR (AnsiReplaceStr(FormatFloat('0.000',FieldByName('GER_PESLIQ').AsFloat),',','.') , 12) + // FTG_PESOLQ', 'N', 12, 03
                          fPadR (AnsiReplaceStr(FormatFloat('0.000',FieldByName('GER_VOLUME').AsFloat),',','.') , 12) + // FTG_VOLUME', 'N', 12, 03
                          fPadR (FieldByName('GER_ESPECI').AsString , 10) +                                           // FTG_ESPECI', 'C', 10, 00
                          fPadR (FieldByName('GER_MARCA_').AsString , 10) +                                           // FTG_MARCA_', 'C', 10, 00
                          fPadR (FieldByName('GER_MEN001').AsString , 50) +                                           // FTG_MENSAG', 'C', 50, 00
                          fPadR (''                                 , 07) +                                           // FTG_DUPLIC', 'C', 07, 00
                          fPadR (''                                 , 05) +                                           // FTG_PORTAD', 'C', 05, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTRET').AsFloat),',','.') , 12) + // FTG_TOTRET', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_BASRET').AsFloat),',','.') , 12) + // FTG_BASRET', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTCUS').AsFloat),',','.') , 12) + // FTG_TOTCUS', 'N', 12, 02
                          fPadR (FieldByName('GER_TIPFRE').AsString , 01) +                                           // FTG_TIPFRE', 'C', 01, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTFRE').AsFloat),',','.') , 12) + // FTG_VALFRE', 'N', 12, 02
                          fPadR (FieldByName('GER_JAFATU').AsString , 01) +                                           // FTG_JAFATU', 'L', 01, 00
                          fPadR (FieldByName('GER_TIPFAT').AsString , 02) +                                           // FTG_TIPFAT', 'C', 02, 00
                          fPadR (FieldByName('GER_NUMFAT').AsString , 06) +                                           // FTG_NUMFAT', 'C', 06, 00
                          fPadR (FieldByName('GER_DTAFAT').AsString , 08) +                                           // FTG_DTAFAT', 'D', 08, 00
                          fPadR (FieldByName('GER_VENFAT').AsString , 03) +                                           // FTG_VENFAT', 'C', 03, 00
                          fPadR (FieldByName('GER_CNDFAT').AsString , 38) +                                           // FTG_CNDFAT', 'C', 38, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VALFAT').AsFloat),',','.') , 12) + // FTG_VALFAT', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_BASSIM').AsFloat),',','.') , 12) + // FTG_BASSIM', 'N', 12, 02
                          fPadR (''                                 , 01);                                             // FTG_DIGCLA', 'C', 01, 00

                          If (fClienteConsumidor(FieldByName('CLI_NOMCLI').AsString, False, True)) Then
                          Begin

                            pPesquisaCadCliCon(qryCliCon, qryCliCon, FieldByName('GER_CGCCON').AsString);
                            If qryCliCon.IsEmpty Then
                            Begin
                              strTransacao := strTransacao +
                              fPadR (FieldByName('GER_NOMCON').AsString , 40) +                                           // FTG_NOMCON', 'C', 40, 00
                              fPadR (FieldByName('GER_ENDCON').AsString , 40) +                                           // FTG_ENDCON', 'C', 40, 00
                              fPadR (FieldByName('GER_BAICON').AsString , 18) +                                           // FTG_BAICON', 'C', 18, 00
                              fPadR (FieldByName('GER_CEPCON').AsString , 08) +                                           // FTG_CEPCON', 'C', 08, 00
                              fPadR (FieldByName('CID_NOMCID').AsString , 25) +                                           // FTG_CIDCON', 'C', 25, 00
                              fPadR (FieldByName('GER_ESTCON').AsString , 02) +                                           // FTG_ESTCON', 'C', 02, 00
                              fPadR (FieldByName('GER_TELCON').AsString , 11) +                                           // FTG_TELCON', 'C', 11, 00
                              fPadR (FieldByName('GER_CGCCPF').AsString , 01) +                                           // FTG_CGCCPF', 'N', 01, 00
                              fPadR (FieldByName('GER_CGCCON').AsString , 18) +                                           // FTG_CGCCON', 'C', 18, 00
                              fPadR (FieldByName('GER_IESCON').AsString , 18);                                            // FTG_IESCON', 'C', 18, 00
                            End
                            Else
                            Begin
                              strTransacao := strTransacao +
                              fPadR (qryCliCon.FieldByName('CON_NOMCON').AsString , 40) +                                 // FTG_NOMCON', 'C', 40, 00
                              fPadR (qryCliCon.FieldByName('CON_ENDERE').AsString , 40) +                                 // FTG_ENDCON', 'C', 40, 00
                              fPadR (qryCliCon.FieldByName('CON_BAIRRO').AsString , 18) +                                 // FTG_BAICON', 'C', 18, 00
                              fPadR (qryCliCon.FieldByName('CON_C_E_P_').AsString , 08) +                                 // FTG_CEPCON', 'C', 08, 00
                              fPadR (fRetNomCidade(qryCliCon.FieldByName('CON_CODCID').AsString) , 25) +                  // FTG_CIDCON', 'C', 25, 00
                              fPadR (fRetNomCidade(qryCliCon.FieldByName('CON_CODCID').AsString, 1) , 02) +               // FTG_ESTCON', 'C', 02, 00
                              fPadR (qryCliCon.FieldByName('CON_FONE01').AsString , 11) +                                 // FTG_TELCON', 'C', 11, 00
                              fPadR (qryCliCon.FieldByName('CON_CGCCPF').AsString , 01) +                                 // FTG_CGCCPF', 'N', 01, 00
                              fPadR (qryCliCon.FieldByName('CON_C_P_F_').AsString , 18) +                                 // FTG_CGCCON', 'C', 18, 00
                              fPadR (qryCliCon.FieldByName('CON_I_E_S_').AsString , 18);                                  // FTG_IESCON', 'C', 18, 00
                            End;

                          End

                          Else If ((SameText(FieldByName('GER_TIP_FC').AsString, 'F')) And (SameText(FieldByName('GER_ORIDOC').AsString, 'V'))) Then
                          Begin
                            strTransacao := strTransacao +
                            fPadR (FieldByName('FOR_NOMFOR').AsString, 40) +                                          // FTG_NOMCON', 'C', 40, 00
                            fPadR (FieldByName('FOR_ENDERE').AsString, 40) +                                          // FTG_ENDCON', 'C', 40, 00
                            fPadR (FieldByName('FOR_BAIRRO').AsString, 18) +                                          // FTG_BAICON', 'C', 18, 00
                            fPadR (FieldByName('FOR_C_E_P_').AsString, 08) +                                          // FTG_CEPCON', 'C', 08, 00
                            fPadR (FieldByName('FOR_NOMCID').AsString, 25) +                                          // FTG_CIDCON', 'C', 25, 00
                            fPadR (FieldByName('FOR_ESTADO').AsString, 02) +                                          // FTG_ESTCON', 'C', 02, 00
                            fPadR (FieldByName('FOR_FONE01').AsString, 11) +                                          // FTG_TELCON', 'C', 11, 00
                            fPadR (FieldByName('FOR_CGCCPF').AsString, 01) +                                          // FTG_CGCCPF', 'N', 01, 00
                            fPadR (FieldByName('FOR_C_G_C_').AsString, 18) +                                          // FTG_CGCCON', 'C', 18, 00
                            fPadR (FieldByName('FOR_I_E_S_').AsString, 18);                                           // FTG_IESCON', 'C', 18, 00
                          End

                          Else
                          Begin
                            strTransacao := strTransacao +
                            fPadR (''                                 , 40) +                                           // FTG_NOMCON', 'C', 40, 00
                            fPadR (''                                 , 40) +                                           // FTG_ENDCON', 'C', 40, 00
                            fPadR (''                                 , 18) +                                           // FTG_BAICON', 'C', 18, 00
                            fPadR (''                                 , 08) +                                           // FTG_CEPCON', 'C', 08, 00
                            fPadR (''                                 , 25) +                                           // FTG_CIDCON', 'C', 25, 00
                            fPadR (''                                 , 02) +                                           // FTG_ESTCON', 'C', 02, 00
                            fPadR (''                                 , 11) +                                           // FTG_TELCON', 'C', 11, 00
                            fPadR (''                                 , 01) +                                           // FTG_CGCCPF', 'N', 01, 00
                            fPadR (''                                 , 18) +                                           // FTG_CGCCON', 'C', 18, 00
                            fPadR (''                                 , 18);                                            // FTG_IESCON', 'C', 18, 00
                          End;

                          strTransacao := strTransacao +
                          fPadR (FieldByName('GER_MEN002').AsString , 50) +                                           // FTG_MENGE2', 'C', 50, 00
                          fPadR (FieldByName('GER_CODEMP').AsString , 03) +                                           // FTG_NUMLOJ', 'C', 03, 00
                          fPadR (FieldByName('GER_TOTMED').AsString , 12) +                                           // FTG_TOTMED', 'N', 12, 02
                          fPadR (''                                 , 03) +                                           // FTG_CODECF', 'C', 03, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTPRO').AsFloat),',','.') , 12) + // FTG_TOTPRO', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR01').AsFloat),',','.') , 12) + // FTG_VPAR01', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR02').AsFloat),',','.') , 12) + // FTG_VPAR02', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR03').AsFloat),',','.') , 12) + // FTG_VPAR03', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR04').AsFloat),',','.') , 12) + // FTG_VPAR04', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR05').AsFloat),',','.') , 12) + // FTG_VPAR05', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR06').AsFloat),',','.') , 12) + // FTG_VPAR06', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR07').AsFloat),',','.') , 12) + // FTG_VPAR07', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR08').AsFloat),',','.') , 12) + // FTG_VPAR08', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR09').AsFloat),',','.') , 12) + // FTG_VPAR09', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR10').AsFloat),',','.') , 12) + // FTG_VPAR10', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR11').AsFloat),',','.') , 12) + // FTG_VPAR11', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR12').AsFloat),',','.') , 12) + // FTG_VPAR12', 'N', 12, 02
                          fPadR (FieldByName('GER_SERIE_').AsString , 03) +                                           // FTG_SERIE_', 'C', 03, 00
                          fPadR (IIF((SameText(FieldByName('GER_TIP_FC').AsString, 'F')) And (SameText(FieldByName('GER_ORIDOC').AsString, 'V')),
                                 'XXXXXXXX', EmptyStr), 08);                                                           // FTG_CODCON', 'C', 08, 00

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************LB*}
          lstTexto.Add(strTransacao);

          Next;
        End;
      End;

    lstTexto.SaveToFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);

    End;

  Finally
    FreeAndNil(qryCliCon);
    FreeAndNil(qryMovGer);
    FreeAndNil(lstTexto);
  End;

end;

procedure TfrmExpAutSin.pGeraArqDelMovGer;
  Var
    strSQL      : String;
    strTransacao: String;
    strNomArq   : String;
    strDtaCad   : String;
    strDtaDel   : String;
    lstTexto    : TStringList;
    qryMovGer   : TUniQuery;
    qryCliCon   : TUniQuery;
begin
  Try
    qryMovGer := fCriaQuery;
    qryCliCon := fCriaQuery;

    strNomArq := 'DELFTG.TXT';

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  0.00 AS GER_TOTFRE, '; //Nao enviar o valor do frete
    strSQL := strSQL + '  G.GER_TOTPRO + G.GER_TOTFRE AS GER_TOTPRO, ';//O valor do frete estara dissolvido nos produtos
    strSQL := strSQL + '  G.*, ';
    strSQL := strSQL + '  F.*, ';
    strSQL := strSQL + '  CIDFOR.CID_NOMCID AS FOR_NOMCID, ';
    strSQL := strSQL + '  CIDFOR.CID_ESTADO AS FOR_ESTADO, ';
    strSQL := strSQL + '  CADCID.CID_NOMCID, ';
    strSQL := strSQL + '  CLI_NOMCLI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  DEL_MOVGER G ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CADCID.CID_CODCID = GER_CIDCON ';
    strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADFOR F ON FOR_CODFOR = GER_CODFOR ';
    strSQL := strSQL + '  LEFT JOIN CADCID AS CIDFOR ON CIDFOR.CID_CODCID = FOR_CODCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  (G.GER_CLAFIS > 5000 OR IFNULL(G.GER_ORIDOC, "") = "D" OR IFNULL(G.GER_ORIDOC, "") = "V") AND ';
    strSQL := strSQL + '  G.GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  DTADEL BETWEEN :DTAINI AND :DTAFIN ';

    If Not chkNF.Checked Then
    Begin
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "NF" ';
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "EL" ';
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "D1" ';      
    End;

    If Not chkIF.Checked Then
    Begin
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "IF" ';
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "IV" ';
    End;

    strSQL := strSQL + 'ORDER BY G.GER_TIP_FC ';

    With qryMovGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      Open;
    End;

    If Not qryMovGer.IsEmpty Then
    Begin
      lstTexto := TStringList.Create;

      {**************************}
      {* TRANSAÇÃO DO ARQUIVO   *}
      {***********************LB*}
      With qryMovGer Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          If fEmptyStr(FieldByName('GER_DTAENT').AsString) Then
            strDtaCad := ''
          Else
            strDtaCad  := FormatDateTime('yyyy',FieldByName('GER_DTAENT').AsDateTime) +
                          FormatDateTime('mm',FieldByName('GER_DTAENT').AsDateTime)   +
                          FormatDateTime('dd',FieldByName('GER_DTAENT').AsDateTime);

          If fEmptyStr(FieldByName('DTADEL').AsString) Then
            strDtaDel := ''
          Else
            strDtaDel := FormatDateTime('yyyy',FieldByName('DTADEL').AsDateTime) +
                         FormatDateTime('mm',FieldByName('DTADEL').AsDateTime)   +
                         FormatDateTime('dd',FieldByName('DTADEL').AsDateTime);

          strTransacao := fPadR (FieldByName('GER_NUMDOC').AsString , 06) +                                           // FTG_NUMDOC', 'C', 06, 00
                          fPadR (strDtaCad                          , 08) +                                           // FTG_DTAENT', 'D', 08, 00
                          fPadR (FieldByName('GER_ESPDOC').AsString , 02) +                                           // FTG_ESPDOC', 'C', 02, 00
                          fPadR (FieldByName('GER_CONPAG').AsString , 38) +                                           // FTG_CNDPAG', 'C', 38, 00  // VERIFICAR

                          fPadR (IIF((SameText(FieldByName('GER_TIP_FC').AsString, 'F')) And (SameText(FieldByName('GER_ORIDOC').AsString, 'V')),
                                 fGetClienteConsumidor, FieldByName('GER_CODCLI').AsString), 08) +                    // FTG_CODCLI', 'C', 08, 00

                          fPadR (FieldByName('GER_ESTADO').AsString , 02) +                                           // FTG_ESTADO', 'C', 02, 00
                          fPadR (''                                 , 03) +                                           // FTG_CODATI', 'C', 03, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VLRCON').AsFloat),',','.') , 12) + // FTG_VLCONT', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_DESESP').AsFloat),',','.') , 12) + // FTG_DESESP', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTPRO').AsFloat),',','.') , 12) + // FTG_VLPROD', 'N', 12, 02      // VERIFICAR
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_BASIPI').AsFloat),',','.') , 12) + // FTG_BASIPI', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTIPI').AsFloat),',','.') , 12) + // FTG_TOTIPI', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_BASICM').AsFloat),',','.') , 12) + // FTG_BASICM', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTICM').AsFloat),',','.') , 12) + // FTG_TOTICM', 'N', 12, 02
                          fPadR (FieldByName('GER_CLAFIS').AsString , 04) +                                           // FTG_CLAFIS', 'C', 04, 00
                          fPadR (''                                 , 03) +                                           // FTG_CODARE', 'C', 03, 00
                          fPadR ('0'                                 , 05) +                                           // FTG_PERARE', 'N', 05, 02
                          fPadR ('0'                                 , 12) +                                           // FTG_COMARE', 'N', 12, 02
                          fPadR (''                                 , 03) +                                           // FTG_CODREP', 'C', 03, 00  // DETALHADO
                          fPadR ('0'                                 , 05) +                                           // FTG_PERREP', 'N', 05, 02
                          fPadR ('0'                                 , 12) +                                           // FTG_COMREP', 'N', 12, 02
                          fPadR (FieldByName('GER_CODVEN').AsString , 03) +                                           // FTG_CODVEN', 'C', 03, 00
                          fPadR ('0'                                 , 05) +                                           // FTG_PERVEN', 'N', 05, 02
                          fPadR ('0'                                 , 12) +                                           // FTG_COMVEN', 'N', 12, 02
                          fPadR (''                                 , 08) +                                           // FTG_PROFIS', 'C', 08, 00
                          fPadR (''                                 , 06) +                                           // FTG_NUMORC', 'C', 06, 00
                          fPadR (FieldByName('GER_CODTRA').AsString , 05) +                                           // FTG_CODTRA', 'C', 05, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.000',FieldByName('GER_PESBRU').AsFloat),',','.') , 12) + // FTG_PESOBR', 'N', 12, 03
                          fPadR (AnsiReplaceStr(FormatFloat('0.000',FieldByName('GER_PESLIQ').AsFloat),',','.') , 12) + // FTG_PESOLQ', 'N', 12, 03
                          fPadR (AnsiReplaceStr(FormatFloat('0.000',FieldByName('GER_VOLUME').AsFloat),',','.') , 12) + // FTG_VOLUME', 'N', 12, 03
                          fPadR (FieldByName('GER_ESPECI').AsString , 10) +                                           // FTG_ESPECI', 'C', 10, 00
                          fPadR (FieldByName('GER_MARCA_').AsString , 10) +                                           // FTG_MARCA_', 'C', 10, 00
                          fPadR (FieldByName('GER_MEN001').AsString , 50) +                                           // FTG_MENSAG', 'C', 50, 00
                          fPadR (''                                 , 07) +                                           // FTG_DUPLIC', 'C', 07, 00
                          fPadR (''                                 , 05) +                                           // FTG_PORTAD', 'C', 05, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTRET').AsFloat),',','.') , 12) + // FTG_TOTRET', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_BASRET').AsFloat),',','.') , 12) + // FTG_BASRET', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTCUS').AsFloat),',','.') , 12) + // FTG_TOTCUS', 'N', 12, 02
                          fPadR (FieldByName('GER_TIPFRE').AsString , 01) +                                           // FTG_TIPFRE', 'C', 01, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTFRE').AsFloat),',','.') , 12) + // FTG_VALFRE', 'N', 12, 02
                          fPadR (FieldByName('GER_JAFATU').AsString , 01) +                                           // FTG_JAFATU', 'L', 01, 00
                          fPadR (FieldByName('GER_TIPFAT').AsString , 02) +                                           // FTG_TIPFAT', 'C', 02, 00
                          fPadR (FieldByName('GER_NUMFAT').AsString , 06) +                                           // FTG_NUMFAT', 'C', 06, 00
                          fPadR (FieldByName('GER_DTAFAT').AsString , 08) +                                           // FTG_DTAFAT', 'D', 08, 00
                          fPadR (FieldByName('GER_VENFAT').AsString , 03) +                                           // FTG_VENFAT', 'C', 03, 00
                          fPadR (FieldByName('GER_CNDFAT').AsString , 38) +                                           // FTG_CNDFAT', 'C', 38, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VALFAT').AsFloat),',','.') , 12) + // FTG_VALFAT', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_BASSIM').AsFloat),',','.') , 12) + // FTG_BASSIM', 'N', 12, 02
                          fPadR (''                                 , 01);                                             // FTG_DIGCLA', 'C', 01, 00

                          If (fClienteConsumidor(FieldByName('CLI_NOMCLI').AsString, False, True)) Then
                          Begin

                            pPesquisaCadCliCon(qryCliCon, qryCliCon, FieldByName('GER_CGCCON').AsString);
                            If qryCliCon.IsEmpty Then
                            Begin
                              strTransacao := strTransacao +
                              fPadR (FieldByName('GER_NOMCON').AsString , 40) +                                           // FTG_NOMCON', 'C', 40, 00
                              fPadR (FieldByName('GER_ENDCON').AsString , 40) +                                           // FTG_ENDCON', 'C', 40, 00
                              fPadR (FieldByName('GER_BAICON').AsString , 18) +                                           // FTG_BAICON', 'C', 18, 00
                              fPadR (FieldByName('GER_CEPCON').AsString , 08) +                                           // FTG_CEPCON', 'C', 08, 00
                              fPadR (FieldByName('CID_NOMCID').AsString , 25) +                                           // FTG_CIDCON', 'C', 25, 00
                              fPadR (FieldByName('GER_ESTCON').AsString , 02) +                                           // FTG_ESTCON', 'C', 02, 00
                              fPadR (FieldByName('GER_TELCON').AsString , 11) +                                           // FTG_TELCON', 'C', 11, 00
                              fPadR (FieldByName('GER_CGCCPF').AsString , 01) +                                           // FTG_CGCCPF', 'N', 01, 00
                              fPadR (FieldByName('GER_CGCCON').AsString , 18) +                                           // FTG_CGCCON', 'C', 18, 00
                              fPadR (FieldByName('GER_IESCON').AsString , 18);                                            // FTG_IESCON', 'C', 18, 00
                            End
                            Else
                            Begin
                              strTransacao := strTransacao +
                              fPadR (qryCliCon.FieldByName('CON_NOMCON').AsString , 40) +                                 // FTG_NOMCON', 'C', 40, 00
                              fPadR (qryCliCon.FieldByName('CON_ENDERE').AsString , 40) +                                 // FTG_ENDCON', 'C', 40, 00
                              fPadR (qryCliCon.FieldByName('CON_BAIRRO').AsString , 18) +                                 // FTG_BAICON', 'C', 18, 00
                              fPadR (qryCliCon.FieldByName('CON_C_E_P_').AsString , 08) +                                 // FTG_CEPCON', 'C', 08, 00
                              fPadR (fRetNomCidade(qryCliCon.FieldByName('CON_CODCID').AsString) , 25) +                  // FTG_CIDCON', 'C', 25, 00
                              fPadR (fRetNomCidade(qryCliCon.FieldByName('CON_CODCID').AsString, 1) , 02) +               // FTG_ESTCON', 'C', 02, 00
                              fPadR (qryCliCon.FieldByName('CON_FONE01').AsString , 11) +                                 // FTG_TELCON', 'C', 11, 00
                              fPadR (qryCliCon.FieldByName('CON_CGCCPF').AsString , 01) +                                 // FTG_CGCCPF', 'N', 01, 00
                              fPadR (qryCliCon.FieldByName('CON_C_P_F_').AsString , 18) +                                 // FTG_CGCCON', 'C', 18, 00
                              fPadR (qryCliCon.FieldByName('CON_I_E_S_').AsString , 18);                                  // FTG_IESCON', 'C', 18, 00
                            End;

                          End

                          Else If ((SameText(FieldByName('GER_TIP_FC').AsString, 'F')) And (SameText(FieldByName('GER_ORIDOC').AsString, 'V'))) Then
                          Begin
                            strTransacao := strTransacao +
                            fPadR (FieldByName('FOR_NOMFOR').AsString, 40) +                                          // FTG_NOMCON', 'C', 40, 00
                            fPadR (FieldByName('FOR_ENDERE').AsString, 40) +                                          // FTG_ENDCON', 'C', 40, 00
                            fPadR (FieldByName('FOR_BAIRRO').AsString, 18) +                                          // FTG_BAICON', 'C', 18, 00
                            fPadR (FieldByName('FOR_C_E_P_').AsString, 08) +                                          // FTG_CEPCON', 'C', 08, 00
                            fPadR (FieldByName('FOR_NOMCID').AsString, 25) +                                          // FTG_CIDCON', 'C', 25, 00
                            fPadR (FieldByName('FOR_ESTADO').AsString, 02) +                                          // FTG_ESTCON', 'C', 02, 00
                            fPadR (FieldByName('FOR_FONE01').AsString, 11) +                                          // FTG_TELCON', 'C', 11, 00
                            fPadR (FieldByName('FOR_CGCCPF').AsString, 01) +                                          // FTG_CGCCPF', 'N', 01, 00
                            fPadR (FieldByName('FOR_C_G_C_').AsString, 18) +                                          // FTG_CGCCON', 'C', 18, 00
                            fPadR (FieldByName('FOR_I_E_S_').AsString, 18);                                           // FTG_IESCON', 'C', 18, 00
                          End

                          Else
                          Begin
                            strTransacao := strTransacao +
                            fPadR (''                                 , 40) +                                           // FTG_NOMCON', 'C', 40, 00
                            fPadR (''                                 , 40) +                                           // FTG_ENDCON', 'C', 40, 00
                            fPadR (''                                 , 18) +                                           // FTG_BAICON', 'C', 18, 00
                            fPadR (''                                 , 08) +                                           // FTG_CEPCON', 'C', 08, 00
                            fPadR (''                                 , 25) +                                           // FTG_CIDCON', 'C', 25, 00
                            fPadR (''                                 , 02) +                                           // FTG_ESTCON', 'C', 02, 00
                            fPadR (''                                 , 11) +                                           // FTG_TELCON', 'C', 11, 00
                            fPadR (''                                 , 01) +                                           // FTG_CGCCPF', 'N', 01, 00
                            fPadR (''                                 , 18) +                                           // FTG_CGCCON', 'C', 18, 00
                            fPadR (''                                 , 18);                                            // FTG_IESCON', 'C', 18, 00
                          End;

                          strTransacao := strTransacao +
                          fPadR (FieldByName('GER_MEN002').AsString , 50) +                                            // FTG_MENGE2', 'C', 50, 00
                          fPadR (FieldByName('GER_CODEMP').AsString , 03) +                                            // FTG_NUMLOJ', 'C', 03, 00
                          fPadR (FieldByName('GER_TOTMED').AsString , 12) +                                            // FTG_TOTMED', 'N', 12, 02
                          fPadR (''                                 , 03) +                                            // FTG_CODECF', 'C', 03, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTPRO').AsFloat),',','.') , 12) + // FTG_TOTPRO', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR01').AsFloat),',','.') , 12) + // FTG_VPAR01', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR02').AsFloat),',','.') , 12) + // FTG_VPAR02', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR03').AsFloat),',','.') , 12) + // FTG_VPAR03', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR04').AsFloat),',','.') , 12) + // FTG_VPAR04', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR05').AsFloat),',','.') , 12) + // FTG_VPAR05', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR06').AsFloat),',','.') , 12) + // FTG_VPAR06', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR07').AsFloat),',','.') , 12) + // FTG_VPAR07', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR08').AsFloat),',','.') , 12) + // FTG_VPAR08', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR09').AsFloat),',','.') , 12) + // FTG_VPAR09', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR10').AsFloat),',','.') , 12) + // FTG_VPAR10', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR11').AsFloat),',','.') , 12) + // FTG_VPAR11', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR12').AsFloat),',','.') , 12) + // FTG_VPAR12', 'N', 12, 02
                          fPadR (FieldByName('GER_SERIE_').AsString , 03) +                                            // FTG_SERIE_', 'C', 03, 00
                          fPadR (IIF((SameText(FieldByName('GER_TIP_FC').AsString, 'F')) And (SameText(FieldByName('GER_ORIDOC').AsString, 'V')),
                                 'XXXXXXXX', EmptyStr), 08) +                                                          // FTG_CODCON', 'C', 08, 00
                          fPadR (strDtaDel                                                                     , 08);  //     DTADEL', 'D', 08, 00

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************LB*}
          lstTexto.Add(strTransacao);

          Next;
        End;
      End;

    lstTexto.SaveToFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);

    End;

  Finally
    FreeAndNil(qryCliCon);
    FreeAndNil(qryMovGer);
    FreeAndNil(lstTexto);
  End;

end;

procedure TfrmExpAutSin.pGeraArqMovDet(strTipMov: String);
  Var
    strSQL      : String;
    strTransacao: String;
    strNomArq   : String;
    strDtaCad   : String;
    strDtaDoc   : String;
    fltUnitar   : Double;
    fltTotIte   : Double;
    lstTexto    : TStringList;
    qryMovDet: TUniQuery;

begin
  Try
    qryMovDet := fCriaQuery(nil);

    strNomArq := 'FATDET.TXT';

    If strTipMov = 'N' Then
      strNomArq := 'CADMOV.TXT';


    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  0.00 AS DET_TOTFRE, '; //Nao enviar o valor do frete
    strSQL := strSQL + '  D.DET_TOTITE + D.DET_TOTFRE AS DET_TOTITE, ';//O valor do frete estara dissolvido nos produtos
    strSQL := strSQL + '  D.* ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET D ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + ' (LOCATE(D.DET_ESPDOC, "TM_ML_PR_") <= 0) AND   ';
    strSQL := strSQL + '  D.DET_CODEMP = :CODEMP AND ';
    strSQL := strSQL + ' (D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN) AND ';
    strSQL := strSQL + '  D.DET_CODITE <> :ITESER AND                   ';
    strSQL := strSQL + '  D.DET_CODITE <> :SERTER AND                   ';
    strSQL := strSQL + '  D.DET_QTDITE > 0 AND                          ';
    strSQL := strSQL + ' IFNULL(D.DET_PROEMB,"") <> "S" ';

    If strTipMov = 'N' Then
    Begin
      strSQL := strSQL + '  AND D.DET_CLAFIS < 5000  ';
      strSQL := strSQL + '  AND IFNULL(D.DET_ORIDOC, "") <> "V" AND IFNULL(D.DET_ORIDOC, "") <> "D" ';
    End
    Else
      strSQL := strSQL + '  AND (D.DET_CLAFIS >= 5000 OR IFNULL(D.DET_ORIDOC, "") = "D" OR IFNULL(D.DET_ORIDOC, "") = "V")';

    If Not chkNF.Checked Then
    Begin
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "NF" ';
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "EL" ';
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "D1" ';
    End;

    If Not chkIF.Checked Then
    Begin
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "IF" ';
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "IV" ';
    End;

    strSQL := strSQL + 'ORDER BY D.DET_TIP_FC ';

    With qryMovDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('ITESER').AsString := fCfgSis('ITESER');
      ParamByName('SERTER').AsString := fCfgSis('SERTER');
      Open;
    End;

    If Not qryMovDet.IsEmpty Then
    Begin
      lstTexto := TStringList.Create;

      {**************************}
      {* TRANSAÇÃO DO ARQUIVO   *}
      {***********************LB*}
      With qryMovDet Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          If FieldByName('DET_QTDITE').AsFloat > 0 Then
          Begin

            If fEmptyStr(FieldByName('DET_DTAENT').AsString) Then
              strDtaCad := ''
            Else
              strDtaCad  := FormatDateTime('yyyy',FieldByName('DET_DTAENT').AsDateTime) +
                            FormatDateTime('mm',FieldByName('DET_DTAENT').AsDateTime)   +
                            FormatDateTime('dd',FieldByName('DET_DTAENT').AsDateTime);

            If fEmptyStr(FieldByName('DET_DTAENT').AsString) Then
              strDtaDoc := ''
            Else
              strDtaDoc  := FormatDateTime('yyyy',FieldByName('DET_DTADOC').AsDateTime) +
                            FormatDateTime('mm',FieldByName('DET_DTADOC').AsDateTime)   +
                            FormatDateTime('dd',FieldByName('DET_DTADOC').AsDateTime);


            {*******************************************}
            {* CADMOV - MOVIMENTOS DE ENTRADA          *}
            {****************************************MV*}
            If (strTipMov = 'N') Then
            Begin

              fltUnitar := (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat) / FieldByName('DET_QTDITE').AsFloat;
              fltTotIte := (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat);            

              strTransacao := fPadR (FieldByName('DET_NUMDOC').AsString , 06) +                                             //MOV_NUMDOC', 'C',  06, 00 (01)
                              fPadR (strDtaCad                          , 08) +                                             //MOV_DTAENT', 'D',  08, 00 (02)
                              fPadR (strDtaDoc                          , 08) +                                             //MOV_DTADOC', 'D',  08, 00 (03)
                              fPadR (FieldByName('DET_ESPDOC').AsString , 02) +                                             //MOV_ESPDOC', 'C',  02, 00 (04)
                              fPadR (FieldByName('DET_CODITE').AsString , 14) +                                             //MOV_CODITE', 'C',  14, 00 (05)
                              fPadR (AnsiReplaceStr(FormatFloat('0.0000',fltUnitar),',','.')  , 12)                       + //MOV_UNITAR', 'N',  12, 02 (06)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00', fltTotIte),',','.')  , 12)                        + //MOV_TOTITE', 'N',  12, 02 (07)
                              fPadR (FieldByName('DET_CODVEN').AsString , 03) +                                             //MOV_CODVEN', 'C',  03, 00 (08)
                              fPadR (FieldByName('DET_CODFOR').AsString , 08) +                                             //MOV_CODFOR', 'C',  08, 00 (09)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_QTDITE').AsFloat),',','.')  , 12) + //MOV_QTDITE', 'N',  12, 03 (10)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTCUS').AsFloat),',','.')  , 12) + //MOV_TOTCUS', 'N',  12, 02 (11)
                              'E'                                             +                                             //MOV_TIPMOV   'C',  01     (12)
                              fPadR (FieldByName('DET_CLAFIS').AsString , 04) +                                             //MOV_CLAFIS', 'C',  04, 00 (13)
                              fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_ALQIPI').AsFloat),',','.'), 06), 06) + //MOV_PERIPI', 'N',  06, 02 (14)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALIPI').AsFloat),',','.')  , 12) + //MOV_VALIPI', 'N',  12, 02 (15)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALRET').AsFloat),',','.')  , 12) + //MOV_TOTSUB', 'N',  12, 02 (16)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTFRE').AsFloat),',','.')  , 12) + //MOV_TOTFRE', 'N',  12, 02 (17)
                              fPadR (FieldByName('DET_CODEMP').AsString , 03) +                                             //MOV_NUMLOJ', 'C',  03, 00 (18)
                              fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_ALQICM').AsFloat),',','.'), 06), 06) + //MOV_ALQICM', 'N',  06, 02 (19)
                              fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PERBAS').AsFloat),',','.'), 06), 06) + //MOV_PERBAS', 'N',  06, 02 (20)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASICM').AsFloat),',','.')  , 12) + //MOV_BASICM', 'N',  12, 02 (21)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALICM').AsFloat),',','.')  , 12) + //MOV_VALICM', 'N',  12, 02 (22)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASRET').AsFloat),',','.')  , 12) + //MOV_BASRET', 'N',  12, 02 (23)
                              fPadR (FieldByName('DET_CODFIS').AsString , 03) +                                             //MOV_CODFIS', 'C',  03, 00 (24)
                              fPadR (FieldByName('DET_DESCRI').AsString , 57) +                                             //MOV_DESCRI', 'C',  57, 00 (25)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASIPI').AsFloat),',','.')  , 12) + //MOV_BASIPI', 'N',  12, 02 (26)
                              fPadR (FieldByName('DET_SERIE_').AsString , 03) +                                             //MOV_SERIE_', 'C',  03, 00 (27)
                              fPadR (''                                 , 08);                                              //MOV_CODCON', 'C',  08, 00 (28)

            End
            Else
            Begin
            
              fltUnitar := (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat) / FieldByName('DET_QTDITE').AsFloat;
              fltTotIte := (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat);

              {*******************************************}
              {* FATDET - SAIDAS                         *}
              {****************************************MV*}
              strTransacao := fPadR (FieldByName('DET_NUMDOC').AsString , 06) +                                            //FTD_NUMDOC', 'C',  06, 00 (01)
                              fPadR (strDtaCad                          , 08) +                                            //FTD_DTAENT', 'D',  08, 00 (02)
                              fPadR (FieldByName('DET_ESPDOC').AsString , 02) +                                            //FTD_ESPDOC', 'C',  02, 00 (03)
                              fPadR (FieldByName('DET_CONPAG').AsString , 38) +                                            //FTD_CNDPAG', 'C',  38, 00 (04)

                              fPadR (IIF((SameText(FieldByName('DET_TIP_FC').AsString, 'F')) And (SameText(FieldByName('DET_ORIDOC').AsString, 'V')),
                                     fGetClienteConsumidor, FieldByName('DET_CODCLI').AsString), 08) +                     //FTD_CODCLI', 'C',  08, 00 (05)

                              fPadR (''                                 , 03) +                                            //FTD_CODATI', 'C',  03, 00 (06)
                              fPadR (FieldByName('DET_ESTADO').AsString , 02) +                                            //FTD_ESTADO', 'C',  02, 00 (07)
                              fPadR (FieldByName('DET_CODITE').AsString , 14) +                                            //FTD_CODITE', 'C',  14, 00 (08)
                              fPadR (FieldByName('DET_DESCRI').AsString , 57) +                                            //FTD_DESCRI', 'C',  57, 00 (09)
                              fPadR (FieldByName('DET_UNIDAD').AsString , 02) +                                            //FTD_UNIDAD', 'C',  02, 00 (10)
                              fPadR (FieldByName('DET_CODMAR').AsString , 03) +                                            //FTD_CODMAR', 'C',  03, 00 (11)
                              fPadR (FieldByName('DET_FORITE').AsString , 08) +                                            //FTD_CODFOR', 'C',  08, 00 (12)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_QTDITE').AsFloat),',','.') , 12) + //FTD_QTDITE', 'N',  12, 03 (13)
                              fPadR (AnsiReplaceStr(FormatFloat('0.0000',fltUnitar),',','.')  , 12)                      + //MOV_UNITAR', 'N',  12, 02 (06)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00', fltTotIte),',','.') , 12)                        + //FTD_TOTITE', 'N',  12, 02 (15)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTCUS').AsFloat),',','.') , 12) + //FTD_TOTCUS', 'N',  12, 02 (16) )
                              fPadR (''                                 , 03) +                                            //FTD_CODARE', 'C',  03, 00 (17)
                              fPadR (FieldByName('DET_CODREP').AsString , 03) +                                            //FTD_CODREP', 'C',  03, 00 (18)
                              fPadR (FieldByName('DET_CODVEN').AsString , 03) +                                            //FTD_CODVEN', 'C',  03, 00 (19)
                              fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PERCOM').AsFloat),',','.'), 05) , 05) + //FTD_PERCOM', 'N',  05, 02 (20)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTCOM').AsFloat),',','.') , 12) + //FTD_TOTCOM', 'N',  12, 02 (21)
                              fPadR (FieldByName('DET_CLAFIS').AsString , 04) +                                            //FTD_CLAFIS', 'C',  04, 00 (22)
                              fPadR (FieldByName('DET_CODFIS').AsString , 03) +                                            //FTD_CODFIS', 'C',  03, 00 (23)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALIPI').AsFloat),',','.') , 12) + //FTD_VALIPI', 'N',  12, 02 (24)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASIPI').AsFloat),',','.') , 12) + //FTD_BASIPI', 'N',  12, 02 (25)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALICM').AsFloat),',','.') , 12) + //FTD_VALICM', 'N',  12, 02 (26)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASICM').AsFloat),',','.') , 12) + //FTD_BASICM', 'N',  12, 02 (27)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALRET').AsFloat),',','.') , 12) + //FTD_VALRET', 'N',  12, 02 (28)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASRET').AsFloat),',','.') , 12) + //FTD_BASRET', 'N',  12, 02 (29)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VLRCON').AsFloat),',','.') , 12) + //FTD_VALBRU', 'N',  12, 02 (30)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTPES').AsFloat),',','.') , 12) + //FTD_TOTPES', 'N',  12, 02 (31)
                              fPadR (''                                 , 05) +                                            //FTD_NUMLOT', 'C',  05, 00 (32)
                              fPadR (FieldByName('DET_CODDIV').AsString , 08) +                                            //FTD_PROFIS', 'C',  08, 00 (33)
                              fPadR (''                                 , 06) +                                            //FTD_NUMORC', 'C',  06, 00 (34)
                              fPadR (FieldByName('DET_JAFATU').AsString , 01) +                                            //FTD_JAFATU', 'L',  01, 00 (35)
                              fPadR (FieldByName('DET_TIPFAT').AsString , 02) +                                            //FTD_TIPFAT', 'C',  02, 00 (36)
                              fPadR (FieldByName('DET_NUMFAT').AsString , 06) +                                            //FTD_NUMFAT', 'C',  06, 00 (37)
                              fPadR (FieldByName('DET_DTAFAT').AsString , 08) +                                            //FTD_DTAFAT', 'D',  08, 00 (38)
                              fPadR (FieldByName('DET_VENFAT').AsString , 03) +                                            //FTD_VENFAT', 'C',  03, 00 (39)
                              fPadR (FieldByName('DET_CNDFAT').AsString , 38) +                                            //FTD_CNDFAT', 'C',  38, 00 (40)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALFAT').AsFloat),',','.') , 12) + //FTD_VALFAT', 'N',  12, 02 (41)
                              fPadR ('0.00'                             , 12) +                                            //FTD_DESESP', 'N',  12, 02 (42)
                              fPadR (''                                 , 01) +                                            //FTD_DIGCLA', 'C',  01, 00 (43)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_UNIORI').AsFloat),',','.') , 12) + //FTD_UNIANT', 'N',  12, 02 (44)
                              fPadR (FieldByName('DET_CODEMP').AsString , 03) +                                            //FTD_NUMLOJ', 'C',  03, 00 (45)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTMED').AsFloat),',','.') , 12) + //FTD_TOTMED', 'N',  12, 02 (46)
                              fPadR (''                                 , 03) +                                            //FTD_CODECF', 'C',  03, 00 (47)
                              fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_ALQICM').AsFloat),',','.'), 06), 06) + //FTD_ALQICM', 'N',  06, 02 (48)
                              fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_ALQIPI').AsFloat),',','.'), 06), 06) + //FTD_ALQIPI', 'N',  06, 02 (49)
                              fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PERBAS').AsFloat),',','.'), 06), 06) + //FTD_PERBAS', 'N',  06, 02 (50)
                              fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PERRED').AsFloat),',','.'), 06), 06) + //FTD_PERRED', 'N',  06, 02 (51)
                              fPadR (FieldByName('DET_IDEPRO').AsString , 03) +                                            //FTD_IDEPRO', 'C',  03, 00 (52)
                              fPadR (FieldByName('DET_ITETIN').AsString , 18) +                                            //FTD_ITETIN', 'C',  18, 00 (53)
                              fPadR (FieldByName('DET_ITECHA').AsString , 08) +                                            //FTD_ITECHA', 'C',  08, 00 (54)
                              fPadR (FieldByName('DET_DESCOR').AsString , 15) +                                            //FTD_DESCOR', 'C',  15, 00 (55)
                              fPadR (FieldByName('DET_TIPEMB').AsString , 02) +                                            //FTD_TIPEMB', 'C',  02, 00 (56)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_QTDEMB').AsFloat),',','.') , 12) + //FTD_QTDEMB', 'N',  12, 02 (57)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PREEMB').AsFloat),',','.') , 12) + //FTD_PREEMB', 'N',  12, 02 (58)
                              fPadR (FieldByName('DET_TIPPRE').AsString , 01) +                                            //FTD_TIPPRE', 'C',  01, 00 (59)
                              fPadR (FieldByName('DET_PRVTIN').AsString , 50) +                                            //FTD_CAMLVE', 'C',  50, 00 (60)
                              fPadR (FieldByName('DET_PRCTIN').AsString , 50) +                                            //FTD_CAMLCU', 'C',  50, 00 (61)
                              fPadR (''                                 , 01) +                                            //FTD_INCPIS', 'C',  01, 00 (62)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_DESCON').AsFloat),',','.') , 12) + //FTD_DESCON', 'N',  12, 02 (63)
                              fPadR (FieldByName('DET_PROEMB').AsString , 01) +                                            //FTD_PROEMB', 'L',  01, 00 (64)
                              fPadR (FieldByName('DET_SERIE_').AsString , 03) +                                            //FTD_SERIE_', 'C',  03, 00 (65)
                              fPadR (IIF((SameText(FieldByName('DET_TIP_FC').AsString, 'F')) And (SameText(FieldByName('DET_ORIDOC').AsString, 'V')),
                                     'XXXXXXXX', EmptyStr), 08);                                                            //FTD_CODCON', 'C',  08, 00 (66)
              End;


            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************LB*}
            lstTexto.Add(strTransacao);

          End;

          Next;
        End;
      End;

    lstTexto.SaveToFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);

    End;

  Finally
    FreeAndNil(qryMovDet);
    FreeAndNil(lstTexto);
  End;

end;

procedure TfrmExpAutSin.pGeraArqDelMovDet(strTipMov: String);
  Var
    strSQL      : String;
    strTransacao: String;
    strNomArq   : String;
    strDtaCad   : String;
    strDtaDoc   : String;
    strDtaDel   : String;
    fltUnitar   : Double;
    fltTotIte   : Double;
    lstTexto    : TStringList;
    qryMovDet: TUniQuery;

begin
  Try
    qryMovDet := fCriaQuery(nil);

    strNomArq := 'DELFTD.TXT';

    If strTipMov = 'N' Then
      strNomArq := 'DELMOV.TXT';


    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  0.00 AS DET_TOTFRE, '; //Nao enviar o valor do frete
    strSQL := strSQL + '  D.DET_TOTITE + D.DET_TOTFRE AS DET_TOTITE, ';//O valor do frete estara dissolvido nos produtos
    strSQL := strSQL + '  D.* ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  DEL_MOVDET D ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + ' (LOCATE(D.DET_ESPDOC, "TM_ML_PR_") <= 0) AND   ';
    strSQL := strSQL + '  D.DET_CODEMP = :CODEMP AND ';
    strSQL := strSQL + ' (D.DTADEL BETWEEN :DTAINI AND :DTAFIN) AND ';
    strSQL := strSQL + '  D.DET_CODITE <> :ITESER AND                   ';
    strSQL := strSQL + '  D.DET_CODITE <> :SERTER AND                   ';
    strSQL := strSQL + '  D.DET_QTDITE > 0 AND                          ';
    strSQL := strSQL + '  IFNULL(D.DET_PROEMB, "") <> "S" ';

    If strTipMov = 'N' Then
    Begin
      strSQL := strSQL + '  AND D.DET_CLAFIS < 5000  ';
      strSQL := strSQL + '  AND IFNULL(D.DET_ORIDOC, "") <> "V" AND IFNULL(D.DET_ORIDOC, "") <> "D" ';
    End
    Else
      strSQL := strSQL + '  AND (D.DET_CLAFIS >= 5000 OR IFNULL(D.DET_ORIDOC, "") = "D" OR IFNULL(D.DET_ORIDOC, "") = "V") ';

    If Not chkNF.Checked Then
    Begin
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "NF" ';
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "EL" ';
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "D1" ';      
    End;

    If Not chkIF.Checked Then
    Begin
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "IF" ';
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "IV" ';
    End;

    strSQL := strSQL + 'ORDER BY D.DET_TIP_FC ';

    With qryMovDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('ITESER').AsString := fCfgSis('ITESER');
      ParamByName('SERTER').AsString := fCfgSis('SERTER');
      Open;
    End;

    If Not qryMovDet.IsEmpty Then
    Begin
      lstTexto := TStringList.Create;

      {**************************}
      {* TRANSAÇÃO DO ARQUIVO   *}
      {***********************LB*}
      With qryMovDet Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          If FieldByName('DET_QTDITE').AsFloat > 0 Then
          Begin

            If fEmptyStr(FieldByName('DET_DTAENT').AsString) Then
              strDtaCad := ''
            Else
              strDtaCad  := FormatDateTime('yyyy',FieldByName('DET_DTAENT').AsDateTime) +
                            FormatDateTime('mm',FieldByName('DET_DTAENT').AsDateTime)   +
                            FormatDateTime('dd',FieldByName('DET_DTAENT').AsDateTime);

            If fEmptyStr(FieldByName('DET_DTAENT').AsString) Then
              strDtaDoc := ''
            Else
              strDtaDoc  := FormatDateTime('yyyy',FieldByName('DET_DTADOC').AsDateTime) +
                            FormatDateTime('mm',FieldByName('DET_DTADOC').AsDateTime)   +
                            FormatDateTime('dd',FieldByName('DET_DTADOC').AsDateTime);

            If fEmptyStr(FieldByName('DTADEL').AsString) Then
              strDtaDel := ''
            Else
              strDtaDel := FormatDateTime('yyyy',FieldByName('DTADEL').AsDateTime) +
                           FormatDateTime('mm',FieldByName('DTADEL').AsDateTime)   +
                           FormatDateTime('dd',FieldByName('DTADEL').AsDateTime);

            {*******************************************}
            {* CADMOV - MOVIMENTOS DE ENTRADA          *}
            {****************************************MV*}
            If (strTipMov = 'N') Then
            Begin

              fltUnitar := (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat) / FieldByName('DET_QTDITE').AsFloat;
              fltTotIte := (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat);
                          
              strTransacao := fPadR (FieldByName('DET_NUMDOC').AsString , 06) +                                             //MOV_NUMDOC', 'C',  06, 00 (01)
                              fPadR (strDtaCad                          , 08) +                                             //MOV_DTAENT', 'D',  08, 00 (02)
                              fPadR (strDtaDoc                          , 08) +                                             //MOV_DTADOC', 'D',  08, 00 (03)
                              fPadR (FieldByName('DET_ESPDOC').AsString , 02) +                                             //MOV_ESPDOC', 'C',  02, 00 (04)
                              fPadR (FieldByName('DET_CODITE').AsString , 14) +                                             //MOV_CODITE', 'C',  14, 00 (05)
                              fPadR (AnsiReplaceStr(FormatFloat('0.0000',fltUnitar),',','.')  , 12)                       + //MOV_UNITAR', 'N',  12, 02 (06)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00', fltTotIte),',','.')  , 12)                        + //MOV_TOTITE', 'N',  12, 02 (07)
                              fPadR (FieldByName('DET_CODVEN').AsString , 03) +                                             //MOV_CODVEN', 'C',  03, 00 (08)
                              fPadR (FieldByName('DET_CODFOR').AsString , 08) +                                             //MOV_CODFOR', 'C',  08, 00 (09)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_QTDITE').AsFloat),',','.')  , 12) + //MOV_QTDITE', 'N',  12, 03 (10)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTCUS').AsFloat),',','.')  , 12) + //MOV_TOTCUS', 'N',  12, 02 (11)
                              'E'                                             +                                             //MOV_TIPMOV   'C',  01     (12)
                              fPadR (FieldByName('DET_CLAFIS').AsString , 04) +                                             //MOV_CLAFIS', 'C',  04, 00 (13)
                              fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_ALQIPI').AsFloat),',','.'), 06), 06) + //MOV_PERIPI', 'N',  06, 02 (14)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALIPI').AsFloat),',','.')  , 12) + //MOV_VALIPI', 'N',  12, 02 (15)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALRET').AsFloat),',','.')  , 12) + //MOV_TOTSUB', 'N',  12, 02 (16)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTFRE').AsFloat),',','.')  , 12) + //MOV_TOTFRE', 'N',  12, 02 (17)
                              fPadR (FieldByName('DET_CODEMP').AsString , 03) +                                             //MOV_NUMLOJ', 'C',  03, 00 (18)
                              fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_ALQICM').AsFloat),',','.'), 06), 06) + //MOV_ALQICM', 'N',  06, 02 (19)
                              fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PERBAS').AsFloat),',','.'), 06), 06) + //MOV_PERBAS', 'N',  06, 02 (20)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASICM').AsFloat),',','.')  , 12) + //MOV_BASICM', 'N',  12, 02 (21)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALICM').AsFloat),',','.')  , 12) + //MOV_VALICM', 'N',  12, 02 (22)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASRET').AsFloat),',','.')  , 12) + //MOV_BASRET', 'N',  12, 02 (23)
                              fPadR (FieldByName('DET_CODFIS').AsString , 03) +                                             //MOV_CODFIS', 'C',  03, 00 (24)
                              fPadR (FieldByName('DET_DESCRI').AsString , 57) +                                             //MOV_DESCRI', 'C',  57, 00 (25)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASIPI').AsFloat),',','.')  , 12) + //MOV_BASIPI', 'N',  12, 02 (26)
                              fPadR (FieldByName('DET_SERIE_').AsString , 03) +                                             //MOV_SERIE_', 'C',  03, 00 (27)
                              fPadR (''                                 , 08) +                                             //MOV_CODCON', 'C',  08, 00 (28)
                              fPadR (strDtaDel                          , 08);                                              //    DTADEL', 'D',  08, 00 (29)

            End
            Else
            Begin

              fltUnitar := (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat) / FieldByName('DET_QTDITE').AsFloat;
              fltTotIte := (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat);

              {*******************************************}
              {* FATDET - SAIDAS                         *}
              {****************************************MV*}
              strTransacao := fPadR (FieldByName('DET_NUMDOC').AsString , 06) +                                            //FTD_NUMDOC', 'C',  06, 00 (01)
                              fPadR (strDtaCad                          , 08) +                                            //FTD_DTAENT', 'D',  08, 00 (02)
                              fPadR (FieldByName('DET_ESPDOC').AsString , 02) +                                            //FTD_ESPDOC', 'C',  02, 00 (03)
                              fPadR (FieldByName('DET_CONPAG').AsString , 38) +                                            //FTD_CNDPAG', 'C',  38, 00 (04)

                              fPadR (IIF((SameText(FieldByName('DET_TIP_FC').AsString, 'F')) And (SameText(FieldByName('DET_ORIDOC').AsString, 'V')),
                                     fGetClienteConsumidor, FieldByName('DET_CODCLI').AsString), 08) +                     //FTD_CODCLI', 'C',  08, 00 (05)

                              fPadR (''                                 , 03) +                                            //FTD_CODATI', 'C',  03, 00 (06)
                              fPadR (FieldByName('DET_ESTADO').AsString , 02) +                                            //FTD_ESTADO', 'C',  02, 00 (07)
                              fPadR (FieldByName('DET_CODITE').AsString , 14) +                                            //FTD_CODITE', 'C',  14, 00 (08)
                              fPadR (FieldByName('DET_DESCRI').AsString , 57) +                                            //FTD_DESCRI', 'C',  57, 00 (09)
                              fPadR (FieldByName('DET_UNIDAD').AsString , 02) +                                            //FTD_UNIDAD', 'C',  02, 00 (10)
                              fPadR (FieldByName('DET_CODMAR').AsString , 03) +                                            //FTD_CODMAR', 'C',  03, 00 (11)
                              fPadR (FieldByName('DET_FORITE').AsString , 08) +                                            //FTD_CODFOR', 'C',  08, 00 (12)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_QTDITE').AsFloat),',','.') , 12) + //FTD_QTDITE', 'N',  12, 03 (13)
                              fPadR (AnsiReplaceStr(FormatFloat('0.0000',fltUnitar),',','.')  , 12)                      + //MOV_UNITAR', 'N',  12, 02 (06)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00', fltTotIte),',','.') , 12)                        + //FTD_TOTITE', 'N',  12, 02 (15)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTCUS').AsFloat),',','.') , 12) + //FTD_TOTCUS', 'N',  12, 02 (16) )
                              fPadR (''                                 , 03) +                                            //FTD_CODARE', 'C',  03, 00 (17)
                              fPadR (FieldByName('DET_CODREP').AsString , 03) +                                            //FTD_CODREP', 'C',  03, 00 (18)
                              fPadR (FieldByName('DET_CODVEN').AsString , 03) +                                            //FTD_CODVEN', 'C',  03, 00 (19)
                              fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PERCOM').AsFloat),',','.'), 05), 05) + //FTD_PERCOM', 'N',  05, 02 (20)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTCOM').AsFloat),',','.') , 12) + //FTD_TOTCOM', 'N',  12, 02 (21)
                              fPadR (FieldByName('DET_CLAFIS').AsString , 04) +                                            //FTD_CLAFIS', 'C',  04, 00 (22)
                              fPadR (FieldByName('DET_CODFIS').AsString , 03) +                                            //FTD_CODFIS', 'C',  03, 00 (23)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALIPI').AsFloat),',','.') , 12) + //FTD_VALIPI', 'N',  12, 02 (24)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASIPI').AsFloat),',','.') , 12) + //FTD_BASIPI', 'N',  12, 02 (25)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALICM').AsFloat),',','.') , 12) + //FTD_VALICM', 'N',  12, 02 (26)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASICM').AsFloat),',','.') , 12) + //FTD_BASICM', 'N',  12, 02 (27)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALRET').AsFloat),',','.') , 12) + //FTD_VALRET', 'N',  12, 02 (28)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASRET').AsFloat),',','.') , 12) + //FTD_BASRET', 'N',  12, 02 (29)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VLRCON').AsFloat),',','.') , 12) + //FTD_VALBRU', 'N',  12, 02 (30)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTPES').AsFloat),',','.') , 12) + //FTD_TOTPES', 'N',  12, 02 (31)
                              fPadR (''                                 , 05) +                                            //FTD_NUMLOT', 'C',  05, 00 (32)
                              fPadR (FieldByName('DET_CODDIV').AsString , 08) +                                            //FTD_PROFIS', 'C',  08, 00 (33)
                              fPadR (''                                 , 06) +                                            //FTD_NUMORC', 'C',  06, 00 (34)
                              fPadR (FieldByName('DET_JAFATU').AsString , 01) +                                            //FTD_JAFATU', 'L',  01, 00 (35)
                              fPadR (FieldByName('DET_TIPFAT').AsString , 02) +                                            //FTD_TIPFAT', 'C',  02, 00 (36)
                              fPadR (FieldByName('DET_NUMFAT').AsString , 06) +                                            //FTD_NUMFAT', 'C',  06, 00 (37)
                              fPadR (FieldByName('DET_DTAFAT').AsString , 08) +                                            //FTD_DTAFAT', 'D',  08, 00 (38)
                              fPadR (FieldByName('DET_VENFAT').AsString , 03) +                                            //FTD_VENFAT', 'C',  03, 00 (39)
                              fPadR (FieldByName('DET_CNDFAT').AsString , 38) +                                            //FTD_CNDFAT', 'C',  38, 00 (40)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALFAT').AsFloat),',','.') , 12) + //FTD_VALFAT', 'N',  12, 02 (41)
                              fPadR ('0.00'                             , 12) +                                            //FTD_DESESP', 'N',  12, 02 (42)
                              fPadR (''                                 , 01) +                                            //FTD_DIGCLA', 'C',  01, 00 (43)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_UNIORI').AsFloat),',','.') , 12) + //FTD_UNIANT', 'N',  12, 02 (44)
                              fPadR (FieldByName('DET_CODEMP').AsString , 03) +                                            //FTD_NUMLOJ', 'C',  03, 00 (45)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTMED').AsFloat),',','.') , 12) + //FTD_TOTMED', 'N',  12, 02 (46)
                              fPadR (''                                 , 03) +                                            //FTD_CODECF', 'C',  03, 00 (47)
                              fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_ALQICM').AsFloat),',','.'), 06), 06) + //FTD_ALQICM', 'N',  06, 02 (48)
                              fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_ALQIPI').AsFloat),',','.'), 06), 06) + //FTD_ALQIPI', 'N',  06, 02 (49)
                              fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PERBAS').AsFloat),',','.'), 06), 06) + //FTD_PERBAS', 'N',  06, 02 (50)
                              fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PERRED').AsFloat),',','.'), 06), 06) + //FTD_PERRED', 'N',  06, 02 (51)
                              fPadR (FieldByName('DET_IDEPRO').AsString , 03) +                                            //FTD_IDEPRO', 'C',  03, 00 (52)
                              fPadR (FieldByName('DET_ITETIN').AsString , 18) +                                            //FTD_ITETIN', 'C',  18, 00 (53)
                              fPadR (FieldByName('DET_ITECHA').AsString , 08) +                                            //FTD_ITECHA', 'C',  08, 00 (54)
                              fPadR (FieldByName('DET_DESCOR').AsString , 15) +                                            //FTD_DESCOR', 'C',  15, 00 (55)
                              fPadR (FieldByName('DET_TIPEMB').AsString , 02) +                                            //FTD_TIPEMB', 'C',  02, 00 (56)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_QTDEMB').AsFloat),',','.') , 12) + //FTD_QTDEMB', 'N',  12, 02 (57)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PREEMB').AsFloat),',','.') , 12) + //FTD_PREEMB', 'N',  12, 02 (58)
                              fPadR (FieldByName('DET_TIPPRE').AsString , 01) +                                            //FTD_TIPPRE', 'C',  01, 00 (59)
                              fPadR (FieldByName('DET_PRVTIN').AsString , 50) +                                            //FTD_CAMLVE', 'C',  50, 00 (60)
                              fPadR (FieldByName('DET_PRCTIN').AsString , 50) +                                            //FTD_CAMLCU', 'C',  50, 00 (61)
                              fPadR (''                                 , 01) +                                            //FTD_INCPIS', 'C',  01, 00 (62)
                              fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_DESCON').AsFloat),',','.') , 12) + //FTD_DESCON', 'N',  12, 02 (63)
                              fPadR (FieldByName('DET_PROEMB').AsString , 01) +                                            //FTD_PROEMB', 'L',  01, 00 (64)
                              fPadR (FieldByName('DET_SERIE_').AsString , 03) +                                            //FTD_SERIE_', 'C',  03, 00 (65)
                              fPadR (IIF((SameText(FieldByName('DET_TIP_FC').AsString, 'F')) And (SameText(FieldByName('DET_ORIDOC').AsString, 'V')),
                                     'XXXXXXXX', EmptyStr), 08) +                                                          //FTD_CODCON', 'C',  08, 00 (66)
                              fPadR (strDtaDel                          , 08);                                             //    DTADEL', 'D',  08, 00 (67)

            End;

            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************LB*}
            lstTexto.Add(strTransacao);

          End;

          Next;
        End;
      End;

    lstTexto.SaveToFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);

    End;

  Finally
    FreeAndNil(qryMovDet);
    FreeAndNil(lstTexto);
  End;

end;

procedure TfrmExpAutSin.pGeraArqNotGer;
  Var
    strSQL      : String;
    strTransacao: String;
    strNomArq   : String;
    strDtaCad   : String;
    lstTexto    : TStringList;
    qryNotGer   : TUniQuery;
    qryCliCon   : TUniQuery;
begin
  Try
    qryNotGer := fCriaQuery;
    qryCliCon := fCriaQuery;

    strNomArq := 'FATGER.TXT';

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  0.00 AS GER_TOTFRE, '; //Nao enviar o valor do frete
    strSQL := strSQL + '  G.GER_TOTPRO + G.GER_TOTFRE AS GER_TOTPRO, ';//O valor do frete estara dissolvido nos produtos
    strSQL := strSQL + '  G.*, ';
    strSQL := strSQL + '  F.*, ';
    strSQL := strSQL + '  CIDFOR.CID_NOMCID AS FOR_NOMCID, ';
    strSQL := strSQL + '  CIDFOR.CID_ESTADO AS FOR_ESTADO, ';
    strSQL := strSQL + '  CADCID.CID_NOMCID, ';
    strSQL := strSQL + '  CLI_NOMCLI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  NOTGER G ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CADCID.CID_CODCID = GER_CIDCON ';
    strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADFOR F ON FOR_CODFOR = GER_CODFOR ';
    strSQL := strSQL + '  LEFT JOIN CADCID AS CIDFOR ON CIDFOR.CID_CODCID = FOR_CODCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  (G.GER_CLAFIS > 5000 OR IFNULL(G.GER_ORIDOC, "") = "D" OR IFNULL(G.GER_ORIDOC, "") = "V") AND ';
    strSQL := strSQL + '  G.GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  G.GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    If Not chkNF.Checked Then
    Begin
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "NF" ';
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "EL" ';
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "D1" ';
    End;

    If Not chkIF.Checked Then
    Begin
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "IF" ';
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "IV" ';
    End;

    strSQL := strSQL + 'ORDER BY G.GER_TIP_FC ';

    With qryNotGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      Open;
    End;

    If Not qryNotGer.IsEmpty Then
    Begin

      If Not( FileExists( fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq ) ) Then
        lstTexto := TStringList.Create
      Else
      Begin
        lstTexto := TStringList.Create;
        lstTexto.LoadFromFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);
      End;

      {**************************}
      {* TRANSAÇÃO DO ARQUIVO   *}
      {***********************LB*}
      With qryNotGer Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          If fEmptyStr(FieldByName('GER_DTAENT').AsString) Then
            strDtaCad := ''
          Else
            strDtaCad  := FormatDateTime('yyyy',FieldByName('GER_DTAENT').AsDateTime) +
                          FormatDateTime('mm',FieldByName('GER_DTAENT').AsDateTime)   +
                          FormatDateTime('dd',FieldByName('GER_DTAENT').AsDateTime);

          strTransacao := fPadR (FieldByName('GER_NUMDOC').AsString , 06) +                                             // FTG_NUMDOC', 'C', 06, 00
                          fPadR (strDtaCad                          , 08) +                                             // FTG_DTAENT', 'D', 08, 00
                          fPadR (FieldByName('GER_ESPDOC').AsString , 02) +                                             // FTG_ESPDOC', 'C', 02, 00
                          fPadR (FieldByName('GER_CONPAG').AsString , 38) +                                             // FTG_CNDPAG', 'C', 38, 00  // VERIFICAR

                          fPadR (IIF((SameText(FieldByName('GER_TIP_FC').AsString, 'F')) And (SameText(FieldByName('GER_ORIDOC').AsString, 'V')),
                                 fGetClienteConsumidor, FieldByName('GER_CODCLI').AsString), 08) +                    // FTG_CODCLI', 'C', 08, 00

                          fPadR (FieldByName('GER_ESTADO').AsString , 02) +                                             // FTG_ESTADO', 'C', 02, 00
                          fPadR (''                                 , 03) +                                             // FTG_CODATI', 'C', 03, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VLRCON').AsFloat),',','.')  , 12) + // FTG_VLCONT', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_DESESP').AsFloat),',','.')  , 12) + // FTG_DESESP', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTPRO').AsFloat),',','.')  , 12) + // FTG_VLPROD', 'N', 12, 02      // VERIFICAR
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_BASIPI').AsFloat),',','.')  , 12) + // FTG_BASIPI', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTIPI').AsFloat),',','.')  , 12) + // FTG_TOTIPI', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_BASICM').AsFloat),',','.')  , 12) + // FTG_BASICM', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTICM').AsFloat),',','.')  , 12) + // FTG_TOTICM', 'N', 12, 02
                          fPadR (FieldByName('GER_CLAFIS').AsString , 04) +                                             // FTG_CLAFIS', 'C', 04, 00
                          fPadR (''                                 , 03) +                                             // FTG_CODARE', 'C', 03, 00
                          fPadR ('0'                                 , 05) +                                             // FTG_PERARE', 'N', 05, 02
                          fPadR ('0'                                 , 12) +                                             // FTG_COMARE', 'N', 12, 02
                          fPadR (''                                 , 03) +                                             // FTG_CODREP', 'C', 03, 00  // DETALHADO
                          fPadR ('0'                                 , 05) +                                             // FTG_PERREP', 'N', 05, 02
                          fPadR ('0'                                 , 12) +                                             // FTG_COMREP', 'N', 12, 02
                          fPadR (FieldByName('GER_CODVEN').AsString , 03) +                                             // FTG_CODVEN', 'C', 03, 00
                          fPadR ('0'                                 , 05) +                                             // FTG_PERVEN', 'N', 05, 02
                          fPadR ('0'                                 , 12) +                                             // FTG_COMVEN', 'N', 12, 02
                          fPadR (''                                 , 08) +                                             // FTG_PROFIS', 'C', 08, 00
                          fPadR (''                                 , 06) +                                             // FTG_NUMORC', 'C', 06, 00
                          fPadR (FieldByName('GER_CODTRA').AsString , 05) +                                             // FTG_CODTRA', 'C', 05, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.000',FieldByName('GER_PESBRU').AsFloat),',','.')  , 12) + // FTG_PESOBR', 'N', 12, 03
                          fPadR (AnsiReplaceStr(FormatFloat('0.000',FieldByName('GER_PESLIQ').AsFloat),',','.')  , 12) + // FTG_PESOLQ', 'N', 12, 03
                          fPadR (AnsiReplaceStr(FormatFloat('0.000',FieldByName('GER_VOLUME').AsFloat),',','.')  , 12) + // FTG_VOLUME', 'N', 12, 03
                          fPadR (FieldByName('GER_ESPECI').AsString , 10) +                                             // FTG_ESPECI', 'C', 10, 00
                          fPadR (FieldByName('GER_MARCA_').AsString , 10) +                                             // FTG_MARCA_', 'C', 10, 00
                          fPadR (FieldByName('GER_MEN001').AsString , 50) +                                             // FTG_MENSAG', 'C', 50, 00
                          fPadR (''                                 , 07) +                                             // FTG_DUPLIC', 'C', 07, 00
                          fPadR (''                                 , 05) +                                             // FTG_PORTAD', 'C', 05, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTRET').AsFloat),',','.')  , 12) + // FTG_TOTRET', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_BASRET').AsFloat),',','.')  , 12) + // FTG_BASRET', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTCUS').AsFloat),',','.')  , 12) + // FTG_TOTCUS', 'N', 12, 02
                          fPadR (FieldByName('GER_TIPFRE').AsString , 01) +                                             // FTG_TIPFRE', 'C', 01, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTFRE').AsFloat),',','.')  , 12) + // FTG_VALFRE', 'N', 12, 02
                          fPadR (FieldByName('GER_JAFATU').AsString , 01) +                                             // FTG_JAFATU', 'L', 01, 00
                          fPadR (FieldByName('GER_TIPFAT').AsString , 02) +                                             // FTG_TIPFAT', 'C', 02, 00
                          fPadR (FieldByName('GER_NUMFAT').AsString , 06) +                                             // FTG_NUMFAT', 'C', 06, 00
                          fPadR (FieldByName('GER_DTAFAT').AsString , 08) +                                             // FTG_DTAFAT', 'D', 08, 00
                          fPadR (FieldByName('GER_VENFAT').AsString , 03) +                                             // FTG_VENFAT', 'C', 03, 00
                          fPadR (FieldByName('GER_CNDFAT').AsString , 38) +                                             // FTG_CNDFAT', 'C', 38, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VALFAT').AsFloat),',','.')  , 12) + // FTG_VALFAT', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_BASSIM').AsFloat),',','.')  , 12) + // FTG_BASSIM', 'N', 12, 02
                          fPadR (''                                 , 01);                                              // FTG_DIGCLA', 'C', 01, 00

                          If (fClienteConsumidor(FieldByName('CLI_NOMCLI').AsString, False, True)) Then
                          Begin

                            pPesquisaCadCliCon(qryCliCon, qryCliCon, FieldByName('GER_CGCCON').AsString);
                            If qryCliCon.IsEmpty Then
                            Begin
                              strTransacao := strTransacao +
                              fPadR (FieldByName('GER_NOMCON').AsString , 40) +                                           // FTG_NOMCON', 'C', 40, 00
                              fPadR (FieldByName('GER_ENDCON').AsString , 40) +                                           // FTG_ENDCON', 'C', 40, 00
                              fPadR (FieldByName('GER_BAICON').AsString , 18) +                                           // FTG_BAICON', 'C', 18, 00
                              fPadR (FieldByName('GER_CEPCON').AsString , 08) +                                           // FTG_CEPCON', 'C', 08, 00
                              fPadR (FieldByName('CID_NOMCID').AsString , 25) +                                           // FTG_CIDCON', 'C', 25, 00
                              fPadR (FieldByName('GER_ESTCON').AsString , 02) +                                           // FTG_ESTCON', 'C', 02, 00
                              fPadR (FieldByName('GER_TELCON').AsString , 11) +                                           // FTG_TELCON', 'C', 11, 00
                              fPadR (FieldByName('GER_CGCCPF').AsString , 01) +                                           // FTG_CGCCPF', 'N', 01, 00
                              fPadR (FieldByName('GER_CGCCON').AsString , 18) +                                           // FTG_CGCCON', 'C', 18, 00
                              fPadR (FieldByName('GER_IESCON').AsString , 18);                                            // FTG_IESCON', 'C', 18, 00
                            End
                            Else
                            Begin
                              strTransacao := strTransacao +
                              fPadR (qryCliCon.FieldByName('CON_NOMCON').AsString , 40) +                                 // FTG_NOMCON', 'C', 40, 00
                              fPadR (qryCliCon.FieldByName('CON_ENDERE').AsString , 40) +                                 // FTG_ENDCON', 'C', 40, 00
                              fPadR (qryCliCon.FieldByName('CON_BAIRRO').AsString , 18) +                                 // FTG_BAICON', 'C', 18, 00
                              fPadR (qryCliCon.FieldByName('CON_C_E_P_').AsString , 08) +                                 // FTG_CEPCON', 'C', 08, 00
                              fPadR (fRetNomCidade(qryCliCon.FieldByName('CON_CODCID').AsString) , 25) +                  // FTG_CIDCON', 'C', 25, 00
                              fPadR (fRetNomCidade(qryCliCon.FieldByName('CON_CODCID').AsString, 1) , 02) +               // FTG_ESTCON', 'C', 02, 00
                              fPadR (qryCliCon.FieldByName('CON_FONE01').AsString , 11) +                                 // FTG_TELCON', 'C', 11, 00
                              fPadR (qryCliCon.FieldByName('CON_CGCCPF').AsString , 01) +                                 // FTG_CGCCPF', 'N', 01, 00
                              fPadR (qryCliCon.FieldByName('CON_C_P_F_').AsString , 18) +                                 // FTG_CGCCON', 'C', 18, 00
                              fPadR (qryCliCon.FieldByName('CON_I_E_S_').AsString , 18);                                  // FTG_IESCON', 'C', 18, 00
                            End;

                          End

                          Else If ((SameText(FieldByName('GER_TIP_FC').AsString, 'F')) And (SameText(FieldByName('GER_ORIDOC').AsString, 'V'))) Then
                          Begin
                            strTransacao := strTransacao +
                            fPadR (FieldByName('FOR_NOMFOR').AsString, 40) +                                          // FTG_NOMCON', 'C', 40, 00
                            fPadR (FieldByName('FOR_ENDERE').AsString, 40) +                                          // FTG_ENDCON', 'C', 40, 00
                            fPadR (FieldByName('FOR_BAIRRO').AsString, 18) +                                          // FTG_BAICON', 'C', 18, 00
                            fPadR (FieldByName('FOR_C_E_P_').AsString, 08) +                                          // FTG_CEPCON', 'C', 08, 00
                            fPadR (FieldByName('FOR_NOMCID').AsString, 25) +                                          // FTG_CIDCON', 'C', 25, 00
                            fPadR (FieldByName('FOR_ESTADO').AsString, 02) +                                          // FTG_ESTCON', 'C', 02, 00
                            fPadR (FieldByName('FOR_FONE01').AsString, 11) +                                          // FTG_TELCON', 'C', 11, 00
                            fPadR (FieldByName('FOR_CGCCPF').AsString, 01) +                                          // FTG_CGCCPF', 'N', 01, 00
                            fPadR (FieldByName('FOR_C_G_C_').AsString, 18) +                                          // FTG_CGCCON', 'C', 18, 00
                            fPadR (FieldByName('FOR_I_E_S_').AsString, 18);                                           // FTG_IESCON', 'C', 18, 00
                          End

                          Else
                          Begin
                            strTransacao := strTransacao +
                            fPadR (''                                 , 40) +                                           // FTG_NOMCON', 'C', 40, 00
                            fPadR (''                                 , 40) +                                           // FTG_ENDCON', 'C', 40, 00
                            fPadR (''                                 , 18) +                                           // FTG_BAICON', 'C', 18, 00
                            fPadR (''                                 , 08) +                                           // FTG_CEPCON', 'C', 08, 00
                            fPadR (''                                 , 25) +                                           // FTG_CIDCON', 'C', 25, 00
                            fPadR (''                                 , 02) +                                           // FTG_ESTCON', 'C', 02, 00
                            fPadR (''                                 , 11) +                                           // FTG_TELCON', 'C', 11, 00
                            fPadR (''                                 , 01) +                                           // FTG_CGCCPF', 'N', 01, 00
                            fPadR (''                                 , 18) +                                           // FTG_CGCCON', 'C', 18, 00
                            fPadR (''                                 , 18);                                            // FTG_IESCON', 'C', 18, 00
                          End;

                          strTransacao := strTransacao +
                          fPadR (FieldByName('GER_MEN002').AsString , 50) +                                             // FTG_MENGE2', 'C', 50, 00
                          fPadR (FieldByName('GER_CODEMP').AsString , 03) +                                             // FTG_NUMLOJ', 'C', 03, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTMED').AsFloat),',','.')  , 12) + // FTG_TOTMED', 'N', 12, 02
                          fPadR (''                                 , 03)                                             + // FTG_CODECF', 'C', 03, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTPRO').AsFloat),',','.')  , 12) + // FTG_TOTPRO', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR01').AsFloat),',','.')  , 12) + // FTG_VPAR01', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR02').AsFloat),',','.')  , 12) + // FTG_VPAR02', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR03').AsFloat),',','.')  , 12) + // FTG_VPAR03', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR04').AsFloat),',','.')  , 12) + // FTG_VPAR04', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR05').AsFloat),',','.')  , 12) + // FTG_VPAR05', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR06').AsFloat),',','.')  , 12) + // FTG_VPAR06', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR07').AsFloat),',','.')  , 12) + // FTG_VPAR07', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR08').AsFloat),',','.')  , 12) + // FTG_VPAR08', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR09').AsFloat),',','.')  , 12) + // FTG_VPAR09', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR10').AsFloat),',','.')  , 12) + // FTG_VPAR10', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR11').AsFloat),',','.')  , 12) + // FTG_VPAR11', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR12').AsFloat),',','.')  , 12) + // FTG_VPAR12', 'N', 12, 02
                          fPadR (FieldByName('GER_SERIE_').AsString , 03) +                                             // FTG_SERIE_', 'C', 03, 00
                          fPadR (IIF((SameText(FieldByName('GER_TIP_FC').AsString, 'F')) And (SameText(FieldByName('GER_ORIDOC').AsString, 'V')),
                                 'XXXXXXXX', EmptyStr), 08);                                                            // FTG_CODCON', 'C', 08, 00

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************LB*}
          lstTexto.Add(strTransacao);

          Next;
        End;
      End;

      lstTexto.SaveToFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);

    End;

  Finally
    FreeAndNil(qryCliCon);
    FreeAndNil(qryNotGer);
    FreeAndNil(lstTexto);
  End;

end;

procedure TfrmExpAutSin.pGeraArqDelNotGer;
  Var
    strSQL      : String;
    strTransacao: String;
    strNomArq   : String;
    strDtaCad   : String;
    strDtaDel   : String;
    lstTexto    : TStringList;
    qryNotGer   : TUniQuery;
    qryCliCon   : TUniQuery;
begin
  Try
    qryNotGer := fCriaQuery;
    qryCliCon := fCriaQuery;

    strNomArq := 'DELFTG.TXT';

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  0.00 AS GER_TOTFRE, '; //Nao enviar o valor do frete
    strSQL := strSQL + '  G.GER_TOTPRO + G.GER_TOTFRE AS GER_TOTPRO, ';//O valor do frete estara dissolvido nos produtos
    strSQL := strSQL + '  G.*, ';
    strSQL := strSQL + '  F.*, ';
    strSQL := strSQL + '  CIDFOR.CID_NOMCID AS FOR_NOMCID, ';
    strSQL := strSQL + '  CIDFOR.CID_ESTADO AS FOR_ESTADO, ';
    strSQL := strSQL + '  CADCID.CID_NOMCID, ';
    strSQL := strSQL + '  CLI_NOMCLI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  DEL_NOTGER G ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CADCID.CID_CODCID = GER_CIDCON ';
    strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADFOR F ON FOR_CODFOR = GER_CODFOR ';
    strSQL := strSQL + '  LEFT JOIN CADCID AS CIDFOR ON CIDFOR.CID_CODCID = FOR_CODCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  (G.GER_CLAFIS > 5000 OR IFNULL(G.GER_ORIDOC, "") = "D" OR IFNULL(G.GER_ORIDOC, "") = "V") AND ';
    strSQL := strSQL + '  G.GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  G.DTADEL BETWEEN :DTAINI AND :DTAFIN ';

    If Not chkNF.Checked Then
    Begin
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "NF" ';
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "EL" ';
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "D1" ';
    End;

    If Not chkIF.Checked Then
    Begin
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "IF" ';
      strSQL := strSQL + '  AND G.GER_ESPDOC <> "IV" ';
    End;
    
    strSQL := strSQL + 'ORDER BY G.GER_TIP_FC ';

    With qryNotGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      Open;
    End;

    If Not qryNotGer.IsEmpty Then
    Begin

      If Not( FileExists( fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq ) ) Then
        lstTexto := TStringList.Create
      Else
      Begin
        lstTexto := TStringList.Create;
        lstTexto.LoadFromFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);
      End;

      {**************************}
      {* TRANSAÇÃO DO ARQUIVO   *}
      {***********************LB*}
      With qryNotGer Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          If fEmptyStr(FieldByName('GER_DTAENT').AsString) Then
            strDtaCad := ''
          Else
            strDtaCad  := FormatDateTime('yyyy',FieldByName('GER_DTAENT').AsDateTime) +
                          FormatDateTime('mm',FieldByName('GER_DTAENT').AsDateTime)   +
                          FormatDateTime('dd',FieldByName('GER_DTAENT').AsDateTime);

          If fEmptyStr(FieldByName('DTADEL').AsString) Then
            strDtaDel  := ''
          Else
            strDtaDel  := FormatDateTime('yyyy',FieldByName('DTADEL').AsDateTime) +
                          FormatDateTime('mm',FieldByName('DTADEL').AsDateTime)   +
                          FormatDateTime('dd',FieldByName('DTADEL').AsDateTime);

          strTransacao := fPadR (FieldByName('GER_NUMDOC').AsString , 06) +                                             // FTG_NUMDOC', 'C', 06, 00
                          fPadR (strDtaCad                          , 08) +                                             // FTG_DTAENT', 'D', 08, 00
                          fPadR (FieldByName('GER_ESPDOC').AsString , 02) +                                             // FTG_ESPDOC', 'C', 02, 00
                          fPadR (FieldByName('GER_CONPAG').AsString , 38) +                                             // FTG_CNDPAG', 'C', 38, 00  // VERIFICAR

                          fPadR (IIF((SameText(FieldByName('GER_TIP_FC').AsString, 'F')) And (SameText(FieldByName('GER_ORIDOC').AsString, 'V')),
                                 fGetClienteConsumidor, FieldByName('GER_CODCLI').AsString), 08) +                    // FTG_CODCLI', 'C', 08, 00

                          fPadR (FieldByName('GER_ESTADO').AsString , 02) +                                             // FTG_ESTADO', 'C', 02, 00
                          fPadR (''                                 , 03) +                                             // FTG_CODATI', 'C', 03, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VLRCON').AsFloat),',','.')  , 12) + // FTG_VLCONT', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_DESESP').AsFloat),',','.')  , 12) + // FTG_DESESP', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTPRO').AsFloat),',','.')  , 12) + // FTG_VLPROD', 'N', 12, 02      // VERIFICAR
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_BASIPI').AsFloat),',','.')  , 12) + // FTG_BASIPI', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTIPI').AsFloat),',','.')  , 12) + // FTG_TOTIPI', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_BASICM').AsFloat),',','.')  , 12) + // FTG_BASICM', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTICM').AsFloat),',','.')  , 12) + // FTG_TOTICM', 'N', 12, 02
                          fPadR (FieldByName('GER_CLAFIS').AsString , 04) +                                             // FTG_CLAFIS', 'C', 04, 00
                          fPadR (''                                 , 03) +                                             // FTG_CODARE', 'C', 03, 00
                          fPadR ('0'                                 , 05) +                                             // FTG_PERARE', 'N', 05, 02
                          fPadR ('0'                                 , 12) +                                             // FTG_COMARE', 'N', 12, 02
                          fPadR (''                                 , 03) +                                             // FTG_CODREP', 'C', 03, 00  // DETALHADO
                          fPadR ('0'                                 , 05) +                                             // FTG_PERREP', 'N', 05, 02
                          fPadR ('0'                                 , 12) +                                             // FTG_COMREP', 'N', 12, 02
                          fPadR (FieldByName('GER_CODVEN').AsString , 03) +                                             // FTG_CODVEN', 'C', 03, 00
                          fPadR ('0'                                 , 05) +                                             // FTG_PERVEN', 'N', 05, 02
                          fPadR ('0'                                 , 12) +                                             // FTG_COMVEN', 'N', 12, 02
                          fPadR (''                                 , 08) +                                             // FTG_PROFIS', 'C', 08, 00
                          fPadR (''                                 , 06) +                                             // FTG_NUMORC', 'C', 06, 00
                          fPadR (FieldByName('GER_CODTRA').AsString , 05) +                                             // FTG_CODTRA', 'C', 05, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.000',FieldByName('GER_PESBRU').AsFloat),',','.')  , 12) + // FTG_PESOBR', 'N', 12, 03
                          fPadR (AnsiReplaceStr(FormatFloat('0.000',FieldByName('GER_PESLIQ').AsFloat),',','.')  , 12) + // FTG_PESOLQ', 'N', 12, 03
                          fPadR (AnsiReplaceStr(FormatFloat('0.000',FieldByName('GER_VOLUME').AsFloat),',','.')  , 12) + // FTG_VOLUME', 'N', 12, 03
                          fPadR (FieldByName('GER_ESPECI').AsString , 10) +                                             // FTG_ESPECI', 'C', 10, 00
                          fPadR (FieldByName('GER_MARCA_').AsString , 10) +                                             // FTG_MARCA_', 'C', 10, 00
                          fPadR (FieldByName('GER_MEN001').AsString , 50) +                                             // FTG_MENSAG', 'C', 50, 00
                          fPadR (''                                 , 07) +                                             // FTG_DUPLIC', 'C', 07, 00
                          fPadR (''                                 , 05) +                                             // FTG_PORTAD', 'C', 05, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTRET').AsFloat),',','.')  , 12) + // FTG_TOTRET', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_BASRET').AsFloat),',','.')  , 12) + // FTG_BASRET', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTCUS').AsFloat),',','.')  , 12) + // FTG_TOTCUS', 'N', 12, 02
                          fPadR (FieldByName('GER_TIPFRE').AsString , 01) +                                             // FTG_TIPFRE', 'C', 01, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTFRE').AsFloat),',','.')  , 12) + // FTG_VALFRE', 'N', 12, 02
                          fPadR (FieldByName('GER_JAFATU').AsString , 01) +                                             // FTG_JAFATU', 'L', 01, 00
                          fPadR (FieldByName('GER_TIPFAT').AsString , 02) +                                             // FTG_TIPFAT', 'C', 02, 00
                          fPadR (FieldByName('GER_NUMFAT').AsString , 06) +                                             // FTG_NUMFAT', 'C', 06, 00
                          fPadR (FieldByName('GER_DTAFAT').AsString , 08) +                                             // FTG_DTAFAT', 'D', 08, 00
                          fPadR (FieldByName('GER_VENFAT').AsString , 03) +                                             // FTG_VENFAT', 'C', 03, 00
                          fPadR (FieldByName('GER_CNDFAT').AsString , 38) +                                             // FTG_CNDFAT', 'C', 38, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VALFAT').AsFloat),',','.')  , 12) + // FTG_VALFAT', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_BASSIM').AsFloat),',','.')  , 12) + // FTG_BASSIM', 'N', 12, 02
                          fPadR (''                                 , 01);                                              // FTG_DIGCLA', 'C', 01, 00

                          If (fClienteConsumidor(FieldByName('CLI_NOMCLI').AsString, False, True)) Then
                          Begin

                            pPesquisaCadCliCon(qryCliCon, qryCliCon, FieldByName('GER_CGCCON').AsString);
                            If qryCliCon.IsEmpty Then
                            Begin
                              strTransacao := strTransacao +
                              fPadR (FieldByName('GER_NOMCON').AsString , 40) +                                           // FTG_NOMCON', 'C', 40, 00
                              fPadR (FieldByName('GER_ENDCON').AsString , 40) +                                           // FTG_ENDCON', 'C', 40, 00
                              fPadR (FieldByName('GER_BAICON').AsString , 18) +                                           // FTG_BAICON', 'C', 18, 00
                              fPadR (FieldByName('GER_CEPCON').AsString , 08) +                                           // FTG_CEPCON', 'C', 08, 00
                              fPadR (FieldByName('CID_NOMCID').AsString , 25) +                                           // FTG_CIDCON', 'C', 25, 00
                              fPadR (FieldByName('GER_ESTCON').AsString , 02) +                                           // FTG_ESTCON', 'C', 02, 00
                              fPadR (FieldByName('GER_TELCON').AsString , 11) +                                           // FTG_TELCON', 'C', 11, 00
                              fPadR (FieldByName('GER_CGCCPF').AsString , 01) +                                           // FTG_CGCCPF', 'N', 01, 00
                              fPadR (FieldByName('GER_CGCCON').AsString , 18) +                                           // FTG_CGCCON', 'C', 18, 00
                              fPadR (FieldByName('GER_IESCON').AsString , 18);                                            // FTG_IESCON', 'C', 18, 00
                            End
                            Else
                            Begin
                              strTransacao := strTransacao +
                              fPadR (qryCliCon.FieldByName('CON_NOMCON').AsString , 40) +                                 // FTG_NOMCON', 'C', 40, 00
                              fPadR (qryCliCon.FieldByName('CON_ENDERE').AsString , 40) +                                 // FTG_ENDCON', 'C', 40, 00
                              fPadR (qryCliCon.FieldByName('CON_BAIRRO').AsString , 18) +                                 // FTG_BAICON', 'C', 18, 00
                              fPadR (qryCliCon.FieldByName('CON_C_E_P_').AsString , 08) +                                 // FTG_CEPCON', 'C', 08, 00
                              fPadR (fRetNomCidade(qryCliCon.FieldByName('CON_CODCID').AsString) , 25) +                  // FTG_CIDCON', 'C', 25, 00
                              fPadR (fRetNomCidade(qryCliCon.FieldByName('CON_CODCID').AsString, 1) , 02) +               // FTG_ESTCON', 'C', 02, 00
                              fPadR (qryCliCon.FieldByName('CON_FONE01').AsString , 11) +                                 // FTG_TELCON', 'C', 11, 00
                              fPadR (qryCliCon.FieldByName('CON_CGCCPF').AsString , 01) +                                 // FTG_CGCCPF', 'N', 01, 00
                              fPadR (qryCliCon.FieldByName('CON_C_P_F_').AsString , 18) +                                 // FTG_CGCCON', 'C', 18, 00
                              fPadR (qryCliCon.FieldByName('CON_I_E_S_').AsString , 18);                                  // FTG_IESCON', 'C', 18, 00
                            End;

                          End

                          Else If ((SameText(FieldByName('GER_TIP_FC').AsString, 'F')) And (SameText(FieldByName('GER_ORIDOC').AsString, 'V'))) Then
                          Begin
                            strTransacao := strTransacao +
                            fPadR (FieldByName('FOR_NOMFOR').AsString, 40) +                                          // FTG_NOMCON', 'C', 40, 00
                            fPadR (FieldByName('FOR_ENDERE').AsString, 40) +                                          // FTG_ENDCON', 'C', 40, 00
                            fPadR (FieldByName('FOR_BAIRRO').AsString, 18) +                                          // FTG_BAICON', 'C', 18, 00
                            fPadR (FieldByName('FOR_C_E_P_').AsString, 08) +                                          // FTG_CEPCON', 'C', 08, 00
                            fPadR (FieldByName('FOR_NOMCID').AsString, 25) +                                          // FTG_CIDCON', 'C', 25, 00
                            fPadR (FieldByName('FOR_ESTADO').AsString, 02) +                                          // FTG_ESTCON', 'C', 02, 00
                            fPadR (FieldByName('FOR_FONE01').AsString, 11) +                                          // FTG_TELCON', 'C', 11, 00
                            fPadR (FieldByName('FOR_CGCCPF').AsString, 01) +                                          // FTG_CGCCPF', 'N', 01, 00
                            fPadR (FieldByName('FOR_C_G_C_').AsString, 18) +                                          // FTG_CGCCON', 'C', 18, 00
                            fPadR (FieldByName('FOR_I_E_S_').AsString, 18);                                           // FTG_IESCON', 'C', 18, 00
                          End

                          Else
                          Begin
                            strTransacao := strTransacao +
                            fPadR (''                                 , 40) +                                           // FTG_NOMCON', 'C', 40, 00
                            fPadR (''                                 , 40) +                                           // FTG_ENDCON', 'C', 40, 00
                            fPadR (''                                 , 18) +                                           // FTG_BAICON', 'C', 18, 00
                            fPadR (''                                 , 08) +                                           // FTG_CEPCON', 'C', 08, 00
                            fPadR (''                                 , 25) +                                           // FTG_CIDCON', 'C', 25, 00
                            fPadR (''                                 , 02) +                                           // FTG_ESTCON', 'C', 02, 00
                            fPadR (''                                 , 11) +                                           // FTG_TELCON', 'C', 11, 00
                            fPadR (''                                 , 01) +                                           // FTG_CGCCPF', 'N', 01, 00
                            fPadR (''                                 , 18) +                                           // FTG_CGCCON', 'C', 18, 00
                            fPadR (''                                 , 18);                                            // FTG_IESCON', 'C', 18, 00
                          End;

                          strTransacao := strTransacao +
                          fPadR (FieldByName('GER_MEN002').AsString , 50) +                                             // FTG_MENGE2', 'C', 50, 00
                          fPadR (FieldByName('GER_CODEMP').AsString , 03) +                                             // FTG_NUMLOJ', 'C', 03, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTMED').AsFloat),',','.')  , 12) + // FTG_TOTMED', 'N', 12, 02
                          fPadR (''                                 , 03)                                             + // FTG_CODECF', 'C', 03, 00
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_TOTPRO').AsFloat),',','.')  , 12) + // FTG_TOTPRO', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR01').AsFloat),',','.')  , 12) + // FTG_VPAR01', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR02').AsFloat),',','.')  , 12) + // FTG_VPAR02', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR03').AsFloat),',','.')  , 12) + // FTG_VPAR03', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR04').AsFloat),',','.')  , 12) + // FTG_VPAR04', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR05').AsFloat),',','.')  , 12) + // FTG_VPAR05', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR06').AsFloat),',','.')  , 12) + // FTG_VPAR06', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR07').AsFloat),',','.')  , 12) + // FTG_VPAR07', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR08').AsFloat),',','.')  , 12) + // FTG_VPAR08', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR09').AsFloat),',','.')  , 12) + // FTG_VPAR09', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR10').AsFloat),',','.')  , 12) + // FTG_VPAR10', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR11').AsFloat),',','.')  , 12) + // FTG_VPAR11', 'N', 12, 02
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('GER_VPAR12').AsFloat),',','.')  , 12) + // FTG_VPAR12', 'N', 12, 02
                          fPadR (FieldByName('GER_SERIE_').AsString , 03) +                                             // FTG_SERIE_', 'C', 03, 00
                          fPadR (IIF((SameText(FieldByName('GER_TIP_FC').AsString, 'F')) And (SameText(FieldByName('GER_ORIDOC').AsString, 'V')),
                                 'XXXXXXXX', EmptyStr), 08) +                                                           // FTG_CODCON', 'C', 08, 00
                          fPadR (strDtaDel                          , 08);                                              //     DTADEL', 'D', 08, 00

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************LB*}
          lstTexto.Add(strTransacao);

          Next;
        End;
      End;

      lstTexto.SaveToFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);

    End;

  Finally
    FreeAndNil(qryCliCon);
    FreeAndNil(qryNotGer);
    FreeAndNil(lstTexto);
  End;

end;

procedure TfrmExpAutSin.pGeraArqNotDet;
  Var
    strSQL      : String;
    strTransacao: String;
    strNomArq   : String;
    strDtaCad   : String;
    fltUnitar   : Double;
    fltTotIte   : Double;
    lstTexto    : TStringList;
    qryNotDet   : TUniQuery;

begin
  Try
    qryNotDet := fCriaQuery(nil);

    strNomArq := 'FATDET.TXT';

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  0.00 AS DET_TOTFRE, '; //Nao enviar o valor do frete
    strSQL := strSQL + '  D.DET_TOTITE + D.DET_TOTFRE AS DET_TOTITE, ';//O valor do frete estara dissolvido nos produtos
    strSQL := strSQL + '  D.* ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  NOTDET D ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + ' (LOCATE(D.DET_ESPDOC, "TM_ML_PR_") <= 0) AND   ';
    strSQL := strSQL + '  D.DET_CODEMP = :CODEMP AND  ';
    strSQL := strSQL + ' (D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN) AND ';
    strSQL := strSQL + '  D.DET_CODITE <> :ITESER AND ';
    strSQL := strSQL + '  D.DET_CODITE <> :SERTER AND ';
    strSQL := strSQL + '  D.DET_QTDITE > 0 AND                          ';
    strSQL := strSQL + ' IFNULL(D.DET_PROEMB,"") <> "S" ';
    strSQL := strSQL + '  AND (D.DET_CLAFIS >= 5000 OR IFNULL(D.DET_ORIDOC, "") = "D" OR IFNULL(D.DET_ORIDOC, "") = "V") ';

    If Not chkNF.Checked Then
    Begin
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "NF" ';
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "EL" ';
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "D1" ';      
    End;

    If Not chkIF.Checked Then
    Begin
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "IF" ';
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "IV" ';
    End;

    strSQL := strSQL + 'ORDER BY D.DET_TIP_FC ';
    
    With qryNotDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('ITESER').AsString := fCfgSis('ITESER');
      ParamByName('SERTER').AsString := fCfgSis('SERTER');
      Open;
    End;

    If Not qryNotDet.IsEmpty Then
    Begin

      If Not( FileExists( fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq ) ) Then
        lstTexto := TStringList.Create
      Else
      Begin
        lstTexto := TStringList.Create;
        lstTexto.LoadFromFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);
      End;

      {**************************}
      {* TRANSAÇÃO DO ARQUIVO   *}
      {***********************LB*}
      With qryNotDet Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          If fEmptyStr(FieldByName('DET_DTAENT').AsString) Then
            strDtaCad := ''
          Else
            strDtaCad  := FormatDateTime('yyyy',FieldByName('DET_DTAENT').AsDateTime) +
                          FormatDateTime('mm',FieldByName('DET_DTAENT').AsDateTime)   +
                          FormatDateTime('dd',FieldByName('DET_DTAENT').AsDateTime);

          fltUnitar := (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat) / FieldByName('DET_QTDITE').AsFloat;
          fltTotIte := (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat);

          strTransacao := fPadR (FieldByName('DET_NUMDOC').AsString , 06) +                                            //FTD_NUMDOC', 'C',  06, 00 (01)
                          fPadR (strDtaCad                          , 08) +                                            //FTD_DTAENT', 'D',  08, 00 (02)
                          fPadR (FieldByName('DET_ESPDOC').AsString , 02) +                                            //FTD_ESPDOC', 'C',  02, 00 (03)
                          fPadR (FieldByName('DET_CONPAG').AsString , 38) +                                            //FTD_CNDPAG', 'C',  38, 00 (04)

                          fPadR (IIF((SameText(FieldByName('DET_TIP_FC').AsString, 'F')) And (SameText(FieldByName('DET_ORIDOC').AsString, 'V')),
                                     fGetClienteConsumidor, FieldByName('DET_CODCLI').AsString), 08) +                     //FTD_CODCLI', 'C',  08, 00 (05)

                          fPadR (''                                 , 03) +                                            //FTD_CODATI', 'C',  03, 00 (06)
                          fPadR (FieldByName('DET_ESTADO').AsString , 02) +                                            //FTD_ESTADO', 'C',  02, 00 (07)
                          fPadR (FieldByName('DET_CODITE').AsString , 14) +                                            //FTD_CODITE', 'C',  14, 00 (08)
                          fPadR (FieldByName('DET_DESCRI').AsString , 57) +                                            //FTD_DESCRI', 'C',  57, 00 (09)
                          fPadR (FieldByName('DET_UNIDAD').AsString , 02) +                                            //FTD_UNIDAD', 'C',  02, 00 (10)
                          fPadR (FieldByName('DET_CODMAR').AsString , 03) +                                            //FTD_CODMAR', 'C',  03, 00 (11)
                          fPadR (FieldByName('DET_FORITE').AsString , 08) +                                            //FTD_CODFOR', 'C',  08, 00 (12)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_QTDITE').AsFloat),',','.') , 12) + //FTD_QTDITE', 'N',  12, 03 (13)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00', fltUnitar),',','.') , 12)                        + //FTD_UNITAR', 'N',  12, 02 (14)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00', fltTotIte),',','.') , 12)                        + //FTD_TOTITE', 'N',  12, 02 (15)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTCUS').AsFloat),',','.') , 12) + //FTD_TOTCUS', 'N',  12, 02 (16) )
                          fPadR (''                                 , 03) +                                            //FTD_CODARE', 'C',  03, 00 (17)
                          fPadR (FieldByName('DET_CODREP').AsString , 03) +                                            //FTD_CODREP', 'C',  03, 00 (18)
                          fPadR (FieldByName('DET_CODVEN').AsString , 03) +                                            //FTD_CODVEN', 'C',  03, 00 (19)
                          fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PERCOM').AsFloat),',','.'), 05), 05) + //FTD_PERCOM', 'N',  05, 02 (20)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTCOM').AsFloat),',','.') , 12) + //FTD_TOTCOM', 'N',  12, 02 (21)
                          fPadR (FieldByName('DET_CLAFIS').AsString , 04) +                                            //FTD_CLAFIS', 'C',  04, 00 (22)
                          fPadR (FieldByName('DET_CODFIS').AsString , 03) +                                            //FTD_CODFIS', 'C',  03, 00 (23)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALIPI').AsFloat),',','.') , 12) + //FTD_VALIPI', 'N',  12, 02 (24)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASIPI').AsFloat),',','.') , 12) + //FTD_BASIPI', 'N',  12, 02 (25)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALICM').AsFloat),',','.') , 12) + //FTD_VALICM', 'N',  12, 02 (26)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASICM').AsFloat),',','.') , 12) + //FTD_BASICM', 'N',  12, 02 (27)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALRET').AsFloat),',','.') , 12) + //FTD_VALRET', 'N',  12, 02 (28)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASRET').AsFloat),',','.') , 12) + //FTD_BASRET', 'N',  12, 02 (29)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VLRCON').AsFloat),',','.') , 12) + //FTD_VALBRU', 'N',  12, 02 (30)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTPES').AsFloat),',','.') , 12) + //FTD_TOTPES', 'N',  12, 02 (31)
                          fPadR (''                                 , 05) +                                            //FTD_NUMLOT', 'C',  05, 00 (32)
                          fPadR (FieldByName('DET_CODDIV').AsString , 08) +                                            //FTD_PROFIS', 'C',  08, 00 (33)
                          fPadR (''                                 , 06) +                                            //FTD_NUMORC', 'C',  06, 00 (34)
                          fPadR (FieldByName('DET_JAFATU').AsString , 01) +                                            //FTD_JAFATU', 'L',  01, 00 (35)
                          fPadR (FieldByName('DET_TIPFAT').AsString , 02) +                                            //FTD_TIPFAT', 'C',  02, 00 (36)
                          fPadR (FieldByName('DET_NUMFAT').AsString , 06) +                                            //FTD_NUMFAT', 'C',  06, 00 (37)
                          fPadR (FieldByName('DET_DTAFAT').AsString , 08) +                                            //FTD_DTAFAT', 'D',  08, 00 (38)
                          fPadR (FieldByName('DET_VENFAT').AsString , 03) +                                            //FTD_VENFAT', 'C',  03, 00 (39)
                          fPadR (FieldByName('DET_CNDFAT').AsString , 38) +                                            //FTD_CNDFAT', 'C',  38, 00 (40)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALFAT').AsFloat),',','.') , 12) + //FTD_VALFAT', 'N',  12, 02 (41)
                          fPadR ('0.00'                             , 12) +                                            //FTD_DESESP', 'N',  12, 02 (42)
                          fPadR (''                                 , 01) +                                            //FTD_DIGCLA', 'C',  01, 00 (43)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_UNIORI').AsFloat),',','.') , 12) + //FTD_UNIANT', 'N',  12, 02 (44)
                          fPadR (FieldByName('DET_CODEMP').AsString , 03) +                                            //FTD_NUMLOJ', 'C',  03, 00 (45)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTMED').AsFloat),',','.') , 12) + //FTD_TOTMED', 'N',  12, 02 (46)
                          fPadR (''                                 , 03) +                                            //FTD_CODECF', 'C',  03, 00 (47)
                          fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_ALQICM').AsFloat),',','.'), 06), 06) + //FTD_ALQICM', 'N',  06, 02 (48)
                          fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_ALQIPI').AsFloat),',','.'), 06), 06) + //FTD_ALQIPI', 'N',  06, 02 (49)
                          fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PERBAS').AsFloat),',','.'), 06), 06) + //FTD_PERBAS', 'N',  06, 02 (50)
                          fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PERRED').AsFloat),',','.'), 06), 06) + //FTD_PERRED', 'N',  06, 02 (51)
                          fPadR (FieldByName('DET_IDEPRO').AsString , 03) +                                            //FTD_IDEPRO', 'C',  03, 00 (52)
                          fPadR (FieldByName('DET_ITETIN').AsString , 18) +                                            //FTD_ITETIN', 'C',  18, 00 (53)
                          fPadR (FieldByName('DET_ITECHA').AsString , 08) +                                            //FTD_ITECHA', 'C',  08, 00 (54)
                          fPadR (FieldByName('DET_DESCOR').AsString , 15) +                                            //FTD_DESCOR', 'C',  15, 00 (55)
                          fPadR (FieldByName('DET_TIPEMB').AsString , 02) +                                            //FTD_TIPEMB', 'C',  02, 00 (56)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_QTDEMB').AsFloat),',','.') , 12) + //FTD_QTDEMB', 'N',  12, 02 (57)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PREEMB').AsFloat),',','.') , 12) + //FTD_PREEMB', 'N',  12, 02 (58)
                          fPadR (FieldByName('DET_TIPPRE').AsString , 01) +                                            //FTD_TIPPRE', 'C',  01, 00 (59)
                          fPadR (FieldByName('DET_PRVTIN').AsString , 50) +                                            //FTD_CAMLVE', 'C',  50, 00 (60)
                          fPadR (FieldByName('DET_PRCTIN').AsString , 50) +                                            //FTD_CAMLCU', 'C',  50, 00 (61)
                          fPadR (''                                 , 01) +                                            //FTD_INCPIS', 'C',  01, 00 (62)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_DESCON').AsFloat),',','.') , 12) + //FTD_DESCON', 'N',  12, 02 (63)
                          fPadR (FieldByName('DET_PROEMB').AsString , 01) +                                            //FTD_PROEMB', 'L',  01, 00 (64)
                          fPadR (FieldByName('DET_SERIE_').AsString , 03) +                                            //FTD_SERIE_', 'C',  03, 00 (65)
                          fPadR (IIF((SameText(FieldByName('DET_TIP_FC').AsString, 'F')) And (SameText(FieldByName('DET_ORIDOC').AsString, 'V')),
                                     'XXXXXXXX', EmptyStr), 08);                                                            //FTD_CODCON', 'C',  08, 00 (66)

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************LB*}
          lstTexto.Add(strTransacao);

          Next;
        End;
      End;

      lstTexto.SaveToFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);

    End;

  Finally
    FreeAndNil(qryNotDet);
    FreeAndNil(lstTexto);
  End;

end;

procedure TfrmExpAutSin.pGeraArqDelNotDet;
  Var
    strSQL      : String;
    strTransacao: String;
    strNomArq   : String;
    strDtaCad   : String;
    strDtaDel   : String;
    fltUnitar   : Double;
    fltTotIte   : Double;
    lstTexto    : TStringList;
    qryNotDet   : TUniQuery;
begin
  Try
    qryNotDet := fCriaQuery(nil);

    strNomArq := 'DELFTD.TXT';

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  0.00 AS DET_TOTFRE, '; //Nao enviar o valor do frete
    strSQL := strSQL + '  D.DET_TOTITE + D.DET_TOTFRE AS DET_TOTITE, ';//O valor do frete estara dissolvido nos produtos
    strSQL := strSQL + '  D.* ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  DEL_NOTDET D ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + ' (LOCATE(D.DET_ESPDOC, "TM_ML_PR_") <= 0) AND   ';
    strSQL := strSQL + '  D.DET_CODEMP = :CODEMP AND  ';
    strSQL := strSQL + ' (D.DTADEL BETWEEN :DTAINI AND :DTAFIN) AND ';
    strSQL := strSQL + '  D.DET_CODITE <> :ITESER AND ';
    strSQL := strSQL + '  D.DET_CODITE <> :SERTER AND ';
    strSQL := strSQL + '  D.DET_QTDITE > 0 AND                          ';
    strSQL := strSQL + '  IFNULL(D.DET_PROEMB, "") <> "S" ';
    strSQL := strSQL + '  AND (D.DET_CLAFIS >= 5000 OR IFNULL(D.DET_ORIDOC, "") = "D" OR IFNULL(D.DET_ORIDOC, "") = "V") ';

    If Not chkNF.Checked Then
    Begin
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "NF" ';
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "EL" ';
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "D1" ';
    End;

    If Not chkIF.Checked Then
    Begin
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "IF" ';
      strSQL := strSQL + '  AND D.DET_ESPDOC <> "IV" ';
    End;
    
    strSQL := strSQL + 'ORDER BY D.DET_TIP_FC ';

    With qryNotDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('ITESER').AsString := fCfgSis('ITESER');
      ParamByName('SERTER').AsString := fCfgSis('SERTER');
      Open;
    End;

    If Not qryNotDet.IsEmpty Then
    Begin

      If Not( FileExists( fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq ) ) Then
        lstTexto := TStringList.Create
      Else
      Begin
        lstTexto := TStringList.Create;
        lstTexto.LoadFromFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);
      End;

      {**************************}
      {* TRANSAÇÃO DO ARQUIVO   *}
      {***********************LB*}
      With qryNotDet Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          If fEmptyStr(FieldByName('DET_DTAENT').AsString) Then
            strDtaCad := ''
          Else
            strDtaCad  := FormatDateTime('yyyy',FieldByName('DET_DTAENT').AsDateTime) +
                          FormatDateTime('mm',FieldByName('DET_DTAENT').AsDateTime)   +
                          FormatDateTime('dd',FieldByName('DET_DTAENT').AsDateTime);

          If fEmptyStr(FieldByName('DTADEL').AsString) Then
            strDtaDel := ''
          Else
            strDtaDel  := FormatDateTime('yyyy',FieldByName('DTADEL').AsDateTime) +
                          FormatDateTime('mm',FieldByName('DTADEL').AsDateTime)   +
                          FormatDateTime('dd',FieldByName('DTADEL').AsDateTime);

          fltUnitar := (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat) / FieldByName('DET_QTDITE').AsFloat;
          fltTotIte := (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat);

          strTransacao := fPadR (FieldByName('DET_NUMDOC').AsString , 06) +                                            //FTD_NUMDOC', 'C',  06, 00 (01)
                          fPadR (strDtaCad                          , 08) +                                            //FTD_DTAENT', 'D',  08, 00 (02)
                          fPadR (FieldByName('DET_ESPDOC').AsString , 02) +                                            //FTD_ESPDOC', 'C',  02, 00 (03)
                          fPadR (FieldByName('DET_CONPAG').AsString , 38) +                                            //FTD_CNDPAG', 'C',  38, 00 (04)

                          fPadR (IIF((SameText(FieldByName('DET_TIP_FC').AsString, 'F')) And (SameText(FieldByName('DET_ORIDOC').AsString, 'V')),
                                     fGetClienteConsumidor, FieldByName('DET_CODCLI').AsString), 08) +                     //FTD_CODCLI', 'C',  08, 00 (05)

                          fPadR (''                                 , 03) +                                            //FTD_CODATI', 'C',  03, 00 (06)
                          fPadR (FieldByName('DET_ESTADO').AsString , 02) +                                            //FTD_ESTADO', 'C',  02, 00 (07)
                          fPadR (FieldByName('DET_CODITE').AsString , 14) +                                            //FTD_CODITE', 'C',  14, 00 (08)
                          fPadR (FieldByName('DET_DESCRI').AsString , 57) +                                            //FTD_DESCRI', 'C',  57, 00 (09)
                          fPadR (FieldByName('DET_UNIDAD').AsString , 02) +                                            //FTD_UNIDAD', 'C',  02, 00 (10)
                          fPadR (FieldByName('DET_CODMAR').AsString , 03) +                                            //FTD_CODMAR', 'C',  03, 00 (11)
                          fPadR (FieldByName('DET_FORITE').AsString , 08) +                                            //FTD_CODFOR', 'C',  08, 00 (12)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_QTDITE').AsFloat),',','.') , 12) + //FTD_QTDITE', 'N',  12, 03 (13)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00', fltUnitar),',','.') , 12)                        + //FTD_UNITAR', 'N',  12, 02 (14)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00', fltTotIte),',','.') , 12)                        + //FTD_TOTITE', 'N',  12, 02 (15)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTCUS').AsFloat),',','.') , 12) + //FTD_TOTCUS', 'N',  12, 02 (16) )
                          fPadR (''                                 , 03) +                                            //FTD_CODARE', 'C',  03, 00 (17)
                          fPadR (FieldByName('DET_CODREP').AsString , 03) +                                            //FTD_CODREP', 'C',  03, 00 (18)
                          fPadR (FieldByName('DET_CODVEN').AsString , 03) +                                            //FTD_CODVEN', 'C',  03, 00 (19)
                          fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PERCOM').AsFloat),',','.'), 05), 05) + //FTD_PERCOM', 'N',  05, 02 (20)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTCOM').AsFloat),',','.') , 12) + //FTD_TOTCOM', 'N',  12, 02 (21)
                          fPadR (FieldByName('DET_CLAFIS').AsString , 04) +                                            //FTD_CLAFIS', 'C',  04, 00 (22)
                          fPadR (FieldByName('DET_CODFIS').AsString , 03) +                                            //FTD_CODFIS', 'C',  03, 00 (23)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALIPI').AsFloat),',','.') , 12) + //FTD_VALIPI', 'N',  12, 02 (24)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASIPI').AsFloat),',','.') , 12) + //FTD_BASIPI', 'N',  12, 02 (25)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALICM').AsFloat),',','.') , 12) + //FTD_VALICM', 'N',  12, 02 (26)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASICM').AsFloat),',','.') , 12) + //FTD_BASICM', 'N',  12, 02 (27)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALRET').AsFloat),',','.') , 12) + //FTD_VALRET', 'N',  12, 02 (28)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_BASRET').AsFloat),',','.') , 12) + //FTD_BASRET', 'N',  12, 02 (29)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VLRCON').AsFloat),',','.') , 12) + //FTD_VALBRU', 'N',  12, 02 (30)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTPES').AsFloat),',','.') , 12) + //FTD_TOTPES', 'N',  12, 02 (31)
                          fPadR (''                                 , 05) +                                            //FTD_NUMLOT', 'C',  05, 00 (32)
                          fPadR (FieldByName('DET_CODDIV').AsString , 08) +                                            //FTD_PROFIS', 'C',  08, 00 (33)
                          fPadR (''                                 , 06) +                                            //FTD_NUMORC', 'C',  06, 00 (34)
                          fPadR (FieldByName('DET_JAFATU').AsString , 01) +                                            //FTD_JAFATU', 'L',  01, 00 (35)
                          fPadR (FieldByName('DET_TIPFAT').AsString , 02) +                                            //FTD_TIPFAT', 'C',  02, 00 (36)
                          fPadR (FieldByName('DET_NUMFAT').AsString , 06) +                                            //FTD_NUMFAT', 'C',  06, 00 (37)
                          fPadR (FieldByName('DET_DTAFAT').AsString , 08) +                                            //FTD_DTAFAT', 'D',  08, 00 (38)
                          fPadR (FieldByName('DET_VENFAT').AsString , 03) +                                            //FTD_VENFAT', 'C',  03, 00 (39)
                          fPadR (FieldByName('DET_CNDFAT').AsString , 38) +                                            //FTD_CNDFAT', 'C',  38, 00 (40)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_VALFAT').AsFloat),',','.') , 12) + //FTD_VALFAT', 'N',  12, 02 (41)
                          fPadR ('0.00'                             , 12) +                                            //FTD_DESESP', 'N',  12, 02 (42)
                          fPadR (''                                 , 01) +                                            //FTD_DIGCLA', 'C',  01, 00 (43)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_UNIORI').AsFloat),',','.') , 12) + //FTD_UNIANT', 'N',  12, 02 (44)
                          fPadR (FieldByName('DET_CODEMP').AsString , 03) +                                            //FTD_NUMLOJ', 'C',  03, 00 (45)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_TOTMED').AsFloat),',','.') , 12) + //FTD_TOTMED', 'N',  12, 02 (46)
                          fPadR (''                                 , 03) +                                            //FTD_CODECF', 'C',  03, 00 (47)
                          fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_ALQICM').AsFloat),',','.'), 06), 06) + //FTD_ALQICM', 'N',  06, 02 (48)
                          fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_ALQIPI').AsFloat),',','.'), 06), 06) + //FTD_ALQIPI', 'N',  06, 02 (49)
                          fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PERBAS').AsFloat),',','.'), 06), 06) + //FTD_PERBAS', 'N',  06, 02 (50)
                          fPadR (RightStr(AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PERRED').AsFloat),',','.'), 06), 06) + //FTD_PERRED', 'N',  06, 02 (51)
                          fPadR (FieldByName('DET_IDEPRO').AsString , 03) +                                            //FTD_IDEPRO', 'C',  03, 00 (52)
                          fPadR (FieldByName('DET_ITETIN').AsString , 18) +                                            //FTD_ITETIN', 'C',  18, 00 (53)
                          fPadR (FieldByName('DET_ITECHA').AsString , 08) +                                            //FTD_ITECHA', 'C',  08, 00 (54)
                          fPadR (FieldByName('DET_DESCOR').AsString , 15) +                                            //FTD_DESCOR', 'C',  15, 00 (55)
                          fPadR (FieldByName('DET_TIPEMB').AsString , 02) +                                            //FTD_TIPEMB', 'C',  02, 00 (56)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_QTDEMB').AsFloat),',','.') , 12) + //FTD_QTDEMB', 'N',  12, 02 (57)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_PREEMB').AsFloat),',','.') , 12) + //FTD_PREEMB', 'N',  12, 02 (58)
                          fPadR (FieldByName('DET_TIPPRE').AsString , 01) +                                            //FTD_TIPPRE', 'C',  01, 00 (59)
                          fPadR (FieldByName('DET_PRVTIN').AsString , 50) +                                            //FTD_CAMLVE', 'C',  50, 00 (60)
                          fPadR (FieldByName('DET_PRCTIN').AsString , 50) +                                            //FTD_CAMLCU', 'C',  50, 00 (61)
                          fPadR (''                                 , 01) +                                            //FTD_INCPIS', 'C',  01, 00 (62)
                          fPadR (AnsiReplaceStr(FormatFloat('0.00',FieldByName('DET_DESCON').AsFloat),',','.') , 12) + //FTD_DESCON', 'N',  12, 02 (63)
                          fPadR (FieldByName('DET_PROEMB').AsString , 01) +                                            //FTD_PROEMB', 'L',  01, 00 (64)
                          fPadR (FieldByName('DET_SERIE_').AsString , 03) +                                            //FTD_SERIE_', 'C',  03, 00 (65)
                          fPadR (IIF((SameText(FieldByName('DET_TIP_FC').AsString, 'F')) And (SameText(FieldByName('DET_ORIDOC').AsString, 'V')),
                                     'XXXXXXXX', EmptyStr), 08) +                                                      //FTD_CODCON', 'C',  08, 00 (66)
                          fPadR (strDtaDel                          , 08);                                             //    DTADEL', 'D',  08, 00 (67)

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************LB*}
          lstTexto.Add(strTransacao);

          Next;
        End;
      End;

      lstTexto.SaveToFile(fraPathExpAutSin.edtDirectory.text + '\' +  strNomArq);

    End;

  Finally
    FreeAndNil(qryNotDet);
    FreeAndNil(lstTexto);
  End;

end;

function TfrmExpAutSin.fGetClienteConsumidor: String;
  Var
    qryGenCli: TUniQuery;
begin
  {************************************}
  { PEGA O PRIMEIRO CLIENTE CONSUMIDOR }
  {*********************************JB*}
  qryGenCli := fCriaQuery;

  With qryGenCli Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT                                  ');
    SQL.Add('  CLI_CODCLI AS CODCLI                  ');
    SQL.Add('FROM                                    ');
    SQL.Add('  CADCLI                                ');
    SQL.Add('WHERE                                   ');
    SQL.Add('  CLI_NOMCLI LIKE "%CONSUMIDOR%" OR     ');
    SQL.Add('  CLI_NOMCLI LIKE "%BALCAO%" OR         ');
    SQL.Add('  CLI_NOMCLI LIKE "%BALCÃO%"            ');
    SQL.Add('LIMIT 1                                 ');
    Open;

    Result := FieldByName('CODCLI').AsString;

  End;

  FreeAndNil(qryGenCli);
end;

end.


