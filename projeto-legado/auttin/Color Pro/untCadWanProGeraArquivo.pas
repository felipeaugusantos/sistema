{*************************************************************}
{*         >>>>>>>>>>>>>> ATENÇÃO <<<<<<<<<<<<<<<            *}
{* NO LAYOUT, OS PREÇOS TEM OS SEGUINTES SIGNIFICADOS        *}
{* PREÇO CUSTO/VENDA CONCENTRADO: USADO PARA TODAS AS LINHAS *}
{* APENAS COMO CONCENTRADO                                   *}
{*                                                           *}
{* PREÇO CUSTO/VENDA DILUIDO/2:1: USADO COMO DILUIDO DAS     *}
{* LINHAS NORMAIS E DILUIDAS COM CATALISADOR 2:1             *}
{*                                                           *}
{* PREÇO CUSTO/VENDA DILUIDO/4:1: USADO COMO DILUIDO DAS     *}
{* LINHAS DILUIDAS COM CATALISADOR 4:1                       *}
{**********************************************************MV*}
unit untCadWanProGeraArquivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask,
  DirectoryEditFocus, DB, UniClientDataSet, EditFocus, Uni, UniDataSetProvider,
  StrUtils, AppEvnts, BitBtnLockedIncrem, MemDS, DBAccess,
  Datasnap.Provider, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmCadWanProGeraArquivo = class(TfrmPai)
    Panel1: TPanel;
    Label7: TLabel;
    pgbLayer: TProgressBar;
    pgbCores: TProgressBar;
    Label3: TLabel;
    Label4: TLabel;
    pgbPigmentos: TProgressBar;
    cdsTonner: TUniClientDataSet;
    cdsTonnerLinha: TStringField;
    cdsTonnerBase: TStringField;
    cdsTonnerDescricao: TStringField;
    cdsTonnerStatus: TStringField;
    cdsTonnerPreco: TFloatField;
    cdsTonnerPesoEsp: TFloatField;
    cdsTonnerTamEmbala: TFloatField;
    cdsColors: TUniClientDataSet;
    qryLayer: TUniQuery;
    dspCadBas: TUniDataSetProvider;
    qryCadWan: TUniQuery;
    pnlGeral: TPanel;
    rdbGerBas: TRadioButton;
    rdbGerFor: TRadioButton;
    qryCadBas: TUniQuery;
    btnConfirmaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
  private
    { Private declarations }
    function fTamArq(strNomArq: String): Integer;

    function fRetornaPreco(fltPerCen, fltPesEsp, fltEmbala, fltPrePig,
      fltTotalPerVolume: Double; Var fltVolumeMassa: Double): Double;

    function fRetornaPreco11(fltPerCen, fltPesEsp, fltEmbala, fltPrePig,
      fltTotalPerVolume: Double; Var fltVolumeMassa: Double): Double;

    function fRetornaPrecoPU(fltPerCen, fltPesEsp, fltEmbala, fltPrePig,
      fltTotalPerVolume, fltQtdProduzir: Double; var fltVolumeMassa: Double): Double;

    procedure pRetornaInfoLinha(strLinha: String; Var strLinDil, strBasDil: String;
      Var fltFatBas, fltPerDil: Double);

    function fRetDescLinha(strCodigo: String): String;

    procedure pApagaTemporaria;
    procedure pCarregaPigmentos;
    procedure pCarregaFormulacoes;

  public
    { Public declarations }
  end;

var
  frmCadWanProGeraArquivo: TfrmCadWanProGeraArquivo;

implementation

uses untFuncoes,  untFuncoesSimples, untConstantes, untWandaPro,
     untIConfTinta, untFuncTinta ;

{$R *.dfm}

procedure TfrmCadWanProGeraArquivo.btnConfirmaDadosClick(Sender: TObject);
  Const
    TAM_EMBALAGEM_2POR1_BT100 = 618;
    TAM_EMBALAGEM_2POR1 = 640;
    TAM_EMBALAGEM_4POR1 = 750;
  Var
    txtColors: TextFile;
    strLinha: String;
    strLinPro: String; // cód da linha de produtos
    strCodCor: String; // código de cor
    strCodAkz: String; // código Akzo
    strDesCor: String; // descrição de cor
    strMontad: String; // montadora
    strVerCor: String; // versão da cor
    strAnoIni: String; // ano inicial
    strAnoFin: String; // ano final
    strDtaCad: String; // Data de cadastro
    strAltCor: String; // alternativa da cor

    strLinWan: String;
    strLinDil: String;
    strBasDil: String;
    fltFCuWan: Double;

    {********************************************}
    {* VARIAVEIS USADAS PARA CALCULO DO PIGMENTO*}
    {*****************************************MV*}
    fltPerVolume: Double;
    fltVolumeLitro: Double;
    fltVolumeMassa: Double;
    fltPesoBase: Double;
    fltPreCusCon: Double;
    fltPreVenCon: Double;
    fltPreCusDil: Double;
    fltPreVenDil: Double;
    fltPreCusDil4Por1: Double;
    fltPreVenDil4Por1: Double;

    fltVolumeCon: Double;
    fltVolumeDil: Double;
    fltVolumeDil4Por1: Double;

    fltPerCen: Double;

    fltTotDiluido: Double;
    fltTotDiluido2: Double;
    fltTotDiluido4: Double;
    fltTotConcent: Double;

    fltTamEmb2Por1: Double;
    fltTamEmb4Por1: Double;
    fltVolTinner2Por1: Double;
    fltVolTinner4Por1: Double;

    arrLinPig: Array[1..20] Of String;
    arrCodPig: Array[1..20] Of String;
    arrQtdPigCon: Array[1..20] Of Double;
    arrQtdPigDil: Array[1..20] Of Double;
    arrQtdPigDil4Por1: Array[1..20] Of Double;
    arrPorcen: Array[1..20] Of Double;
    intContador: Integer;
    intIdxTxt: Integer;
    intQtdFormulas: Integer;

    fltFatBas: Double;
    fltPerDil: Double;

    strLinAnterior: String;
    strCodAnterior: String;
    strDesCorAnterior: String;
    strAltAnterior: String;
    strPatWan: String;
    strMsgDil: String;
    strVerCorAnterior: String;

    qryWanPro_CodUni: TUniQuery;
    qryCadNfm: TUniQuery;

    qryCadLin: TUniQuery;


    intCamada: Integer;

    fltEmb4por1: Double;
    fltPerDil4Por1: Double;

    fltEmb2Por1: Double;

    fltDivisorEmb2por1: Double;
    fltMultiplicadorEmb2por1: Double;

    fltDivisorEmb4por1: Double;
    fltMultiplicadorEmb4por1: Double;

    blnCalcula2Por1: Boolean;

    blnApagar: Boolean;
    conf: IConfTinta;

    fltPerThinner2: Double;
    fltPerThinner4: Double;
    fltSomaR2: Double;
    fltSomaR4: Double;
    fltPEThinner: Double;
    strMD5: String;
begin
  inherited;
  conf      := fGetConfTinta('WCP');
  strPatWan := conf.fGet('PATWAN');

  If (Not FileExists(strPatWan + '\Tonners.txt')) Then
  Begin
    fMensagem('', 'O Arquivo ' + strPatWan + '\Tonners.txt não existe', ['&Ok']);
    Exit;
  End;

  If (Not FileExists(strPatWan + '\Layer.txt')) Then
  Begin
    fMensagem('', 'O Arquivo ' + strPatWan + '\Layer.txt não existe', ['&Ok']);
    Exit;
  End;

  If (Not FileExists(strPatWan + '\Colors.txt')) Then
  Begin
    fMensagem('', 'O Arquivo ' + strPatWan + '\Colors.txt não existe', ['&Ok']);
    Exit;
  End;



  strLinWan := conf.fGet('LINWAN');

  strMsgDil := '';


  If (Pos('012', strLinWan) > 0) And (fEmptyStr(conf.fGet('BPAPB_10080'))) Then //fEmptyStr(fArqIniTinta(0, 'COLOR PRO', 'BD1WAN', ''))
  Begin
    strMsgDil := strMsgDil + 'Linha (012): Autobase Plus Baseline 100:80';
  End;

  If (Pos('019', strLinWan) > 0) And (fEmptyStr(conf.fGet('BD1ABS_BASELINE'))) Then //fEmptyStr(fArqIniTinta(0, 'COLOR PRO', 'BD1WAN', ''))
  Begin
    strMsgDil := strMsgDil + 'Linha (019): Autobase Plus Baseline 100:50,';
  End;


  If (Pos('004', strLinWan) > 0) And (fEmptyStr(conf.fGet('BD1WAN'))) Then //fEmptyStr(fArqIniTinta(0, 'COLOR PRO', 'BD1WAN', ''))
  Begin
    strMsgDil := strMsgDil + 'Linha (004): Wandabase HS,';
  End;

  If (Pos('001', strLinWan) > 0) And (fEmptyStr(conf.fGet('BD1ABS_100_50'))) Then //fEmptyStr(fArqIniTinta(0, 'COLOR PRO', 'BD1ABS_100_50', ''))
  Begin
    strMsgDil := strMsgDil + 'Linha (001): Autobase 100:50,';
  End;

  If (Pos('014', strLinWan) > 0) And (fEmptyStr(conf.fGet('BD1ABS_100_80'))) Then //fEmptyStr(fArqIniTinta(0, 'COLOR PRO', 'BD1ABS_100_80', ''))
  Begin
    strMsgDil := strMsgDil + 'Linha (014): Autobase 100:80,';
  End;

  If (Pos('008', strLinWan) > 0) And (fEmptyStr(conf.fGet('BD1PU_HS'))) Then //fEmptyStr(fArqIniTinta(0, 'COLOR PRO', 'BD1PU_HS', ''))
  Begin
    strMsgDil := strMsgDil + 'Linha (008): Wanda PU HS,';
  End;

  If (Pos('058', strLinWan) > 0) And (fEmptyStr(conf.fGet('BD1PU_MS'))) Then //fEmptyStr(fArqIniTinta(0, 'COLOR PRO', 'BD1PU_MS', ''))
  Begin
    strMsgDil := strMsgDil + 'Linha (058): Wanda PU MS,';
  End;

  If (Pos('019', strLinWan) > 0) And (fEmptyStr(conf.fGet('BD1ABS_BASELINE'))) Then //fEmptyStr(fArqIniTinta(0, 'COLOR PRO', 'BD1ABS_BASELINE', ''))
  Begin
    strMsgDil := strMsgDil + 'Linha (019): Autobase Plus Baseline 100:50,';
  End;

  If (Pos('016', strLinWan) > 0) And (fEmptyStr(conf.fGet('BD1BT120'))) Then //fEmptyStr(fArqIniTinta(0, 'COLOR PRO', 'BD1BT120', ''))
  Begin
    strMsgDil := strMsgDil + 'Linha (016): BT120,';
  End;

  If (Pos('059', strLinWan) > 0) And (fEmptyStr(conf.fGet('BD1BT90'))) Then //fEmptyStr(fArqIniTinta(0, 'COLOR PRO', 'BD1BT90', ''))
  Begin
    strMsgDil := strMsgDil + 'Linha (016): BT90,';
  End;

  If (Pos('013', strLinWan) > 0) And (fEmptyStr(conf.fGet('BD1BT100'))) Then //fEmptyStr(fArqIniTinta(0, 'COLOR PRO', 'BD1BT100', ''))
  Begin
    strMsgDil := strMsgDil + 'Linha (013): BT100,';
  End;

  If (Pos('037', strLinWan) > 0) And (fEmptyStr(conf.fGet('BD1BT80'))) Then //fEmptyStr(fArqIniTinta(0, 'COLOR PRO', 'BD1BT80', ''))
  Begin
    strMsgDil := strMsgDil + 'Linha (037): BT80,';
  End;

  If (Not fEmptyStr(strMsgDil)) Then
  Begin
    strMsgDil := Copy(strMsgDil, 1, Length(strMsgDil));
    If fMensagem('', 'As seguintes linhas não estão com o diluente configurado: ' + strMsgDil + #13#10 + 'Deseja continuar?', ['&Sim', '&Não']) = 2 Then
      Exit;
  End;

  btnConfirmaDados.Enabled := False;
  btnSair.Enabled          := False;

  blnApagar := False;
  If fMensagem('ATENÇÃO!', 'Deseja manter as cores e bases existentes?', ['&Sim', '&Não'], 2) = 2 Then
  Begin
    blnApagar := True;
  End;

  //**************************************//
  // -> CONEXAO COM O BANCO               //
  //**************************************/
  pCarregaPigmentos;

  If (rdbGerBas.Checked) Then
  Begin
    cdsTonner.Close;
    fMensagem('', 'Geração concluída!', ['&Ok']);
    Exit;
  End;

  pCarregaFormulacoes;

  // Tabela criada para armazenar a descrição da linha para utilizar nas configurações de etiqueta.

  qryCadLin := fCriaQuery(Self);

  Try
    pZapTable('WANPRO_CADLIN');
    qryCadLin.Close;
    qryCadLin.SQL.Text := ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("1"  , "AUTOBASE PLUS 100:50");          '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("4"  , "WANDABASE HS");                  '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("6"  , "WANDALAC");                      '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("8"  , "WANDA PU HS");                   '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("9"  , "WANDACAR");                      '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("11" , "SINGLE STAGE CONVERTER");        '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("12" , "AUTOBASE PLUS BASELINE 100:80"); '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("13" , "AUTOCOAT BT100");                '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("14" , "AUTOBASE PLUS 100:80");          '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("15" , "AUTOCOAT BT110");                '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("16" , "AUTOCOAT BT120");                '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("17" , "AUTOCOAT BT130");                '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("19" , "AUTOBASE PLUS BASELINE 100:50"); '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("27" , "AUTOWAVE MM");                   '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("58" , "WANDA PU MS");                   '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("59" , "AUTOCOAT BT90");                 '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("72" , "TECH FLEET PU");                 '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("74" , "TECH FLEET EPOXY");              '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("75" , "TECH FLEET SINTETICO");          '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("76" , "TECH FLEET LACA");               '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("12" , "AUTOBASE PLUS BASELINE 100:80"); '+
                          ' INSERT INTO WANPRO_CADLIN (WAN_CODLIN, WAN_NOMLIN )  VALUES ("19" , "AUTOBASE PLUS BASELINE 100:50"); ';
    qryCadLin.ExecSQL;
  Finally
    FreeAndNil(qryCadLin);
  End;

  If blnApagar Then
    pZapTable('WANPRO_CODUNI');

  qryWanPro_CodUni := fCriaQuery(Self);
  qryWanPro_CodUni.SQL.Add('SELECT * FROM WANPRO_CODUNI LIMIT 0');
  qryWanPro_CodUni.Open;

  If blnApagar Then
    pZapTable('WANPRO_CADWAN');

  qryCadWan.Open;

  AssignFile(txtColors, strPatWan + '\Colors.txt');
  Reset(txtColors);

  If (blnApagar) Then
    intQtdFormulas    := 1
  Else
    intQtdFormulas := StrToInt(fAtualizaProCod('WANPRO_CADWAN'));
    
  pgbCores.Position := 0;
  pgbCores.Max      := fTamArq(strPatWan + '\Colors.txt');

  fltFCuWan := fStrToFloat(AnsiReplaceStr(conf.fGet('FVEWAN'), '.', ',')); //fArqIniTinta(0, 'COLOR PRO', 'FVEWAN', '0')

  strLinAnterior := '';
  strCodAnterior := '';
  strAltAnterior := '';
  strDesCorAnterior := '';
  strVerCorAnterior := '';


  Try
    While (Not Eof(txtColors)) Do
    Begin
      ReadLn(txtColors, strLinha);

      strLinPro := Trim(Copy(strLinha, 001, 010));
      strCodCor := Trim(Copy(strLinha, 011, 022));
      strCodAkz := Trim(Copy(strLinha, 033, 021));
      strDesCor := Trim(Copy(strLinha, 054, 041));
      strMontad := Trim(Copy(strLinha, 095, 030));
      strVerCor := Trim(Copy(strLinha, 125, 001));
      strAnoIni := Trim(Copy(strLinha, 126, 011));
      strAnoFin := Trim(Copy(strLinha, 137, 011));
      strDtaCad := Trim(Copy(strLinha, 148, 009));
      Insert('/', strDtaCad, 3);
      Insert('/', strDtaCad, 6);

      strAltCor := Trim(Copy(strLinha, 157, 006));

      If (Pos(fStrZero(strLinPro, 3), strLinWan) <= 0) Then
      Begin
        pgbCores.StepBy(Length(strLinha));
        Continue;
      End;

      Try
        qryWanPro_CodUni.Append;
        qryWanPro_CodUni.FieldByName('WANPRO_LINHA_').AsString := strLinPro;
        qryWanPro_CodUni.FieldByName('WANPRO_CODUNI').AsString := strCodCor;
        qryWanPro_CodUni.FieldByName('WANPRO_CODAKZ').AsString := strCodAkz;
        qryWanPro_CodUni.FieldByName('WANPRO_ALTERN').AsString := strAltCor;
        qryWanPro_CodUni.ParamByName('WANPRO_VERCOR').AsString := strVerCor; //Versao da Cor
        qryWanPro_CodUni.Post;
      Except
        On E: EUniError Do
        Begin
          If E.ErrorCode <> ERROR_PRIMARY_KEY_INSERT Then
          Begin
            Raise;
          End
          Else
            qryWanPro_CodUni.Cancel;
        End;

        On E: Exception Do
        Begin
          Raise;
        End;
      End;

      If (strLinAnterior    = strLinPro) And
         (strCodAnterior    = strCodAkz) And
         (strDesCorAnterior = strDesCor) And
         (strAltAnterior    = strAltCor) And
         (strVerCorAnterior = strVerCor) Then
      Begin
        pgbCores.StepBy(Length(strLinha));
        Continue;
      End;

      strLinAnterior    := strLinPro;
      strCodAnterior    := strCodAkz;
      strAltAnterior    := strAltCor;
      strDesCorAnterior := strDesCor;
      strVerCorAnterior := strVerCor;


      pRetornaInfoLinha(strLinPro, strLinDil, strBasDil, fltFatBas, fltPerDil);
      If (Pos(fStrZero(strLinPro,2), '08_58_59_13') > 0) Then
        fltFatBas := 1;

      For intCamada := 1 To 3 Do
      Begin
        With qryLayer Do
        Begin
          SQL.Clear;
          {********************************************}
          {* Linha 11 tem o cálculo em cima           *}
          {* dos valores da linha 1                   *}
          {*****************************************NC*}
          If (Pos(fStrZero(strLinPro,2), '11_') > 0) Then
          Begin
            SQL.Add('SELECT');
            SQL.Add('  "11" Linha, CodAkazo, NumCamadas, CodPigmento,');
            SQL.Add('  Percentual, Versao, Alternativa');
            SQL.Add('FROM');
            SQL.Add('  TMP_LAYER ');
            SQL.Add('WHERE');
            SQL.Add('  Linha = :Linha AND');
            SQL.Add('  CodAkazo = :CodAkazo AND');
            SQL.Add('  Alternativa = :Alternativa AND');
            SQL.Add('  NumCamadas = :CAMADA AND');
            SQL.Add('  Versao =  :VersaoCor');
            ParamByName('Linha').AsString := '1'
          End
          Else
          Begin
            SQL.Add('SELECT');
            SQL.Add('  *');
            SQL.Add('FROM');
            SQL.Add('  TMP_LAYER ');
            SQL.Add('WHERE');
            SQL.Add('  Linha = :Linha AND');
            SQL.Add('  CodAkazo = :CodAkazo AND');
            SQL.Add('  Alternativa = :Alternativa AND');
            SQL.Add('  NumCamadas = :CAMADA AND');
            SQL.Add('  Versao     = :VersaoCor');
            ParamByName('Linha').AsString := strLinPro;
          End;
          ParamByName('CodAkazo').AsString := strCodAkz;
          ParamByName('Alternativa').AsString := strAltCor;
          ParamByName('CAMADA').AsInteger := intCamada;
          ParamByName('VersaoCor').AsString := strVerCor;
          Open;
        End;

        If qryLayer.RecordCount = 0 Then
          Break;

        For intContador := Low(arrCodPig) To High(arrCodPig) Do
        Begin
          arrLinPig[intContador] := '';
          arrCodPig[intContador] := '';
          arrQtdPigCon[intContador] := 0.0;
          arrQtdPigDil[intContador] := 0.0;
          arrQtdPigDil4Por1[intContador] := 0.0;
          arrPorcen[intContador] := 0.0;          
        End;

        intContador  := 1;

        fltTotConcent  := 0.0;
        fltTotDiluido  := 0.0;
        fltTotDiluido2 := 0.0;
        fltTotDiluido4 := 0.0;
        fltSomaR2      := 0.0;
        fltSomaR4      := 0.0;
        fltPEThinner   := 0.0;

        {*******************************************}
        {* REALIZA CALCULO DO TOTAL DE % VOLUME    *}
        {****************************************MV*}
        While (Not qryLayer.Eof) Do
        Begin

          If (Not cdsTonner.Locate('Linha;Base',
            VarArrayOf([qryLayer.FieldByName('Linha').AsString, qryLayer.FieldByName('CodPigmento').AsString]), [])) Then
          Begin
            qryLayer.Next;
            Continue;
          End;

          If (Pos(fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '11_') > 0) Then
          begin
            If qryLayer.FieldByName('CodPigmento').AsString <> 'Q065' Then
              fltTotConcent := fltTotConcent + (((qryLayer.FieldByName('Percentual').AsFloat * 100) / (100 - 23))/cdsTonnerPesoEsp.AsFloat);
          end
          Else if (Pos(fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '08_') > 0) Then
          begin
            fltTotConcent := fltTotConcent + (qryLayer.FieldByName('Percentual').AsFloat / cdsTonnerPesoEsp.AsFloat);

            fltSomaR2 := fltSomaR2 + qryLayer.FieldByName('Percentual').AsFloat;
            fltSomaR4 := fltSomaR4 + qryLayer.FieldByName('Percentual').AsFloat;
          end
          Else if cdsTonnerPesoEsp.AsFloat > 0 then
          begin
            fltTotDiluido := fltTotDiluido + ((qryLayer.FieldByName('Percentual').AsFloat * fltFatBas) / cdsTonnerPesoEsp.AsFloat);
            fltTotConcent := fltTotConcent + (qryLayer.FieldByName('Percentual').AsFloat / cdsTonnerPesoEsp.AsFloat);
          end;
          qryLayer.Next;
        End;

        If (Pos(fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '08_') > 0) Then
        begin
          If (Not fEmptyStr(strLinDil)) And
             (cdsTonner.Locate('Linha;Base', VarArrayOf([IntToStr(StrToInt(strLinDil)), strBasDil]), [])) Then
            fltPEThinner := cdsTonnerPesoEsp.AsFloat;

          fltSomaR2 := fltSomaR2 + 23.076;
          fltSomaR4 := fltSomaR4 + 25.000;

          fltPerThinner2    := (100 * 23.076) / fltSomaR2;
          fltPerThinner2    := (fltPerThinner2 * fltTotConcent * fltPEThinner) / (100 - fltPerThinner2);

          fltPerThinner4    := (100 * 25.000) / fltSomaR4;
          fltPerThinner4    := (fltPerThinner4 * fltTotConcent * fltPEThinner) / (100 - fltPerThinner4);

          qryLayer.First;
          While not qryLayer.Eof Do
          Begin
            If (Not cdsTonner.Locate('Linha;Base',
              VarArrayOf([qryLayer.FieldByName('Linha').AsString, qryLayer.FieldByName('CodPigmento').AsString]), [])) Then
            Begin
              qryLayer.Next;
              Continue;
            End;

            fltTotDiluido2 := fltTotDiluido2 + (qryLayer.FieldByName('Percentual').AsFloat / cdsTonnerPesoEsp.AsFloat);
            fltTotDiluido4 := fltTotDiluido4 + (qryLayer.FieldByName('Percentual').AsFloat / cdsTonnerPesoEsp.AsFloat);
            qryLayer.Next;
          End;
          
          fltTotDiluido2 := fltTotDiluido2 + (fltPerThinner2/fltPEThinner);
          fltTotDiluido4 := fltTotDiluido4 + (fltPerThinner4/fltPEThinner);
        end;        

        If (Pos(fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '37_') <= 0) Then
        Begin
          If (Not fEmptyStr(strLinDil))                                                                   And
             (cdsTonner.Locate('Linha;Base', VarArrayOf([IntToStr(StrToInt(strLinDil)), strBasDil]), [])) Then
          Begin
            if cdsTonnerPesoEsp.AsFloat > 0 then
            begin
              fltTotDiluido := fltTotDiluido + (fltPerDil / cdsTonnerPesoEsp.AsFloat);
            end;
          End;
        End;

        qryLayer.First;

        {*******************************************}
        {* REALIZA CALCULO DO PREÇO DILUIDO        *}
        {****************************************MV*}
        fltVolTinner2Por1 := 0;
        fltVolTinner4Por1 := 0;
        fltEmb2por1       := 0;
        fltEmb4por1       := 0;
        fltTamEmb2Por1    := 0;
        fltTamEmb4Por1    := 0;

        While (Not qryLayer.Eof) Do
        Begin
          If (Not cdsTonner.Locate('Linha;Base',
            VarArrayOf([qryLayer.FieldByName('Linha').AsString, qryLayer.FieldByName('CodPigmento').AsString]), [])) Then
          Begin
            qryLayer.Next;
            Continue;
          End;

          {*********************************************}
          {* VERIFICA SE É WANDABASE, AUTOBASE (100:50,*}
          {* 100:80), WANDACAR OU WANDALAC, BT120      *}
          {******************************************MV*}
          If (Pos(fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '01_04_06_09_11_12_14_19_16_37_15_17_27_') > 0) Then
          Begin

            fltPerCen := qryLayer.FieldByName('Percentual').AsFloat;

            If (Pos(fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '11_') > 0) Then
            Begin
              If qryLayer.FieldByName('CodPigmento').AsString = 'Q065' Then
                fltVolumeMassa := 0
              Else
                fRetornaPreco11(fltPerCen,
                                cdsTonnerPesoEsp.AsFloat,
                                cdsTonnerTamEmbala.AsFloat,
                                cdsTonnerPreco.AsFloat,
                                fltTotConcent,
                                fltVolumeMassa);
            End
            Else
              fRetornaPreco(fltPerCen,
                            cdsTonnerPesoEsp.AsFloat,
                            cdsTonnerTamEmbala.AsFloat,
                            cdsTonnerPreco.AsFloat,
                            fltTotConcent,
                            fltVolumeMassa);

            fltVolumeCon := fltVolumeMassa;

            {**********************************************}
            {* WANDALAC, WANDACAR, SINGLE STAGE CONVERTER *}
            {* BT110 E BT130 NÃO TEM DILUIDO.             *}
            {*******************************************MV*}
            If (Pos(fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '01_04_12_14_19_16') > 0) Then
            Begin
              fRetornaPreco(fltPerCen * fltFatBas,
                            cdsTonnerPesoEsp.AsFloat,
                            cdsTonnerTamEmbala.AsFloat,
                            cdsTonnerPreco.AsFloat,
                            fltTotDiluido,
                            fltVolumeMassa);
            End
            Else If (Pos(fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '37_') > 0) Then
            Begin
              fRetornaPrecoPU(fltPerCen * fltFatBas,
                              cdsTonnerPesoEsp.AsFloat,
                              cdsTonnerTamEmbala.AsFloat,
                              cdsTonnerPreco.AsFloat,
                              fltTotDiluido,
                              900*fltFatBas,
                              fltVolumeMassa);
            End
            Else
              fltVolumeMassa := 0.0;

            fltVolumeDil := fltVolumeMassa;

            arrLinPig[intContador]    := qryLayer.FieldByName('Linha').AsString;
            arrCodPig[intContador]    := qryLayer.FieldByName('CodPigmento').AsString;
            arrQtdPigCon[intContador] := fltVolumeCon;
            arrQtdPigDil[intContador] := fltVolumeDil;
            arrPorcen[intContador]    := qryLayer.FieldByName('Percentual').AsFloat;
          End
          Else
          Begin
            {*******************************************}
            {* AQUI SERÃO REALIZADOS OS CÁLCULOS DO    *}
            {* WANDA PU HS E WANDA PU MS               *}
            {* PU MS SÓ TEM 4:1                        *}
            {****************************************MV*}
            If fStrZero(qryLayer.FieldByName('Linha').AsString,2) = '13' Then
            Begin
              fltDivisorEmb2por1 := 1.10;
              fltDivisorEmb4por1 := 1.25;

              fltMultiplicadorEmb2Por1 := 10.00;
              fltMultiplicadorEmb4Por1 := 25.00;

              fltEmb2Por1 := TAM_EMBALAGEM_2POR1_BT100;
              fltEmb4por1 := TAM_EMBALAGEM_4POR1;

              fltTamEmb2Por1 := fltEmb2Por1 / fltDivisorEmb2por1;
              fltTamEmb4Por1 := fltEmb4por1 / fltDivisorEmb4por1;

              fltVolTinner2Por1 := (fltTamEmb2Por1 * fltMultiplicadorEmb2Por1 / 100.0);
              fltVolTinner4Por1 := (fltTamEmb4Por1 * fltMultiplicadorEmb4Por1 / 100.0);
            End
            Else If Pos(fStrZero(qryLayer.FieldByName('Linha').AsString,2), '58_59_') > 0 Then
            Begin
              fltEmb4por1 := TAM_EMBALAGEM_4POR1;
              fltMultiplicadorEmb4Por1 := 20;

              fltVolTinner2Por1 := 0.0;
              fltVolTinner4Por1 := (fltEmb4Por1 * fltMultiplicadorEmb4Por1 / 100.0);

              fltTamEmb2Por1 := 0;
              fltTamEmb4Por1 := fltEmb4por1 - fltVolTinner4Por1;
            End
            Else If fStrZero(qryLayer.FieldByName('Linha').AsString,2) = '08' Then
            Begin
              fltEmb2Por1 := TAM_EMBALAGEM_2POR1;
              fltEmb4por1 := TAM_EMBALAGEM_4POR1;

              fltVolTinner2Por1 := (fltEmb2Por1 * ((100 * 23.076) / fltSomaR2))/100;
              fltVolTinner4Por1 := (fltEmb4Por1 * ((100 * 25.000) / fltSomaR4))/100;
            End;

            fltPerCen    := qryLayer.FieldByName('Percentual').AsFloat;

            {*******************************************}
            {* CÁLCULO DO CONCENTRADO                  *}
            {****************************************MV*}
            fRetornaPrecoPU(fltPerCen,
                            cdsTonnerPesoEsp.AsFloat,
                            cdsTonnerTamEmbala.AsFloat,
                            cdsTonnerPreco.AsFloat,
                            fltTotConcent,
                            900,
                            fltVolumeMassa);

            fltVolumeCon := fltVolumeMassa;

            {*******************************************}
            {* CÁLCULO DO DILUIDO 2:1                  *}
            {****************************************MV*}
            Try
              blnCalcula2Por1 := Pos(fStrZero(qryLayer.FieldByName('Linha').AsString,2), '08_13') > 0;
              fRetornaPrecoPU(IIF(blnCalcula2Por1, fltPerCen, 0),
                                cdsTonnerPesoEsp.AsFloat,
                                cdsTonnerTamEmbala.AsFloat,
                                cdsTonnerPreco.AsFloat,
                                IIF(Pos(fStrZero(qryLayer.FieldByName('Linha').AsString,2), '08_') > 0, fltTotDiluido2, fltTotDiluido),
                                IIF(Pos(fStrZero(qryLayer.FieldByName('Linha').AsString,2), '08_') > 0, fltEmb2Por1, fltTamEmb2Por1),
                                fltVolumeMassa);

              fltVolumeDil := fltVolumeMassa;
            Except
              fltVolumeDil := fltVolumeCon;
            End;

            {*******************************************}
            {* CÁLCULO DO DILUIDO 4:1                  *}
            {****************************************MV*}
            Try
              fRetornaPrecoPU(fltPerCen,
                              cdsTonnerPesoEsp.AsFloat,
                              cdsTonnerTamEmbala.AsFloat,
                              cdsTonnerPreco.AsFloat,
                              IIF(Pos(fStrZero(qryLayer.FieldByName('Linha').AsString,2), '08_') > 0, fltTotDiluido4, fltTotDiluido),
                              IIF(Pos(fStrZero(qryLayer.FieldByName('Linha').AsString,2), '08_') > 0, fltEmb4Por1, fltTamEmb4Por1),
                              fltVolumeMassa);

              fltVolumeDil4Por1 := fltVolumeMassa;
            Except
              fltVolumeDil4Por1 := fltVolumeCon;
            End;


            arrLinPig[intContador]         := qryLayer.FieldByName('Linha').AsString;
            arrCodPig[intContador]         := qryLayer.FieldByName('CodPigmento').AsString;
            arrQtdPigCon[intContador]      := fltVolumeCon;
            arrQtdPigDil[intContador]      := fltVolumeDil;
            arrQtdPigDil4Por1[intContador] := fltVolumeDil4Por1;
            arrPorcen[intContador]         := qryLayer.FieldByName('Percentual').AsFloat;
          End;

          Inc(intContador);
          qryLayer.Next;
        End;

        {*******************************************}
        {* CALCULA O PREÇO E QUANTIDADE DO DILUENTE*}
        {****************************************MV*}
        fltVolumeMassa := 0.0;
        fltVolumeDil4Por1 := 0.0;
        If (Not fEmptyStr(strLinDil))                                                                   And
           (cdsTonner.Locate('Linha;Base', VarArrayOf([IntToStr(StrToInt(strLinDil)), strBasDil]), [])) Then
        Begin

          {*******************************************}
          {* WANDABASE HS, AUTOBASE 100:50 E 100:80  *}
          {****************************************MV*}
          If (Pos(fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '01_04_14_19_16') > 0) Then
          Begin
            fRetornaPreco(fltPerDil,
                          cdsTonnerPesoEsp.AsFloat,
                          cdsTonnerTamEmbala.AsFloat,
                          cdsTonnerPreco.AsFloat,
                          fltTotDiluido,
                          fltVolumeMassa);
          End
          Else If (Pos(fStrZero(qryLayer.FieldByName('Linha').AsString, 2), '37_') > 0) Then
          Begin
            fltVolumeMassa := (900 * fltPerDil / 100) * cdsTonnerPesoEsp.AsFloat;
            fltVolumeMassa := fTruncaFloat(fltVolumeMassa, 1);
          End
          Else If (Pos(fStrZero(qryLayer.FieldByName('Linha').AsString,2), '08_58_59_13') > 0) Then
          Begin
            fRetornaPrecoPU(fltVolTinner2Por1 * cdsTonnerPesoEsp.AsFloat,
                            cdsTonnerPesoEsp.AsFloat,
                            cdsTonnerTamEmbala.AsFloat,
                            cdsTonnerPreco.AsFloat,
                            IIF(Pos(fStrZero(qryLayer.FieldByName('Linha').AsString,2), '08_') > 0, fltTotDiluido2, fltTotDiluido),
                            0.0,
                            fltVolumeMassa);

            fRetornaPrecoPU(fltVolTinner4Por1 * cdsTonnerPesoEsp.AsFloat,
                            cdsTonnerPesoEsp.AsFloat,
                            cdsTonnerTamEmbala.AsFloat,
                            cdsTonnerPreco.AsFloat,
                            IIF(Pos(fStrZero(qryLayer.FieldByName('Linha').AsString,2), '08_') > 0, fltTotDiluido4, fltTotDiluido),
                            0.0,
                            fltVolumeDil4Por1);
          End;

          arrLinPig[intContador]         := strLinDil;
          arrCodPig[intContador]         := strBasDil;
          arrQtdPigCon[intContador]      := 0.0;
          arrQtdPigDil[intContador]      := fltVolumeMassa;
          arrQtdPigDil4Por1[intContador] := fltVolumeDil4Por1;
          arrPorcen[intContador]         := 0.0;
          

        End;

        {*******************************************}
        {* REALIZA CÁLCULO DO PREÇO CONCENTRADO    *}
        {****************************************MV*}
        {*******************************************}
        {* APESAR DE SER UTULIZADAS AS VARIAVEIS   *}
        {* DE --> CUSTO <-- PARA O CALCULO, ESSAS  *}
        {* CONTAS SÃO DO PREÇO DE VENDA. EU PENSA- *}
        {* VA QUE ERA O CUSTO. COMO TENHO QUE MUDAR*}
        {* RAPIDAMENTE, APENAS ATRIBUI OS VALORES  *}
        {* PARA AS VARIAVEIS DE CUSTO E APLIQUEI O *}
        {* FATOR, QUE AGORA É DE CUSTO             *}
        {****************************************MV*}
        //mvfltPreVenCon := fltPreCusCon;
        //mvfltPreVenDil := fltPreCusDil;
        //mvfltPreVenDil4Por1 := fltPreCusDil4Por1;

        //mvfltPreCusCon := fltPreVenCon * fltFCuWan;
        //mvfltPreCusDil := fltPreVenDil * fltFCuWan;
        //mvfltPreCusDil4Por1 := fltPreVenDil4Por1 * fltFCuWan;

        qryCadWan.Append;
        qryCadWan.FieldByName('WAN_CODSEQ').AsString := fStrZero(intQtdFormulas, 6);
        qryCadWan.FieldByName('WAN_LINHA_').AsString := strLinPro;
        qryCadWan.FieldByName('WAN_NOMLIN').AsString := fRetDescLinha(strLinPro);
        qryCadWan.FieldByName('WAN_CODAKZ').AsString := strCodAkz;
        qryCadWan.FieldByName('WAN_ALTERN').AsString := strAltCor;
        qryCadWan.FieldByName('WAN_DESCRI').AsString := AnsiUpperCase(strDesCor);
        qryCadWan.FieldByName('WAN_MONTAD').AsString := AnsiUpperCase(strMontad);
        qryCadWan.FieldByName('WAN_ANOINI').AsString := strAnoIni;
        qryCadWan.FieldByName('WAN_ANOFIN').AsString := strAnoFin;
        qryCadWan.FieldByName('WAN_CODEMP').AsString := VS_strCodEmp;
        qryCadWan.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intQtdFormulas, VS_strCodEmp);
        qryCadWan.FieldByName('WAN_CAMADA').AsInteger := intCamada;
        qryCadWan.FieldByName('WAN_VERCOR').AsString  := strVerCor;

        strMD5 := '';
        strMD5 := qryCadWan.FieldByName('WAN_LINHA_').AsString +
                  qryCadWan.FieldByName('WAN_CODAKZ').AsString +
                  qryCadWan.FieldByName('WAN_ALTERN').AsString +
                  qryCadWan.FieldByName('WAN_MONTAD').AsString +
                  qryCadWan.FieldByName('WAN_CAMADA').AsString +
                  qryCadWan.FieldByName('WAN_DESCRI').AsString +
                  qryCadWan.FieldByName('WAN_VERCOR').AsString;

        strMD5 := GetMD5(strMd5);

        qryCadWan.FieldByName('WAN_MD5KEY').AsString := strMD5;

        For intContador := 1 To 20 Do
        Begin
          {********************************************}
          {* Linha 11, troca o Q065 da linha 1        *}
          {* pelo Q080 da linha 11                    *}
          {* Q080 só concentrado, equivale a  50% do  *}
          {* volume total * peso específico           *}
          {*****************************************NC*}
          If (Pos(fStrZero(strLinPro,2), '11_') > 0) And (arrCodPig[intContador] = 'Q065') Then
          Begin
            qryCadWan.FieldByName('WAN_LINC' + fStrZero(intContador, 2)).AsString := arrLinPig[intContador];  // LIN. PIGMENTO XX
            qryCadWan.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString := 'Q080';                  // CÓD. PIGMENTO XX
            qryCadWan.FieldByName('WAN_QCON' + fStrZero(intContador, 2)).AsFloat  := 450 * 0.996;             // QTD. PIGMENTO XX
            qryCadWan.FieldByName('WAN_QD21' + fStrZero(intContador, 2)).AsFloat  := 0;                       // QTD. DILUIDA / 2:1 PIGMENTO XX
            qryCadWan.FieldByName('WAN_QD41' + fStrZero(intContador, 2)).AsFloat  := 0;                       // QTD. DILUIDA / 4:1 PIGMENTO XX
            qryCadWan.FieldByName('WAN_PORC' + fStrZero(intContador, 2)).AsFloat  := 0;                       // PORCENTAGEM DE CADA BASE UTILIZADA
          End
          Else
          Begin
            qryCadWan.FieldByName('WAN_LINC' + fStrZero(intContador, 2)).AsString := arrLinPig[intContador];         // LIN. PIGMENTO XX
            qryCadWan.FieldByName('WAN_CODC' + fStrZero(intContador, 2)).AsString := arrCodPig[intContador];         // CÓD. PIGMENTO XX
            qryCadWan.FieldByName('WAN_QCON' + fStrZero(intContador, 2)).AsFloat  := arrQtdPigCon[intContador];      // QTD. PIGMENTO XX
            qryCadWan.FieldByName('WAN_QD21' + fStrZero(intContador, 2)).AsFloat  := arrQtdPigDil[intContador];      // QTD. DILUIDA / 2:1 PIGMENTO XX
            qryCadWan.FieldByName('WAN_QD41' + fStrZero(intContador, 2)).AsFloat  := arrQtdPigDil4Por1[intContador]; // QTD. DILUIDA / 4:1 PIGMENTO XX
            qryCadWan.FieldByName('WAN_PORC' + fStrZero(intContador, 2)).AsFloat  := arrPorcen[intContador];         // PORCENTAGEM DE CADA BASE UTILIZADA
          End;
        End;
        
        Try
          qryCadWan.Post;
        Except
          On E: EUniError Do
          Begin
            If E.ErrorCode <> ERROR_PRIMARY_KEY_INSERT Then
            Begin
              Raise;
            End
            Else
              qryCadWan.Cancel;
          End;

          On E: Exception Do
          Begin
            Raise;
          End;
        End;

        Inc(intQtdFormulas);
      End;

      If (intQtdFormulas Mod 1000 = 0) Then
      Begin
        Application.ProcessMessages;
      End;

      pgbCores.StepBy(Length(strLinha));

    End;


    fGravaAutoIncrem('WANPRO_CADWAN', intQtdFormulas);
    fGravaCodSeq('WANPRO_CADWAN', intQtdFormulas);

    FreeAndNil(qryWanPro_CodUni);

    If (blnApagar) Then
    Begin
      qryCadNfm := fCriaQuery(Self);
      qryCadNfm.SQL.Add('SELECT * FROM WANPRO_CADNFM');
      qryCadNfm.Open;

      While (Not qryCadNfm.Eof) Do
      Begin        
        fGeraNovasFormulas(qryCadNfm);
        qryCadNfm.Next;
      End;

      FreeAndNil(qryCadNfm);
    End;

    fMensagem('', 'Geração concluída!', ['&Ok']);
    btnConfirmaDados.Enabled := True;
    btnSair.Enabled          := True;

  Except
    On E: Exception Do
    Begin
      fMensagem('', E.Message + #13#10 + 'A linha do txt aparecerá na proxima mensagem.', ['&Ok']);
      fMensagem('', strLinha, ['&Ok']);
    End;
  End;

end;

{************************************************************}
{* ESSA FÓRMULA É USADA PARA O CÁLCULO DAS SEGUINTES LINHAS:*}
{* WANDABASE HS (30%), AUTOBASE 100:50 (33,33%),            *}
{* AUTOBASE 100:80 (44,4%), WANDACAR (SÓ CONCENTRADO) E     *}
{* WANDALAC (SÓ CONCENTRADO)                                *}
{*********************************************************MV*}

function TfrmCadWanProGeraArquivo.fRetDescLinha(strCodigo: String): String;
begin
  Case StrToInt(strCodigo) Of
     1 : Result := Uppercase('Autobase Plus 100:50');
     4 : Result := Uppercase('Wandabase HS');
     6 : Result := Uppercase('Wandalac');
     8 : Result := Uppercase('Wanda PU HS');
     9 : Result := Uppercase('Wandacar');
    11 : Result := Uppercase('Single Stage Converter');
    12 : Result := Uppercase('Autobase Plus Baseline 100:80');
    13 : Result := Uppercase('Autocoat BT100');
    14 : Result := Uppercase('Autobase Plus 100:80');
    15 : Result := Uppercase('Autocoat BT110');
    16 : Result := Uppercase('Autocoat BT120');
    17 : Result := Uppercase('Autocoat BT130');
    19 : Result := Uppercase('Autobase Plus Baseline 100:50');
    27 : Result := Uppercase('Autowave MM');
    58 : Result := Uppercase('Wanda PU MS');
    59 : Result := Uppercase('Autocoat BT90');
    72 : Result := Uppercase('Tech Fleet PU');
    74 : Result := Uppercase('Tech Fleet Epoxy');
    75 : Result := Uppercase('Tech Fleet Sintetico');
    76 : Result := Uppercase('Tech Fleet Laca');
  Else
    Result := '';
  End

end;

function TfrmCadWanProGeraArquivo.fRetornaPreco(fltPerCen, fltPesEsp,
  fltEmbala, fltPrePig, fltTotalPerVolume: Double;
  var fltVolumeMassa: Double): Double;
  Var
    fltPerVolume: Double;
    fltVolumeLitro: Double;
    fltPesoBase: Double;
begin
  fltPerCen      := fltPerCen;
  fltPerVolume   := fltPerCen / fltPesEsp;
  fltVolumeLitro := fltPerVolume * 900 / fltTotalPerVolume;
  fltVolumeMassa := fFormataFloat(fltVolumeLitro * fltPesEsp, 1);
  fltPesoBase    := fFormataFloat(fltEmbala * fltPesEsp, 3);
  Result         := fFormataFloat(fltVolumeMassa * fltPrePig / fltPesoBase, 3);
end;

function TfrmCadWanProGeraArquivo.fRetornaPreco11(fltPerCen, fltPesEsp,
  fltEmbala, fltPrePig, fltTotalPerVolume: Double;
  var fltVolumeMassa: Double): Double;
  Var
    fltPerVolume: Double;
    fltVolumeLitro: Double;
    fltPesoBase: Double;
    fltPerBases: Double;
begin
  fltPerCen      := fltPerCen;
  fltPerBases    := fltPerCen * 100 / (100 - 23);
  fltPerVolume   := fltPerBases  / fltPesEsp;
  fltVolumeLitro := (450 * fltPerVolume)/ fltTotalPerVolume;
  fltVolumeMassa := fFormataFloat(fltVolumeLitro * fltPesEsp, 1);
  fltPesoBase    := fFormataFloat(fltEmbala * fltPesEsp, 3);
  Result         := fFormataFloat(fltVolumeMassa * fltPrePig / fltPesoBase, 3);
end;

function TfrmCadWanProGeraArquivo.fRetornaPrecoPU(fltPerCen, fltPesEsp, fltEmbala,
  fltPrePig, fltTotalPerVolume, fltQtdProduzir: Double; var fltVolumeMassa: Double): Double;
  Var
    fltPerVolume: Double;
    fltVolumeLitro: Double;
    fltPesoBase: Double;
begin

  fltPerCen      := fltPerCen;
  fltPerVolume   := fltPerCen / fltPesEsp;
  fltVolumeLitro := fltPerVolume * fltQtdProduzir / fltTotalPerVolume;

  {*******************************************}
  {* QUANDO É O CALCULO DO TINNER, JÁ TEM A  *}
  {* QUANTIDADE EM MASSA                     *}
  {****************************************MV*}
  If (fltQtdProduzir = 0.0) Then
    fltVolumeMassa := fFormataFloat(fltPerCen,1)
  Else
    fltVolumeMassa := fFormataFloat(fltVolumeLitro * fltPesEsp, 1);

  fltPesoBase    := fFormataFloat(fltEmbala * fltPesEsp, 3);
  Result         := fFormataFloat(fltVolumeMassa * fltPrePig / fltPesoBase, 3);
end;

function TfrmCadWanProGeraArquivo.fTamArq(strNomArq: String): Integer;
  Var
    h: Cardinal;
begin
  h := CreateFile(PChar(strNomArq), GENERIC_READ, FILE_SHARE_READ, Nil, OPEN_EXISTING,
    FILE_ATTRIBUTE_NORMAL, 0);

  Result := GetFileSize(h, Nil);

  CloseHandle(h);
end;

procedure TfrmCadWanProGeraArquivo.pApagaTemporaria;
  Var
    qryTmp: TUniQuery;
begin

  Try
    qryTmp := fCriaQuery(Self);

    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('DROP TABLE IF EXISTS TMP_LAYER');
    qryTmp.ExecSQL;

    FreeAndNil(qryTmp);
  Except

  End;

end;

procedure TfrmCadWanProGeraArquivo.pCarregaFormulacoes;
  Var
    txtLayer: TextFile;
    strLinha: String;
    strPatWan: String;
    conf: IConfTinta;
begin
  conf      := fGetConfTinta('WCP');
//  strPatWan := fArqIniTinta(0, 'COLOR PRO', 'PATWAN', '');
  strPatWan := conf.fGet('PATWAN');

  pApagaTemporaria;

  With qryLayer Do
  Begin

    SQL.Clear;
    SQL.Add('CREATE TABLE TMP_LAYER ( ');
    SQL.Add('  Linha VARCHAR(10), ');
    SQL.Add('  CodAkazo VARCHAR(30), ');
    SQL.Add('  NumCamadas VARCHAR(1), ');
    SQL.Add('  CodPigmento VARCHAR(27), ');
    SQL.Add('  Percentual NUMERIC(12, 4), ');
    SQL.Add('  Versao VARCHAR(5), ');
    SQL.Add('  Alternativa VARCHAR(5)) ENGINE=MyIsam ');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('CREATE INDEX IDX_TMP_LAYER ON TMP_LAYER(Linha, CodAkazo, Alternativa, NumCamadas) ');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('ALTER TABLE TMP_LAYER DISABLE KEYS');
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('INSERT DELAYED INTO TMP_LAYER VALUES ');
    SQL.Add('(:Linha, :CodAkazo, :NumCamadas, :CodPigmento, :Percentual, :Versao, :Alternativa) ');
  End;

  pgbLayer.Max := fTamArq(strPatWan + '\Layer.txt');
  pgbLayer.Position := 0;

  AssignFile(txtLayer, strPatWan + '\Layer.txt');
  Reset(txtLayer);

  {*******************************************}
  {* CARREGA A ARQUIVO LAYER                 *}
  {****************************************MV*}
  While (Not Eof(txtLayer)) Do
  Begin

    Readln(txtLayer, strLinha);
    pgbLayer.StepBy(Length(strLinha));

    qryLayer.ParamByName('Linha').AsString       := Trim(Copy(strLinha, 01, 10));
    qryLayer.ParamByName('CodAkazo').AsString    := Trim(Copy(strLinha, 11, 30));
    qryLayer.ParamByName('NumCamadas').AsString  := Trim(Copy(strLinha, 42, 01));
    qryLayer.ParamByName('CodPigmento').AsString := Trim(Copy(strLinha, 44, 27));
    qryLayer.ParamByName('Percentual').AsFloat   := fStrToFloat(Trim(Copy(strLinha, 71, 12)));
    qryLayer.ParamByName('Versao').AsString      := Trim(Copy(strLinha, 83, 05));
    qryLayer.ParamByName('Alternativa').AsString := Trim(Copy(strLinha, 88, 05));
    qryLayer.ExecSQL;

    Application.ProcessMessages;

  End;

  With qryLayer Do
  Begin
    SQL.Clear;
    SQL.Add('ALTER TABLE TMP_LAYER ENABLE KEYS');
    ExecSQL;
    Close;
  End;


  CloseFile(txtLayer);
end;

procedure TfrmCadWanProGeraArquivo.pCarregaPigmentos;
  Var
    txtTonner: TextFile;
    strLinha: String;
    intAutInc: Integer;
    strLinBas: String;
    strCodBas: String;
    strPatWan: String;
    conf: IConfTinta;
begin

  conf      := fGetConfTinta('WCP');
//  strPatWan := fArqIniTinta(0, 'COLOR PRO', 'PATWAN', '');
  strPatWan := conf.fGet('PATWAN');

  If (rdbGerBas.Checked) Then
  Begin

    intAutInc := StrToIntDef(LeftStr(fRetAutoIncrem('WANPRO_CADBAS', VS_strCodEmp), 17), 0);

    pgbPigmentos.Max := fTamArq(strPatWan + '\Tonners.txt');
    pgbPigmentos.Position := 0;

    AssignFile(txtTonner, strPatWan + '\Tonners.txt');
    Reset(txtTonner);

    With qryCadBas Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM WANPRO_CADBAS');
      Open;
    End;

    While (Not Eof(txtTonner)) Do
    Begin

      ReadLn(txtTonner, strLinha);

      strLinBas  := Trim(Copy(strLinha, 01, 13));
      strCodBas := Trim(Copy(strLinha, 14, 20));

      If qryCadBas.Locate('BAS_LINHA_;BAS_CODBAS', VarArrayOf([strLinBas, strCodBas]), []) Then
        qryCadBas.Edit
      Else
        qryCadBas.Append;

      qryCadBas.FieldByName('BAS_PREVEN').AsFloat  := fStrToFloat(Trim(Copy(strLinha, 153, 12)));
      If qryCadBas.State <> dsEdit Then
      Begin
        qryCadBas.FieldByName('BAS_LINHA_').AsString := strLinBas;
        qryCadBas.FieldByName('BAS_CODBAS').AsString := strCodBas;
        qryCadBas.FieldByName('BAS_DESBAS').AsString := Trim(Copy(strLinha, 35, 110));
        qryCadBas.FieldByName('BAS_PESESP').AsFloat  := fStrToFloat(Trim(Copy(strLinha, 165, 19)));
        qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := fStrToFloat(Trim(Copy(strLinha, 184, 19))) * 1000;
        qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
        qryCadBas.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutInc, VS_strCodEmp);
        Inc(intAutInc);
      End;

      qryCadBas.Post;
      pgbPigmentos.StepBy(Length(strLinha));
      Application.ProcessMessages;

    End;

    fGravaAutoIncrem('WANPRO_CADBAS', intAutInc);

    qryCadBas.Close;
    CloseFile(txtTonner);
  End
  Else
  Begin

    With qryCadBas Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  BAS_LINHA_ AS Linha, ');
      SQL.Add('  BAS_CODBAS AS Base, ');
      SQL.Add('  BAS_DESBAS AS Descricao, ');
      SQL.Add('  " "        AS Status, ');
      SQL.Add('  0.0        AS Preco, ');
      SQL.Add('  BAS_PESESP AS PesoEsp, ');
      SQL.Add('  BAS_EMBALA * 1000 AS TamEmbala ');
      SQL.Add('FROM ');
      SQL.Add('  WANPRO_CADBAS ');
    End;

    cdsTonner.Close;
    cdsTonner.SetProvider(dspCadBas);
    cdsTonner.Open;

  End;

end;

procedure TfrmCadWanProGeraArquivo.pRetornaInfoLinha(strLinha: String;
  var strLinDil, strBasDil: String; var fltFatBas, fltPerDil: Double);
var
  conf: IConfTinta;
begin
  conf      := fGetConfTinta('WCP');

  strLinDil := '';
  strBasDil := '';
  fltFatBas := 0.0;
  fltPerDil := 0.0;

  If (strLinha = '4') Then
  Begin
{
    strLinDil := fArqIniTinta(0, 'COLOR PRO', 'LD1WAN', '');
    strBasDil := fArqIniTinta(0, 'COLOR PRO', 'BD1WAN', '');
}
    strLinDil := conf.fGet('LD1WAN');
    strBasDil := conf.fGet('BD1WAN');
//    fltPerDil := 30;
    fltPerDil := 33.33;
  End
  Else If (strLinha = '1') Then
  Begin
    strLinDil := conf.fGet('LD1ABS_100_50');
    strBasDil := conf.fGet('BD1ABS_100_50');
    fltPerDil := 33.33;
  End

  Else If (strLinha = '12') Then
  Begin
    strLinDil := conf.fGet('LPAPB_10080');
    strBasDil := conf.fGet('BPAPB_10080');
    fltPerDil := 33.33;
  End

  Else If (strLinha = '19') Then
  Begin
    strLinDil := conf.fGet('LD1ABS_BASELINE');
    strBasDil := conf.fGet('BD1ABS_BASELINE');
    fltPerDil := 33.33;
  End

  Else If (strLinha = '14') Then
  Begin
{
    strLinDil := fArqIniTinta(0, 'COLOR PRO', 'LD1ABS_100_80', '');
    strBasDil := fArqIniTinta(0, 'COLOR PRO', 'BD1ABS_100_80', '');
}
    strLinDil := conf.fGet('LD1ABS_100_80');
    strBasDil := conf.fGet('BD1ABS_100_80');
    fltPerDil := 44.4;
  End
  Else If (strLinha = '8') Then
  Begin
{
    strLinDil := fArqIniTinta(0, 'COLOR PRO', 'LD1PU_HS', '');
    strBasDil := fArqIniTinta(0, 'COLOR PRO', 'BD1PU_HS', '');
}
    strLinDil := conf.fGet('LD1PU_HS');
    strBasDil := conf.fGet('BD1PU_HS');
  End
  Else If (strLinha = '58') Then
  Begin
{
    strLinDil := fArqIniTinta(0, 'COLOR PRO', 'LD1PU_MS', '');
    strBasDil := fArqIniTinta(0, 'COLOR PRO', 'BD1PU_MS', '');
}
    strLinDil := conf.fGet('LD1PU_MS');
    strBasDil := conf.fGet('BD1PU_MS');
  End
  Else If (strLinha = '19') Then
  Begin
{
    strLinDil := fArqIniTinta(0, 'COLOR PRO', 'LD1ABS_BASELINE', '');
    strBasDil := fArqIniTinta(0, 'COLOR PRO', 'BD1ABS_BASELINE', '');
}
    strLinDil := conf.fGet('LD1ABS_BASELINE');
    strBasDil := conf.fGet('BD1ABS_BASELINE');
    fltPerDil := 33.33;
  End
  Else If (strLinha = '16') Then
  Begin
{
    strLinDil := fArqIniTinta(0, 'COLOR PRO', 'LD1BT120', '');
    strBasDil := fArqIniTinta(0, 'COLOR PRO', 'BD1BT120', '');
}
    strLinDil := conf.fGet('LD1BT120');
    strBasDil := conf.fGet('BD1BT120');
    fltPerDil := 30;
  End
  Else If (strLinha = '59') Then
  Begin
{
    strLinDil := fArqIniTinta(0, 'COLOR PRO', 'LD1BT90', '');
    strBasDil := fArqIniTinta(0, 'COLOR PRO', 'BD1BT90', '');
}
    strLinDil := conf.fGet('LD1BT90');
    strBasDil := conf.fGet('BD1BT90');
    //fltPerDil := 25;
  End
  Else If (strLinha = '37') Then
  Begin
{
    strLinDil := fArqIniTinta(0, 'COLOR PRO', 'LD1BT80', '');
    strBasDil := fArqIniTinta(0, 'COLOR PRO', 'BD1BT80', '');
}
    strLinDil := conf.fGet('LD1BT80');
    strBasDil := conf.fGet('BD1BT80');
    fltPerDil := 15;
  End
  Else If (strLinha = '13') Then
  Begin
{
    strLinDil := fArqIniTinta(0, 'COLOR PRO', 'LD1BT100', '');
    strBasDil := fArqIniTinta(0, 'COLOR PRO', 'BD1BT100', '');
}
    strLinDil := conf.fGet('LD1BT100');
    strBasDil := conf.fGet('BD1BT100');
  End;

  If (fltPerDil > 0.0) Then
    fltFatBas := (100 - fltPerDil) / 100;

end;

end.
