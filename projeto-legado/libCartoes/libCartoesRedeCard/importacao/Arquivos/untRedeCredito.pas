unit untRedeCredito;

interface

Uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Forms, frxClass, Vcl.Graphics, Data.DB,

     cxProgressBar,

     untIRedeCardIntegracaoLibCartoes, untRedeCardTipos, untTRedeCardReport;

Type
  TRedeCredito = Class(TInterfacedObject, ICartoes)
  Private
    FstrNomEmp: String;
    FRegistrosDescartados: TStringList;

    function fFloatToInt(fltNumero: Double): Integer;
    function fGetLetraAlfa(intCol: Integer): String;

    function fRetData(strData: String; blnColocaBarra: Boolean = True): Variant;
    function fRetVal(strVal: String): Variant;

    function fAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime): TDateTime;
    function fEhFeriado(dtaDta: TDateTime): Boolean;
    function fDiaDeFolga(dtaDta: TDateTime; blnConsideraSabado : Boolean = True): Boolean;

    procedure GravarRegistrosTipo6(var AProgress: TcxProgressBar);
    procedure GravarRegistrosTipo8(var AProgress: TcxProgressBar);
    procedure GravarRegistrosTipo10(var AProgress: TcxProgressBar);
    procedure GravarRegistrosTipo12(var AProgress: TcxProgressBar);
    procedure GravarRegistrosTipo14(var AProgress: TcxProgressBar);
    procedure GravarRegistrosTipo34(var AProgress: TcxProgressBar);

    procedure RegistraItemDescartado(const AstrTipoReg, AstrCampo: String);
  Public
    property strNomEmp: String read FstrNomEmp write FstrNomEmp;

    constructor Create;
    destructor Destroy; override;
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);

    procedure LimparImportacoes;

    class function fRetSQLTabelaReg6: String;
    class function fRetSQLTabelaReg8: String;
    class function fRetSQLTabelaReg10: String;
    class function fRetSQLTabelaReg12: String;
    class function fRetSQLTabelaReg14: String;
    class function fRetSQLTabelaReg34: String;
    class function fRetEstruturaCred(strTabela: String): TArrEstruturaCred;
  End;

Var
  strNomArq: String;
  strDtaArq: String;
  VersaoMenil: Boolean;

  intPosicaoAtualFReg6,
  intPosicaoAtualFReg8,
  intPosicaoAtualFReg10,
  intPosicaoAtualFReg12,
  intPosicaoAtualFReg14,
  intPosicaoAtualFReg34,
  LContadorReg35: Integer;

  FReg6: TArrRegistro6;
  FReg8: TArrRegistro8;
  FReg10: TArrRegistro10;
  FReg12: TArrRegistro12;
  FReg14: TArrRegistro14;

  FReg34: TArrRegistro34;

implementation

uses untTRedeCardFuncoes, Uni;

{ TRedeCredito }

constructor TRedeCredito.Create;
begin
  intPosicaoAtualFReg6  := 0;
  intPosicaoAtualFReg8  := 0;
  intPosicaoAtualFReg10 := 0;
  intPosicaoAtualFReg12 := 0;
  intPosicaoAtualFReg14 := 0;
  intPosicaoAtualFReg34 := 0;

  LContadorReg35 := 1;
  FRegistrosDescartados := TStringList.Create;
end;

function TRedeCredito.fRetData(strData: String; blnColocaBarra: Boolean = True): Variant;
Begin
  Try
    If blnColocaBarra Then
    Begin
      Insert('/', strData, 3);
      Insert('/', strData, 6);
    End;

    Result := StrToDate(strData);
  Except
    Result := Null;
  End;
End;


class function TRedeCredito.fRetEstruturaCred(strTabela: String): TArrEstruturaCred;
Begin

  If strTabela = 'RED_EVCR06' Then
  Begin
    SetLength(Result, 15);

    Result[0].strDescri  := 'RED_TIPREG'; Result[0].strTipCmp  := 'CHAR(3)'      ;
    Result[1].strDescri  := 'RED_NUM_PV'; Result[1].strTipCmp  := 'VARCHAR(9)'   ;
    Result[2].strDescri  := 'RED_NUM_RV'; Result[2].strTipCmp  := 'VARCHAR(9)'   ;
    Result[3].strDescri  := 'RED_NUMBCO'; Result[3].strTipCmp  := 'CHAR(3)'      ;
    Result[4].strDescri  := 'RED_NUMAGE'; Result[4].strTipCmp  := 'VARCHAR(5)'   ;
    Result[5].strDescri  := 'RED_NUMCCO'; Result[5].strTipCmp  := 'VARCHAR(11)'  ;
    Result[6].strDescri  := 'RED_DTA_RV'; Result[6].strTipCmp  := 'DATE'         ;
    Result[7].strDescri  := 'RED_QTDCVA'; Result[7].strTipCmp  := 'VARCHAR(5)'   ;
    Result[8].strDescri  := 'RED_VALBRU'; Result[8].strTipCmp  := 'DECIMAL(13,2)';
    Result[9].strDescri  := 'RED_VALGOR'; Result[9].strTipCmp  := 'DECIMAL(13,2)';
    Result[10].strDescri := 'RED_VALREJ'; Result[10].strTipCmp := 'DECIMAL(13,2)';
    Result[11].strDescri := 'RED_VALDES'; Result[11].strTipCmp := 'DECIMAL(13,2)';
    Result[12].strDescri := 'RED_VALLIQ'; Result[12].strTipCmp := 'DECIMAL(13,2)';
    Result[13].strDescri := 'RED_DTACRE'; Result[13].strTipCmp := 'DATE'         ;
    Result[14].strDescri := 'RED_CODBAN'; Result[14].strTipCmp := 'CHAR(1)'      ;

  End
  Else If strTabela = 'RED_EVCR08' Then
  Begin
    SetLength(Result, 24);

    Result[0].strDescri  := 'RED_TIPREG'; Result[0].strTipCmp  := 'CHAR(3)'      ;
    Result[1].strDescri  := 'RED_NUM_PV'; Result[1].strTipCmp  := 'VARCHAR(9)'   ;
    Result[2].strDescri  := 'RED_NUM_RV'; Result[2].strTipCmp  := 'VARCHAR(9)'   ;
    Result[3].strDescri  := 'RED_DTA_CV'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := 'RED_VAL_CV'; Result[4].strTipCmp  := 'DECIMAL(13,2)';
    Result[5].strDescri  := 'RED_VALGER'; Result[5].strTipCmp  := 'DECIMAL(13,2)';
    Result[6].strDescri  := 'RED_NUMCAR'; Result[6].strTipCmp  := 'VARCHAR(16)'  ;
    Result[7].strDescri  := 'RED_STS_CV'; Result[7].strTipCmp  := 'VARCHAR(4)'   ;
    Result[8].strDescri  := 'RED_NUM_CV'; Result[8].strTipCmp  := 'VARCHAR(12)'  ;
    Result[9].strDescri  := 'RED_NUMREF'; Result[9].strTipCmp  := 'VARCHAR(13)'  ;
    Result[10].strDescri := 'RED_VALDES'; Result[10].strTipCmp := 'DECIMAL(13,2)';
    Result[11].strDescri := 'RED_NUMAUT'; Result[11].strTipCmp := 'VARCHAR(6)'   ;
    Result[12].strDescri := 'RED_HRATRA'; Result[12].strTipCmp := 'TIME'         ;
    Result[13].strDescri := 'RED_NUMBI1'; Result[13].strTipCmp := 'VARCHAR(16)'  ;
    Result[14].strDescri := 'RED_NUMBI2'; Result[14].strTipCmp := 'VARCHAR(16)'  ;
    Result[15].strDescri := 'RED_NUMBI3'; Result[15].strTipCmp := 'VARCHAR(16)'  ;
    Result[16].strDescri := 'RED_NUMBI4'; Result[16].strTipCmp := 'VARCHAR(16)'  ;
    Result[17].strDescri := 'RED_TIPCAP'; Result[17].strTipCmp := 'CHAR(1)'      ;
    Result[18].strDescri := 'RED_VALLIQ'; Result[18].strTipCmp := 'DECIMAL(13,2)';
    Result[19].strDescri := 'RED_NUMTER'; Result[19].strTipCmp := 'VARCHAR(8)'   ;
    Result[20].strDescri := 'RED_SIGPAI'; Result[20].strTipCmp := 'CHAR(3)'      ;
    Result[21].strDescri := 'RED_CODBAN'; Result[21].strTipCmp := 'CHAR(1)'      ;
    Result[22].strDescri := 'RED_BAIXAD'; Result[22].strTipCmp := 'CHAR(1)'      ;
    Result[23].strDescri := 'RED_SEQLOT'; Result[23].strTipCmp := 'VARCHAR(9)'   ;

  End
  Else If strTabela = 'RED_EVCR10' Then
  Begin
    SetLength(Result, 15);

    Result[0].strDescri  := 'RED_TIPREG'; Result[0].strTipCmp  := 'CHAR(3)'      ;
    Result[1].strDescri  := 'RED_NUM_PV'; Result[1].strTipCmp  := 'VARCHAR(9)'   ;
    Result[2].strDescri  := 'RED_NUM_RV'; Result[2].strTipCmp  := 'VARCHAR(9)'   ;
    Result[3].strDescri  := 'RED_CODBCO'; Result[3].strTipCmp  := 'CHAR(3)'      ;
    Result[4].strDescri  := 'RED_NUMAGE'; Result[4].strTipCmp  := 'VARCHAR(5)'   ;
    Result[5].strDescri  := 'RED_NUMCCO'; Result[5].strTipCmp  := 'VARCHAR(11)'  ;
    Result[6].strDescri  := 'RED_DTA_RV'; Result[6].strTipCmp  := 'DATE'         ;
    Result[7].strDescri  := 'RED_QTD_CV'; Result[7].strTipCmp  := 'VARCHAR(5)'   ;
    Result[8].strDescri  := 'RED_VALBRU'; Result[8].strTipCmp  := 'DECIMAL(13,2)';
    Result[9].strDescri  := 'RED_VALGOR'; Result[9].strTipCmp  := 'DECIMAL(13,2)';
    Result[10].strDescri := 'RED_VALREJ'; Result[10].strTipCmp := 'DECIMAL(13,2)';
    Result[11].strDescri := 'RED_VALDES'; Result[11].strTipCmp := 'DECIMAL(13,2)';
    Result[12].strDescri := 'RED_VALLIQ'; Result[12].strTipCmp := 'DECIMAL(13,2)';
    Result[13].strDescri := 'RED_DTACRE'; Result[13].strTipCmp := 'DATE'         ;
    Result[14].strDescri := 'RED_CODBAN'; Result[14].strTipCmp := 'CHAR(1)'      ;

  End
  Else If strTabela = 'RED_EVCR12' Then
  Begin
    SetLength(Result, 27);

    Result[0].strDescri  := 'RED_TIPREG'; Result[0].strTipCmp  := 'CHAR(3)'      ;
    Result[1].strDescri  := 'RED_NUM_PV'; Result[1].strTipCmp  := 'VARCHAR(9)'   ;
    Result[2].strDescri  := 'RED_NUM_RV'; Result[2].strTipCmp  := 'VARCHAR(9)'   ;
    Result[3].strDescri  := 'RED_DTA_CV'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := 'RED_VAL_CV'; Result[4].strTipCmp  := 'DECIMAL(13,2)';
    Result[5].strDescri  := 'RED_VALGOR'; Result[5].strTipCmp  := 'DECIMAL(13,2)';
    Result[6].strDescri  := 'RED_NUMCCO'; Result[6].strTipCmp  := 'VARCHAR(16)'  ;
    Result[7].strDescri  := 'RED_STS_CV'; Result[7].strTipCmp  := 'CHAR(3)'      ;
    Result[8].strDescri  := 'RED_QTDPAR'; Result[8].strTipCmp  := 'CHAR(2)'      ;
    Result[9].strDescri  := 'RED_NUM_CV'; Result[9].strTipCmp  := 'VARCHAR(12)'  ;
    Result[10].strDescri := 'RED_NUMREF'; Result[10].strTipCmp := 'VARCHAR(13)'  ;
    Result[11].strDescri := 'RED_VALDES'; Result[11].strTipCmp := 'DECIMAL(13,2)';
    Result[12].strDescri := 'RED_NUMAUT'; Result[12].strTipCmp := 'VARCHAR(6)'   ;
    Result[13].strDescri := 'RED_HRATRA'; Result[13].strTipCmp := 'TIME'         ;
    Result[14].strDescri := 'RED_NUMBI1'; Result[14].strTipCmp := 'VARCHAR(16)'  ;
    Result[15].strDescri := 'RED_NUMBI2'; Result[15].strTipCmp := 'VARCHAR(16)'  ;
    Result[16].strDescri := 'RED_NUMBI3'; Result[16].strTipCmp := 'VARCHAR(16)'  ;
    Result[17].strDescri := 'RED_NUMBI4'; Result[17].strTipCmp := 'VARCHAR(16)'  ;
    Result[18].strDescri := 'RED_TIPCAP'; Result[18].strTipCmp := 'CHAR(1)'      ;
    Result[19].strDescri := 'RED_VALLIQ'; Result[19].strTipCmp := 'DECIMAL(13,2)';
    Result[20].strDescri := 'RED_LIQPRI'; Result[20].strTipCmp := 'DECIMAL(13,2)';
    Result[21].strDescri := 'RED_LIQDEM'; Result[21].strTipCmp := 'DECIMAL(13,2)';
    Result[22].strDescri := 'RED_NUMTER'; Result[22].strTipCmp := 'VARCHAR(8)'   ;
    Result[23].strDescri := 'RED_SIGPAI'; Result[23].strTipCmp := 'VARCHAR(3)'   ;
    Result[24].strDescri := 'RED_CODBAN'; Result[24].strTipCmp := 'CHAR(1)'      ;
    Result[25].strDescri := 'RED_BAIXAD'; Result[25].strTipCmp := 'CHAR(1)'      ;
    Result[26].strDescri := 'RED_SEQLOT'; Result[26].strTipCmp := 'VARCHAR(9)'   ;

  End
  Else If strTabela = 'RED_EVCR14' Then
  Begin
    SetLength(Result, 9);

    Result[0].strDescri  := 'RED_TIPREG'; Result[0].strTipCmp  := 'CHAR(3)'      ;
    Result[1].strDescri  := 'RED_NUM_PV'; Result[1].strTipCmp  := 'VARCHAR(9)'   ;
    Result[2].strDescri  := 'RED_NUM_RV'; Result[2].strTipCmp  := 'VARCHAR(9)'   ;
    Result[3].strDescri  := 'RED_DTA_RV'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := 'RED_QTDPAR'; Result[4].strTipCmp  := 'CHAR(2)'      ;
    Result[5].strDescri  := 'RED_VALBRU'; Result[5].strTipCmp  := 'DECIMAL(13,2)';
    Result[6].strDescri  := 'RED_VALDES'; Result[6].strTipCmp  := 'DECIMAL(13,2)';
    Result[7].strDescri  := 'RED_VALLIQ'; Result[7].strTipCmp  := 'DECIMAL(13,2)';
    Result[8].strDescri  := 'RED_DTACRE'; Result[8].strTipCmp  := 'DATE'         ;

  End
  Else If strTabela = 'RED_EFIR34' Then
  Begin
    SetLength(Result, 36);

    Result[0].strDescri  := 'RED_TIPREG'; Result[0].strTipCmp  := 'CHAR(3)'      ;
    Result[1].strDescri  := 'RED_NUM_PV'; Result[1].strTipCmp  := 'VARCHAR(9)'   ;
    Result[2].strDescri  := 'RED_NUMDOC'; Result[2].strTipCmp  := 'VARCHAR(11)'  ;
    Result[3].strDescri  := 'RED_DTALAN'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := 'RED_VALLAN'; Result[4].strTipCmp  := 'DECIMAL(13,2)';
    Result[5].strDescri  := 'RED_CREDIT'; Result[5].strTipCmp  := 'CHAR(1)'      ;
    Result[6].strDescri  := 'RED_NUMBCO'; Result[6].strTipCmp  := 'CHAR(3)'      ;
    Result[7].strDescri  := 'RED_NUMAGE'; Result[7].strTipCmp  := 'VARCHAR(6)'   ;
    Result[8].strDescri  := 'RED_NUMCCO'; Result[8].strTipCmp  := 'VARCHAR(11)'  ;
    Result[9].strDescri  := 'RED_DTAMOV'; Result[9].strTipCmp  := 'DATE'         ;
    Result[10].strDescri := 'RED_NUM_RV'; Result[10].strTipCmp := 'VARCHAR(9)'   ;
    Result[11].strDescri := 'RED_DTA_RV'; Result[11].strTipCmp := 'DATE'         ;
    Result[12].strDescri := 'RED_CODBAN'; Result[12].strTipCmp := 'CHAR(1)'      ;
    Result[13].strDescri := 'RED_TIPTRA'; Result[13].strTipCmp := 'CHAR(1)'      ;
    Result[14].strDescri := 'RED_VALBRU'; Result[14].strTipCmp := 'DECIMAL(13,2)';
    Result[15].strDescri := 'RED_VALDES'; Result[15].strTipCmp := 'DECIMAL(13,2)';
    Result[16].strDescri := 'RED_PARTOT'; Result[16].strTipCmp := 'VARCHAR(5)'   ;
    Result[17].strDescri := 'RED_STSCRE'; Result[17].strTipCmp := 'CHAR(2)'      ;
    Result[18].strDescri := 'RED_PV_ORI'; Result[18].strTipCmp := 'VARCHAR(9)'   ;
    Result[19].strDescri := 'RED_DTAVEN'; Result[19].strTipCmp := 'DATE'         ;
    Result[19].strDescri := 'RED_VALORI'; Result[19].strTipCmp := 'DECIMAL(15,2)';
    Result[20].strDescri := 'RED_DTAARQ'; Result[20].strTipCmp := 'DATE'         ;
    Result[21].strDescri := 'RED_NOMARQ'; Result[21].strTipCmp := 'VARCHAR(255)' ;
    Result[22].strDescri := 'RED_CONCIL'; Result[22].strTipCmp := 'INTEGER DEFAULT 0';
    Result[22].strDescri := 'RED_PARCEL'; Result[22].strTipCmp := 'CHAR(1)       ';
    Result[23].strDescri := 'RED_IMPTOT'; Result[23].strTipCmp := 'INTEGER DEFAULT 0';
    Result[24].strDescri := 'RED_DTAIMP'; Result[24].strTipCmp := 'DATE'         ;
    Result[25].strDescri := 'RED_CARDEB'; Result[25].strTipCmp := 'VARCHAR(16)'  ;
    Result[26].strDescri := 'RED_REGDEB'; Result[26].strTipCmp := 'CHAR(3)'      ;
    Result[27].strDescri := 'RED_VALDEB'; Result[27].strTipCmp := 'DECIMAL(15,2)';
    Result[28].strDescri := 'RED_AUTDEB'; Result[28].strTipCmp := 'VARCHAR(6)'   ;
    Result[29].strDescri := 'RED_NSUDEB'; Result[29].strTipCmp := 'VARCHAR(12)'  ;
    Result[30].strDescri := 'RED_MOTAJU'; Result[30].strTipCmp := 'VARCHAR(28)'  ;
    Result[31].strDescri := 'RED_CONNEG'; Result[31].strTipCmp := 'VARCHAR(17)'  ;
    Result[32].strDescri := 'RED_CNPPAR'; Result[32].strTipCmp := 'VARCHAR(15)'  ;
    Result[33].strDescri := 'RED_NUM_OC'; Result[33].strTipCmp := 'VARCHAR(11) DEFAULT '''''  ;
    Result[34].strDescri := 'RED_DTANEG'; Result[34].strTipCmp := 'DATE'         ;
    Result[35].strDescri := 'RED_TIPNEG'; Result[35].strTipCmp := 'VARCHAR(1)'   ;
  End;

End;

class function TRedeCredito.fRetSQLTabelaReg6: String;
begin
  Result := 'CREATE TABLE RED_EVCR06(                ' +
            '  RED_TIPREG CHAR(03),                  ' +
            '  RED_NUM_PV VARCHAR(09),               ' +
            '  RED_NUM_RV VARCHAR(09),               ' +
            '  RED_NUMBCO CHAR(03),                  ' +
            '  RED_NUMAGE VARCHAR(05),               ' +
            '  RED_NUMCCO VARCHAR(11),               ' +
            '  RED_DTA_RV DATE,                      ' +
            '  RED_QTDCVA VARCHAR(05),               ' +
            '  RED_VALBRU DECIMAL(13,2),             ' +
            '  RED_VALGOR DECIMAL(13,2),             ' +
            '  RED_VALREJ DECIMAL(13,2),             ' +
            '  RED_VALDES DECIMAL(13,2),             ' +
            '  RED_VALLIQ DECIMAL(13,2),             ' +
            '  RED_DTACRE DATE,                      ' +
            '  RED_CODBAN CHAR(01),                  ' +
            '  PRIMARY KEY(RED_NUM_PV,               ' +
            '              RED_NUM_RV,               ' +
            '              RED_DTA_RV)) ENGINE INNODB';
end;

class function TRedeCredito.fRetSQLTabelaReg8: String;
begin
  Result := 'CREATE TABLE RED_EVCR08(                ' +
            '  RED_TIPREG CHAR(03),                  ' +
            '  RED_NUM_PV VARCHAR(09),               ' +
            '  RED_NUM_RV VARCHAR(09),               ' +
            '  RED_DTA_CV DATE,                      ' +
            '  RED_VAL_CV DECIMAL(13,2),             ' +
            '  RED_VALGER DECIMAL(13,2),             ' +
            '  RED_NUMCAR VARCHAR(16),               ' +
            '  RED_STS_CV VARCHAR(04),               ' +
            '  RED_NUM_CV VARCHAR(12),               ' +
            '  RED_NUMREF VARCHAR(13),               ' +
            '  RED_VALDES DECIMAL(13,2),             ' +
            '  RED_NUMAUT VARCHAR(06),               ' +
            '  RED_HRATRA TIME,                      ' +
            '  RED_NUMBI1 VARCHAR(16),               ' +
            '  RED_NUMBI2 VARCHAR(16),               ' +
            '  RED_NUMBI3 VARCHAR(16),               ' +
            '  RED_NUMBI4 VARCHAR(16),               ' +
            '  RED_TIPCAP CHAR(01),                  ' +
            '  RED_VALLIQ DECIMAL(13,2),             ' +
            '  RED_NUMTER VARCHAR(08),               ' +
            '  RED_SIGPAI CHAR(03),                  ' +
            '  RED_CODBAN CHAR(01),                  ' +
            '  RED_BAIXAD CHAR(01),                  ' +
            '  RED_SEQLOT VARCHAR(09),               ' +
            '  PRIMARY KEY(RED_NUM_PV,               ' +
            '              RED_NUM_RV,               ' +
            '              RED_NUM_CV)) ENGINE INNODB';
end;

procedure TRedeCredito.GravarRegistrosTipo10(var AProgress: TcxProgressBar);
  Var
    LRegistro10: TRegistro10;

    LGravacao: TUniQuery;
begin
  If Length(FReg10) = 0 Then
    Exit;

  LGravacao := VS_FuncoesExternas.fICriaQuery;

  Try
    LGravacao.SQL.Text := TRedeCardFuncoes.RetornaSQLReplace('RED_EVCR10', ['RED_CONCIL']);

    AProgress.Position := 0;

    Application.ProcessMessages;
    AProgress.Properties.Max := Length(FReg10)-1;

    For LRegistro10 In FReg10 Do
    Begin
      If LRegistro10.strTipReg.Trim.IsEmpty Then
      Begin
        AProgress.Position := AProgress.Properties.Max;

        Break;
      End;

      Application.ProcessMessages;

      If fRetData(LRegistro10.strDta_RV) =  Null Then
      begin
        RegistraItemDescartado(LRegistro10.strTipReg, 'DTA_RV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      If TRedeCardFuncoes.fEmptyStr(LRegistro10.strNum_PV) Then
      begin
        RegistraItemDescartado(LRegistro10.strTipReg, 'NUM_PV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      If TRedeCardFuncoes.fEmptyStr(LRegistro10.strNum_RV) Then
      begin
        RegistraItemDescartado(LRegistro10.strTipReg, 'NUM_RV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      LGravacao.Close;

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPREG', fRetVal(LRegistro10.strTipReg));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_PV', fRetVal(LRegistro10.strNum_PV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_RV', fRetVal(LRegistro10.strNum_RV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODBCO', fRetVal(LRegistro10.strNumBco));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMAGE', fRetVal(LRegistro10.strNumAge));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMCCO', fRetVal(LRegistro10.strNumCCo));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODBAN', fRetVal(LRegistro10.strCodBan));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_QTD_CV', fRetVal(LRegistro10.strQtd_CV));

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTA_RV', fRetData(LRegistro10.strDta_RV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTACRE', fRetData(LRegistro10.strDtaCre));

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALBRU', LRegistro10.fltValBru);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALGOR', LRegistro10.fltValGor);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALREJ', LRegistro10.fltValBru);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALDES', LRegistro10.fltValDes);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALLIQ', LRegistro10.fltValLiq);

      LGravacao.ExecSQL;

      AProgress.Position := AProgress.Position + 1;
    End;

    AProgress.Position := AProgress.Properties.Max;
    Application.ProcessMessages;
  Finally
    LGravacao.Close;
    FreeAndNil(LGravacao);
  End;
end;

procedure TRedeCredito.GravarRegistrosTipo12(var AProgress: TcxProgressBar);
  Var
    LRegistro12: TRegistro12;

    LGravacao: TUniQuery;
begin
  If Length(FReg12) = 0 Then
    Exit;

  LGravacao := VS_FuncoesExternas.fICriaQuery;

  Try
    LGravacao.SQL.Text := TRedeCardFuncoes.RetornaSQLReplace('RED_EVCR12', ['RED_CONCIL']);

    AProgress.Position := 0;

    Application.ProcessMessages;
    AProgress.Properties.Max := Length(FReg12)-1;

    For LRegistro12 In FReg12 Do
    Begin
      If LRegistro12.strTipReg.Trim.IsEmpty Then
      Begin
        AProgress.Position := AProgress.Properties.Max;

        Break;
      End;

      Application.ProcessMessages;

      If fRetData(LRegistro12.strDta_CV) =  Null Then
      begin
        RegistraItemDescartado(LRegistro12.strTipReg, 'DTA_CV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      If TRedeCardFuncoes.fEmptyStr(LRegistro12.strNum_PV) Then
      begin
        RegistraItemDescartado(LRegistro12.strTipReg, 'NUM_PV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      If TRedeCardFuncoes.fEmptyStr(LRegistro12.strNum_RV) Then
      begin
        RegistraItemDescartado(LRegistro12.strTipReg, 'NUM_RV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      If TRedeCardFuncoes.fEmptyStr(LRegistro12.strNum_CV) Then
      begin
        RegistraItemDescartado(LRegistro12.strTipReg, 'NUM_CV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      LGravacao.Close;

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPREG', fRetVal(LRegistro12.strTipReg));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_PV', fRetVal(LRegistro12.strNum_PV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_RV', fRetVal(LRegistro12.strNum_RV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMCCO', fRetVal(LRegistro12.strNumCar));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_STS_CV', fRetVal(LRegistro12.strSts_CV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_QTDPAR', fRetVal(LRegistro12.strQtdPar));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_CV', fRetVal(LRegistro12.strNum_CV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMREF', fRetVal(LRegistro12.strNumRef));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMAUT', fRetVal(LRegistro12.strNumAut));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMBI1', fRetVal(LRegistro12.strNumBi1));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMBI2', fRetVal(LRegistro12.strNumBi2));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMBI3', fRetVal(LRegistro12.strNumBi3));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMBI4', fRetVal(LRegistro12.strNumBi4));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPCAP', fRetVal(LRegistro12.strTipCap));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMTER', fRetVal(LRegistro12.strNumTer));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_SIGPAI', fRetVal(LRegistro12.strSigPai));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODBAN', fRetVal(LRegistro12.strCodBan));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_BAIXAD', fRetVal(LRegistro12.strBaixad));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_SEQLOT', fRetVal(LRegistro12.strSeqLot));

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTA_CV', fRetData(LRegistro12.strDta_CV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_HRATRA', fRetData(LRegistro12.strHraTra));

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALLIQ', LRegistro12.fltValLiq);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_LIQPRI', LRegistro12.fltLiqPri);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_LIQDEM', LRegistro12.fltLiqDem);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALDES', LRegistro12.fltValDes);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VAL_CV', LRegistro12.fltVal_CV);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALGOR', LRegistro12.fltValGor);

      LGravacao.ExecSQL;

      AProgress.Position := AProgress.Position + 1;
    End;

    AProgress.Position := AProgress.Properties.Max;
    Application.ProcessMessages;
  Finally
    LGravacao.Close;
    FreeAndNil(LGravacao);
  End;
end;

procedure TRedeCredito.GravarRegistrosTipo14(var AProgress: TcxProgressBar);
  Var
    LRegistro14: TRegistro14;

    LGravacao: TUniQuery;
begin
  If Length(FReg14) = 0 Then
    Exit;

  LGravacao := VS_FuncoesExternas.fICriaQuery;

  Try
    LGravacao.SQL.Text := TRedeCardFuncoes.RetornaSQLReplace('RED_EVCR14', ['RED_CONCIL']);

    AProgress.Position := 0;

    Application.ProcessMessages;
    AProgress.Properties.Max := Length(FReg14)-1;

    For LRegistro14 In FReg14 Do
    Begin
      If LRegistro14.strTipReg.Trim.IsEmpty Then
      Begin
        AProgress.Position := AProgress.Properties.Max;

        Break;
      End;

      Application.ProcessMessages;

      If fRetData(LRegistro14.strDta_RV) =  Null Then
      begin
        RegistraItemDescartado(LRegistro14.strTipReg, 'DTA_RV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      If TRedeCardFuncoes.fEmptyStr(LRegistro14.strNum_PV) Then
      begin
        RegistraItemDescartado(LRegistro14.strTipReg, 'NUM_PV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      If TRedeCardFuncoes.fEmptyStr(LRegistro14.strNum_RV) Then
      begin
        RegistraItemDescartado(LRegistro14.strTipReg, 'NUM_RV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      If TRedeCardFuncoes.fEmptyStr(LRegistro14.strQtdPar) Then
      begin
        RegistraItemDescartado(LRegistro14.strTipReg, 'QTD_PAR');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      LGravacao.Close;

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPREG', fRetVal(LRegistro14.strTipReg));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_PV', fRetVal(LRegistro14.strNum_PV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_RV', fRetVal(LRegistro14.strNum_RV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_QTDPAR', fRetVal(LRegistro14.strQtdPar));

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTA_RV', fRetData(LRegistro14.strDta_RV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTACRE', fRetData(LRegistro14.strDtaCre));

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALBRU', LRegistro14.fltValBru);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALDES', LRegistro14.fltValDes);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALLIQ', LRegistro14.fltValLiq);

      LGravacao.ExecSQL;

      AProgress.Position := AProgress.Position + 1;
    End;

    AProgress.Position := AProgress.Properties.Max;
    Application.ProcessMessages;
  Finally
    LGravacao.Close;
    FreeAndNil(LGravacao);
  End;
end;

procedure TRedeCredito.GravarRegistrosTipo34(var AProgress: TcxProgressBar);
  Var
    LRegistro34: TRegistro34;

    LGravacao: TUniQuery;
begin
  If Length(FReg34) = 0 Then
    Exit;

  LGravacao := VS_FuncoesExternas.fICriaQuery;

  Try
    LGravacao.SQL.Text := TRedeCardFuncoes.RetornaSQLReplace('RED_EFIR34', ['RED_CONCIL', 'RED_IMPTOT']);

    AProgress.Position := 0;

    Application.ProcessMessages;
    AProgress.Properties.Max := Length(FReg34)-1;

    For LRegistro34 In FReg34 Do
    Begin
      If LRegistro34.strTipReg.Trim.IsEmpty Then
      Begin
        AProgress.Position := AProgress.Properties.Max;

        Break;
      End;

      Application.ProcessMessages;

      If fRetData(LRegistro34.strDta_RV) =  Null Then
      begin
        RegistraItemDescartado(LRegistro34.strTipReg, 'DTA_RV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      If TRedeCardFuncoes.fEmptyStr(LRegistro34.strNum_PV) Then
      begin
        RegistraItemDescartado(LRegistro34.strTipReg, 'NUM_PV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      If TRedeCardFuncoes.fEmptyStr(LRegistro34.strNum_RV) Then
      begin
        RegistraItemDescartado(LRegistro34.strTipReg, 'NUM_RV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      If TRedeCardFuncoes.fEmptyStr(LRegistro34.strParTot) Then
      begin
        RegistraItemDescartado(LRegistro34.strTipReg, 'PAR_TOT');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      LGravacao.Close;

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPREG', fRetVal(LRegistro34.strTipReg));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_PV', fRetVal(LRegistro34.strNum_PV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMDOC', fRetVal(LRegistro34.strNumDoc));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CREDIT', fRetVal(LRegistro34.strCredit));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMBCO', fRetVal(LRegistro34.strNumBco));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMAGE', fRetVal(LRegistro34.strNumAge));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMCCO', fRetVal(LRegistro34.strNumCCo));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_RV', fRetVal(LRegistro34.strNum_RV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODBAN', fRetVal(LRegistro34.strCodBan));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPTRA', fRetVal(LRegistro34.strTipTra));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_PARTOT', fRetVal(LRegistro34.strParTot));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_STSCRE', fRetVal(LRegistro34.strStsCre));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_PV_ORI', fRetVal(LRegistro34.strPV_Ori));

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTANEG', fRetData(LRegistro34.DataNegociacao));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTAMOV', fRetData(LRegistro34.strDtaMov));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTA_RV', fRetData(LRegistro34.strDta_RV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTAVEN', fRetData(LRegistro34.strDtaVen));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTAARQ', fRetData(LRegistro34.strDtaArq));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTALAN', fRetData(LRegistro34.strDtaLan));
      If (fRetVal(LRegistro34.strTipReg) = '045') Then
        TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTALAN', fAcertaDataParaDiaUtil(fRetData(LRegistro34.strDtaLan) + 1));

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALLAN', LRegistro34.fltValLan);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALBRU', LRegistro34.fltValBru);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALDES', LRegistro34.fltValDes);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALORI', LRegistro34.fltValOri);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NOMARQ', LRegistro34.strNomArq);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_PARCEL', LRegistro34.strParcel);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTAIMP', LRegistro34.strDtaImp);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CARDEB', LRegistro34.strCarDeb);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_REGDEB', LRegistro34.strRegDeb);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALDEB', LRegistro34.fltValDeb);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_AUTDEB', LRegistro34.strAutDeb);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NSUDEB', LRegistro34.strNSUDeb);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_MOTAJU', LRegistro34.strMotAju);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPNEG', LRegistro34.TipoNegociacao);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CONNEG', LRegistro34.ContratoNegociacao);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CNPPAR', LRegistro34.CNPJParceiro);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_OC', LRegistro34.NumeroOC);

      LGravacao.ExecSQL;

      AProgress.Position := AProgress.Position + 1;
    End;

    AProgress.Position := AProgress.Properties.Max;
    Application.ProcessMessages;
  Finally
    LGravacao.Close;
    FreeAndNil(LGravacao);
  End;
end;

procedure TRedeCredito.GravarRegistrosTipo6(var AProgress: TcxProgressBar);
  Var
    LRegistro6: TRegistro6;

    LGravacao: TUniQuery;
begin
  If Length(FReg6) = 0 Then
    Exit;

  LGravacao := VS_FuncoesExternas.fICriaQuery;

  Try
    LGravacao.SQL.Text := TRedeCardFuncoes.RetornaSQLReplace('RED_EVCR06', ['RED_CONCIL']);

    AProgress.Position := 0;

    Application.ProcessMessages;
    AProgress.Properties.Max := Length(FReg6)-1;

    For LRegistro6 In FReg6 Do
    Begin
      If LRegistro6.strTipReg.Trim.IsEmpty Then
      Begin
        AProgress.Position := AProgress.Properties.Max;

        Break;
      End;

      Application.ProcessMessages;

      If fRetData(LRegistro6.strDta_RV) =  Null Then
      begin
        RegistraItemDescartado(LRegistro6.strTipReg, 'DTA_RV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      If TRedeCardFuncoes.fEmptyStr(LRegistro6.strNum_PV) Then
      begin
        RegistraItemDescartado(LRegistro6.strTipReg, 'NUM_PV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      If TRedeCardFuncoes.fEmptyStr(LRegistro6.strNum_RV) Then
      begin
        RegistraItemDescartado(LRegistro6.strTipReg, 'NUM_RV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      LGravacao.Close;

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPREG', fRetVal(LRegistro6.strTipReg));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_PV', fRetVal(LRegistro6.strNum_PV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_RV', fRetVal(LRegistro6.strNum_RV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMBCO', fRetVal(LRegistro6.strNumBco));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMAGE', fRetVal(LRegistro6.strNumAge));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMCCO', fRetVal(LRegistro6.strNumCCo));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_QTDCVA', fRetVal(LRegistro6.strQtdCVa));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTACRE', fRetVal(LRegistro6.strDtaCre));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODBAN', fRetVal(LRegistro6.strCodBan));

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTA_RV', fRetData(LRegistro6.strDta_RV));

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALBRU', LRegistro6.fltValBru);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALGOR', LRegistro6.fltValGor);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALREJ', LRegistro6.fltValRej);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALDES', LRegistro6.fltValDes);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALLIQ', LRegistro6.fltValLiq);

      LGravacao.ExecSQL;

      AProgress.Position := AProgress.Position + 1;
    End;

    AProgress.Position := AProgress.Properties.Max;
    Application.ProcessMessages;
  Finally
    LGravacao.Close;
    FreeAndNil(LGravacao);
  End;
end;

procedure TRedeCredito.GravarRegistrosTipo8(var AProgress: TcxProgressBar);
  Var
    LRegistro8: TRegistro8;

    LGravacao: TUniQuery;
begin
  If Length(FReg8) = 0 Then
    Exit;

  LGravacao := VS_FuncoesExternas.fICriaQuery;

  Try
    LGravacao.SQL.Text := TRedeCardFuncoes.RetornaSQLReplace('RED_EVCR08', ['RED_CONCIL']);

    AProgress.Position := 0;

    Application.ProcessMessages;
    AProgress.Properties.Max := Length(FReg8)-1;

    For LRegistro8 In FReg8 Do
    Begin
      If LRegistro8.strTipReg.Trim.IsEmpty Then
      Begin
        AProgress.Position := AProgress.Properties.Max;

        Break;
      End;

      Application.ProcessMessages;

      If fRetData(LRegistro8.strDta_CV) =  Null Then
      begin
        RegistraItemDescartado(LRegistro8.strTipReg, 'DTA_CV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      If TRedeCardFuncoes.fEmptyStr(LRegistro8.strNum_PV) then
      begin
        RegistraItemDescartado(LRegistro8.strTipReg, 'NUM_PV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      If TRedeCardFuncoes.fEmptyStr(LRegistro8.strNum_RV) then
      begin
        RegistraItemDescartado(LRegistro8.strTipReg, 'NUM_RV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      If TRedeCardFuncoes.fEmptyStr(LRegistro8.strNum_CV) Then
      begin
        RegistraItemDescartado(LRegistro8.strTipReg, 'NUM_CV');
        AProgress.Position := AProgress.Position + 1;
        Continue;
      end;

      LGravacao.Close;

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPREG', fRetVal(LRegistro8.strTipReg));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_PV', fRetVal(LRegistro8.strNum_PV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_RV', fRetVal(LRegistro8.strNum_RV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMCAR', fRetVal(LRegistro8.strNumCar));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_STS_CV', fRetVal(LRegistro8.strSts_CV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_CV', fRetVal(LRegistro8.strNum_CV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMREF', fRetVal(LRegistro8.strNumRef));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMAUT', fRetVal(LRegistro8.strNumAut));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMBI1', fRetVal(LRegistro8.strNumBi1));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMBI2', fRetVal(LRegistro8.strNumBi2));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMBI3', fRetVal(LRegistro8.strNumBi3));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMBI4', fRetVal(LRegistro8.strNumBi4));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPCAP', fRetVal(LRegistro8.strTipCap));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMTER', fRetVal(LRegistro8.strNumTer));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_SIGPAI', fRetVal(LRegistro8.strSigPai));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODBAN', fRetVal(LRegistro8.strCodBan));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_BAIXAD', fRetVal(LRegistro8.strBaixad));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_SEQLOT', fRetVal(LRegistro8.strSeqLot));

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_HRATRA', fRetData(LRegistro8.strHraTra));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTA_CV', fRetData(LRegistro8.strDta_CV));

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VAL_CV', LRegistro8.fltVal_CV);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALGER', LRegistro8.fltValGer);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALLIQ', LRegistro8.fltValLiq);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALDES', LRegistro8.fltValDes);

      LGravacao.ExecSQL;

      AProgress.Position := AProgress.Position + 1;
    End;

    AProgress.Position := AProgress.Properties.Max;
    Application.ProcessMessages;
  Finally
    LGravacao.Close;
    FreeAndNil(LGravacao);
  End;
end;

procedure TRedeCredito.LimparImportacoes;
begin
  SetLength(FReg6 , 0);
  SetLength(FReg8 , 0);
  SetLength(FReg10, 0);
  SetLength(FReg12, 0);
  SetLength(FReg14, 0);
  SetLength(FReg34, 0);
end;

class function TRedeCredito.fRetSQLTabelaReg10: String;
begin
  Result := 'CREATE TABLE RED_EVCR10(                ' +
            '  RED_TIPREG CHAR(03),                  ' +
            '  RED_NUM_PV VARCHAR(09),               ' +
            '  RED_NUM_RV VARCHAR(09),               ' +
            '  RED_CODBCO CHAR(03),                  ' +
            '  RED_NUMAGE VARCHAR(05),               ' +
            '  RED_NUMCCO VARCHAR(11),               ' +
            '  RED_DTA_RV DATE,                      ' +
            '  RED_QTD_CV VARCHAR(05),               ' +
            '  RED_VALBRU DECIMAL(13,2),             ' +
            '  RED_VALGOR DECIMAL(13,2),             ' +
            '  RED_VALREJ DECIMAL(13,2),             ' +
            '  RED_VALDES DECIMAL(13,2),             ' +
            '  RED_VALLIQ DECIMAL(13,2),             ' +
            '  RED_DTACRE DATE,                      ' +
            '  RED_CODBAN CHAR(01),                  ' +
            '  PRIMARY KEY(RED_NUM_PV,               ' +
            '              RED_NUM_RV,               ' +
            '              RED_DTA_RV)) ENGINE INNODB';
end;

class function TRedeCredito.fRetSQLTabelaReg12: String;
begin
  Result := 'CREATE TABLE RED_EVCR12(                ' +
            '  RED_TIPREG CHAR(03),                  ' +
            '  RED_NUM_PV VARCHAR(09),               ' +
            '  RED_NUM_RV VARCHAR(09),               ' +
            '  RED_DTA_CV DATE,                      ' +
            '  RED_VAL_CV DECIMAL(13,2),             ' +
            '  RED_VALGOR DECIMAL(13,2),             ' +
            '  RED_NUMCCO VARCHAR(16),               ' +
            '  RED_STS_CV CHAR(03),                  ' +
            '  RED_QTDPAR CHAR(02),                  ' +
            '  RED_NUM_CV VARCHAR(12),               ' +
            '  RED_NUMREF VARCHAR(13),               ' +
            '  RED_VALDES DECIMAL(13,2),             ' +
            '  RED_NUMAUT VARCHAR(06),               ' +
            '  RED_HRATRA TIME,                      ' +
            '  RED_NUMBI1 VARCHAR(16),               ' +
            '  RED_NUMBI2 VARCHAR(16),               ' +
            '  RED_NUMBI3 VARCHAR(16),               ' +
            '  RED_NUMBI4 VARCHAR(16),               ' +
            '  RED_TIPCAP VARCHAR(01),               ' +
            '  RED_VALLIQ DECIMAL(13,2),             ' +
            '  RED_LIQPRI DECIMAL(13,2),             ' +
            '  RED_LIQDEM DECIMAL(13,2),             ' +
            '  RED_NUMTER VARCHAR(08),               ' +
            '  RED_SIGPAI CHAR(03),                  ' +
            '  RED_CODBAN CHAR(01),                  ' +
            '  RED_BAIXAD CHAR(01),                  ' +
            '  RED_SEQLOT VARCHAR(09),               ' +
            '  PRIMARY KEY(RED_NUM_PV,               ' +
            '              RED_NUM_RV,               ' +
            '              RED_NUM_CV)) ENGINE INNODB';
end;

class function TRedeCredito.fRetSQLTabelaReg14: String;
begin
  Result := 'CREATE TABLE RED_EVCR14(                ' +
            '  RED_TIPREG CHAR(03),                  ' +
            '  RED_NUM_PV VARCHAR(09),               ' +
            '  RED_NUM_RV VARCHAR(09),               ' +
            '  RED_DTA_RV DATE,                      ' +
            '  RED_QTDPAR CHAR(02),                  ' +
            '  RED_VALBRU DECIMAL(13,2),             ' +
            '  RED_VALDES DECIMAL(13,2),             ' +
            '  RED_VALLIQ DECIMAL(13,2),             ' +
            '  RED_DTACRE DATE,                      ' +
            '  PRIMARY KEY(RED_TIPREG,RED_NUM_PV,RED_NUM_RV,RED_DTA_RV,RED_QTDPAR)) ENGINE INNODB';
end;

class function TRedeCredito.fRetSQLTabelaReg34: String;
begin
  Result := 'CREATE TABLE RED_EFIR34(                ' +
            '  RED_TIPREG CHAR(03),                  ' +
            '  RED_NUM_PV VARCHAR(09),               ' +
            '  RED_NUMDOC VARCHAR(11),               ' +
            '  RED_DTALAN DATE,                      ' +
            '  RED_VALLAN DECIMAL(13,2),             ' +
            '  RED_CREDIT CHAR(01),                  ' +
            '  RED_NUMBCO CHAR(03),                  ' +
            '  RED_NUMAGE VARCHAR(06),               ' +
            '  RED_NUMCCO VARCHAR(11),               ' +
            '  RED_DTAMOV DATE,                      ' +
            '  RED_NUM_RV VARCHAR(09),               ' +
            '  RED_DTA_RV DATE,                      ' +
            '  RED_CODBAN VARCHAR(01),               ' +
            '  RED_TIPTRA VARCHAR(01),               ' +
            '  RED_VALBRU DECIMAL(13,2),             ' +
            '  RED_VALDES DECIMAL(13,2),             ' +
            '  RED_PARTOT VARCHAR(05),               ' +
            '  RED_STSCRE CHAR(02),                  ' +
            '  RED_PV_ORI VARCHAR(09),               ' +
            '  RED_DTAVEN DATE,                      ' +
            '  RED_VALORI DECIMAL(15,2),             ' +
            '  RED_DTAARQ DATE,                      ' +
            '  RED_NOMARQ VARCHAR(255),              ' +
            '  RED_CONCIL INTEGER DEFAULT 0,         ' +
            '  RED_PARCEL CHAR(1),                   ' +
            '  RED_IMPTOT INTEGER DEFAULT 0,         ' +
            '  RED_DTAIMP DATE,                      ' +
            '  RED_CARDEB VARCHAR(16),               ' +
            '  RED_REGDEB CHAR(3),                   ' +
            '  RED_VALDEB DECIMAL(15,2),             ' +
            '  RED_AUTDEB VARCHAR(6),                ' +
            '  RED_NSUDEB VARCHAR(12),               ' +
            '  RED_MOTAJU VARCHAR(28),               ' +
            '  RED_TIPNEG VARCHAR(1),                ' +
            '  RED_CONNEG VARCHAR(17),               ' +
            '  RED_CNPPAR VARCHAR(15),               ' +
            '  RED_NUM_OC VARCHAR(11) DEFAUT '''',   ' +
            '  RED_DTANEG DATE,                      ' +
            '  PRIMARY KEY(RED_TIPREG,               ' +
            '              RED_NUM_PV,               ' +
            '              RED_NUM_RV,               ' +
            '              RED_DTA_RV,               ' +
            '              RED_PARTOT,               ' +
            '              RED_NUM_OC)) ENGINE INNODB';
end;

procedure TRedeCredito.pAdicionaLinha(strString: String);
var
  LEncontrou034Zerado : Boolean;
  LIndiceRegistros    : Integer;
  LQryBusca034Zerado  : TUniQuery;

  Const
    AUMENTO_CAPACIDADE_FREG  = 2000;

  function fGetDados(intIni, intTam: Integer; blnFlt: Boolean = False): Variant;
    Var
      rst: Variant;
  Begin
    rst := Trim(Copy(strString, intIni, intTam));
    If blnFlt Then rst := TRedeCardFuncoes.fStrToFloat(rst) / 100;

    Result := rst;
  End;

begin

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If LeftStr(strString, 3) = '006' Then
  Begin
    If intPosicaoAtualFReg6 = Length(FReg6) Then
    Begin
      SetLength(FReg6, Length(FReg6)+AUMENTO_CAPACIDADE_FREG);
    End;

    FReg6[intPosicaoAtualFReg6].strTipReg := fGetDados(001,03);
    FReg6[intPosicaoAtualFReg6].strNum_PV := fGetDados(004,09);
    FReg6[intPosicaoAtualFReg6].strNum_RV := fGetDados(013,09);
    FReg6[intPosicaoAtualFReg6].strNumBco := fGetDados(022,03);
    FReg6[intPosicaoAtualFReg6].strNumAge := fGetDados(025,05);
    FReg6[intPosicaoAtualFReg6].strNumCCo := fGetDados(030,11);
    FReg6[intPosicaoAtualFReg6].strDta_RV := fGetDados(041,08);
    FReg6[intPosicaoAtualFReg6].strQtdCVa := fGetDados(049,05);
    FReg6[intPosicaoAtualFReg6].fltValBru := fGetDados(054,15,True);
    FReg6[intPosicaoAtualFReg6].fltValGor := fGetDados(069,15,True);
    FReg6[intPosicaoAtualFReg6].fltValRej := fGetDados(084,15,True);
    FReg6[intPosicaoAtualFReg6].fltValDes := fGetDados(099,15,True);
    FReg6[intPosicaoAtualFReg6].fltValLiq := fGetDados(114,15,True);
    FReg6[intPosicaoAtualFReg6].strDtaCre := fGetDados(129,08);
    FReg6[intPosicaoAtualFReg6].strCodBan := fGetDados(137,01);

    Inc(intPosicaoAtualFReg6);
  End

  Else If LeftStr(strString, 3) = '008' Then
  Begin
    If intPosicaoAtualFReg8 = Length(FReg8) Then
    Begin
      SetLength(FReg8, Length(FReg8)+AUMENTO_CAPACIDADE_FREG);
    End;

    FReg8[intPosicaoAtualFReg8].strTipReg := fGetDados(001,03);
    FReg8[intPosicaoAtualFReg8].strNum_PV := fGetDados(004,09);
    FReg8[intPosicaoAtualFReg8].strNum_RV := fGetDados(013,09);
    FReg8[intPosicaoAtualFReg8].strDta_CV := fGetDados(022,08);
    FReg8[intPosicaoAtualFReg8].strZeros_ := fGetDados(030,08);
    FReg8[intPosicaoAtualFReg8].fltVal_CV := fGetDados(038,15,True);
    FReg8[intPosicaoAtualFReg8].fltValGer := fGetDados(053,15,True);
    FReg8[intPosicaoAtualFReg8].strNumCar := fGetDados(068,16);
    FReg8[intPosicaoAtualFReg8].strSts_CV := fGetDados(084,03);
    FReg8[intPosicaoAtualFReg8].strNum_CV := fGetDados(087,12);
    FReg8[intPosicaoAtualFReg8].strNumRef := fGetDados(099,13);
    FReg8[intPosicaoAtualFReg8].fltValDes := fGetDados(112,15,True);
    FReg8[intPosicaoAtualFReg8].strNumAut := fGetDados(127,06);
    FReg8[intPosicaoAtualFReg8].strHraTra := fGetDados(133,06);
    FReg8[intPosicaoAtualFReg8].strNumBi1 := fGetDados(139,16);
    FReg8[intPosicaoAtualFReg8].strNumBi2 := fGetDados(155,16);
    FReg8[intPosicaoAtualFReg8].strNumBi3 := fGetDados(171,16);
    FReg8[intPosicaoAtualFReg8].strNumBi4 := fGetDados(187,16);
    FReg8[intPosicaoAtualFReg8].strTipCap := fGetDados(203,01);
    FReg8[intPosicaoAtualFReg8].fltValLiq := fGetDados(204,15,True);
    FReg8[intPosicaoAtualFReg8].strNumTer := fGetDados(219,08);
    FReg8[intPosicaoAtualFReg8].strSigPai := fGetDados(227,03);
    FReg8[intPosicaoAtualFReg8].strCodBan := fGetDados(230,01);
    FReg8[intPosicaoAtualFReg8].strBaixad := 'N';
    FReg8[intPosicaoAtualFReg8].strSeqLot := '';

    Inc(intPosicaoAtualFReg8);
  End

  Else If LeftStr(strString, 3) = '010' Then
  Begin
    If intPosicaoAtualFReg10 = Length(FReg10) Then
    Begin
      SetLength(FReg10, Length(FReg10)+AUMENTO_CAPACIDADE_FREG);
    End;

    FReg10[intPosicaoAtualFReg10].strTipReg := fGetDados(001,03);
    FReg10[intPosicaoAtualFReg10].strNum_PV := fGetDados(004,09);
    FReg10[intPosicaoAtualFReg10].strNum_RV := fGetDados(013,09);
    FReg10[intPosicaoAtualFReg10].strNumBco := fGetDados(022,03);
    FReg10[intPosicaoAtualFReg10].strNumAge := fGetDados(025,05);
    FReg10[intPosicaoAtualFReg10].strNumCCo := fGetDados(030,11);
    FReg10[intPosicaoAtualFReg10].strDta_RV := fGetDados(041,08);
    FReg10[intPosicaoAtualFReg10].strQtd_CV := fGetDados(049,05);
    FReg10[intPosicaoAtualFReg10].fltValBru := fGetDados(054,15,True);
    FReg10[intPosicaoAtualFReg10].fltValGor := fGetDados(069,15,True);
    FReg10[intPosicaoAtualFReg10].fltValRej := fGetDados(084,15,True);
    FReg10[intPosicaoAtualFReg10].fltValDes := fGetDados(099,15,True);
    FReg10[intPosicaoAtualFReg10].fltValLiq := fGetDados(114,15,True);
    FReg10[intPosicaoAtualFReg10].strDtaCre := fGetDados(129,08);
    FReg10[intPosicaoAtualFReg10].strCodBan := fGetDados(137,01);

    Inc(intPosicaoAtualFReg10);
  End

  Else If LeftStr(strString, 3) = '012' Then
  Begin
    If intPosicaoAtualFReg12 = Length(FReg12) Then
    Begin
      SetLength(FReg12, Length(FReg12)+AUMENTO_CAPACIDADE_FREG);
    End;

    FReg12[intPosicaoAtualFReg12].strTipReg := fGetDados(001,03);
    FReg12[intPosicaoAtualFReg12].strNum_PV := fGetDados(004,09);
    FReg12[intPosicaoAtualFReg12].strNum_RV := fGetDados(013,09);
    FReg12[intPosicaoAtualFReg12].strDta_CV := fGetDados(022,08);
    FReg12[intPosicaoAtualFReg12].strZeros_ := fGetDados(030,08);
    FReg12[intPosicaoAtualFReg12].fltVal_CV := fGetDados(038,15,True);
    FReg12[intPosicaoAtualFReg12].fltValGor := fGetDados(053,15,True);
    FReg12[intPosicaoAtualFReg12].strNumCar := fGetDados(068,16);
    FReg12[intPosicaoAtualFReg12].strSts_CV := fGetDados(084,03);
    FReg12[intPosicaoAtualFReg12].strQtdPar := fGetDados(087,02);
    FReg12[intPosicaoAtualFReg12].strNum_CV := fGetDados(089,12);
    FReg12[intPosicaoAtualFReg12].strNumRef := fGetDados(101,13);
    FReg12[intPosicaoAtualFReg12].fltValDes := fGetDados(114,15,True);
    FReg12[intPosicaoAtualFReg12].strNumAut := fGetDados(129,06);
    FReg12[intPosicaoAtualFReg12].strHraTra := fGetDados(135,06);
    FReg12[intPosicaoAtualFReg12].strNumBi1 := fGetDados(141,16);
    FReg12[intPosicaoAtualFReg12].strNumBi2 := fGetDados(157,16);
    FReg12[intPosicaoAtualFReg12].strNumBi3 := fGetDados(173,16);
    FReg12[intPosicaoAtualFReg12].strNumBi4 := fGetDados(189,16);
    FReg12[intPosicaoAtualFReg12].strTipCap := fGetDados(205,01);
    FReg12[intPosicaoAtualFReg12].fltValLiq := fGetDados(206,15,True);
    FReg12[intPosicaoAtualFReg12].fltLiqPri := fGetDados(221,15,True);
    FReg12[intPosicaoAtualFReg12].fltLiqDem := fGetDados(236,15,True);
    FReg12[intPosicaoAtualFReg12].strNumTer := fGetDados(251,08);
    FReg12[intPosicaoAtualFReg12].strSigPai := fGetDados(259,03);
    FReg12[intPosicaoAtualFReg12].strCodBan := fGetDados(262,01);
    FReg12[intPosicaoAtualFReg12].strBaixad := 'N';
    FReg12[intPosicaoAtualFReg12].strSeqLot := '';

    Inc(intPosicaoAtualFReg12);
  End

  Else If LeftStr(strString, 3) = '014' Then
  Begin
    If intPosicaoAtualFReg14 = Length(FReg14) Then
    Begin
      SetLength(FReg14, Length(FReg14)+AUMENTO_CAPACIDADE_FREG);
    End;

    FReg14[intPosicaoAtualFReg14].strTipReg := fGetDados(001,03);
    FReg14[intPosicaoAtualFReg14].strNum_PV := fGetDados(004,09);
    FReg14[intPosicaoAtualFReg14].strNum_RV := fGetDados(013,09);
    FReg14[intPosicaoAtualFReg14].strDta_RV := fGetDados(022,08);
    FReg14[intPosicaoAtualFReg14].strQtdPar := fGetDados(038,02);
    FReg14[intPosicaoAtualFReg14].fltValBru := fGetDados(040,15,True);
    FReg14[intPosicaoAtualFReg14].fltValDes := fGetDados(055,15,True);
    FReg14[intPosicaoAtualFReg14].fltValLiq := fGetDados(070,15,True);
    FReg14[intPosicaoAtualFReg14].strDtaCre := fGetDados(085,08);

    Inc(intPosicaoAtualFReg14);
  End

  Else If (LeftStr(strString, 3) = '034') Then
  Begin
    If intPosicaoAtualFReg34 = Length(FReg34) Then
    Begin
      SetLength(FReg34, Length(FReg34)+AUMENTO_CAPACIDADE_FREG);
    End;

    If (Trim(fGetDados(125,05)) <> '') Then
    Begin
      FReg34[intPosicaoAtualFReg34].strTipReg := fGetDados(001,03);
      FReg34[intPosicaoAtualFReg34].strNum_PV := fGetDados(004,09);
      FReg34[intPosicaoAtualFReg34].strNumDoc := fGetDados(013,11);
      FReg34[intPosicaoAtualFReg34].strDtaLan := fGetDados(024,08);
      FReg34[intPosicaoAtualFReg34].fltValLan := fGetDados(032,15,True);
      FReg34[intPosicaoAtualFReg34].strCredit := fGetDados(047,01);
      FReg34[intPosicaoAtualFReg34].strNumBco := fGetDados(048,03);
      FReg34[intPosicaoAtualFReg34].strNumAge := fGetDados(051,06);
      FReg34[intPosicaoAtualFReg34].strNumCCo := fGetDados(057,11);
      FReg34[intPosicaoAtualFReg34].strDtaMov := fGetDados(068,08);
      FReg34[intPosicaoAtualFReg34].strNum_RV := fGetDados(076,09);
      FReg34[intPosicaoAtualFReg34].strDta_RV := fGetDados(085,08);
      FReg34[intPosicaoAtualFReg34].strCodBan := fGetDados(093,01);
      FReg34[intPosicaoAtualFReg34].strTipTra := fGetDados(094,01);
      FReg34[intPosicaoAtualFReg34].fltValBru := fGetDados(095,15,True);
      FReg34[intPosicaoAtualFReg34].fltValDes := fGetDados(110,15,True);
      FReg34[intPosicaoAtualFReg34].strParTot := fGetDados(125,05);
      FReg34[intPosicaoAtualFReg34].strStsCre := fGetDados(130,02);
      FReg34[intPosicaoAtualFReg34].strPV_Ori := fGetDados(132,09);
      FReg34[intPosicaoAtualFReg34].strNomArq := strNomArq;
      FReg34[intPosicaoAtualFReg34].strDtaArq := strDtaArq;
      FReg34[intPosicaoAtualFReg34].strParcel := fGetLetraAlfa(StrtoInt(LeftStr(FReg34[intPosicaoAtualFReg34].strParTot,2)));

      If FReg34[intPosicaoAtualFReg34].strParcel = #0 Then
        FReg34[intPosicaoAtualFReg34].strParcel := 'A';

      FReg34[intPosicaoAtualFReg34].strDtaImp := FormatDateTime('yyyy-mm-dd', nOw);

      If (FReg34[intPosicaoAtualFReg34].strNum_PV <> '') And
       (VS_ListaEstabelecimentos.IndexOf(FReg34[intPosicaoAtualFReg34].strNum_PV) < 0) Then
      VS_ListaEstabelecimentos.Add(FReg34[intPosicaoAtualFReg34].strNum_PV);

      Inc(intPosicaoAtualFReg34);
    end;
  End
  Else If (LeftStr(strString, 3) = '036') Then
  Begin
    If intPosicaoAtualFReg34 = Length(FReg34) Then
    Begin
      SetLength(FReg34, Length(FReg34)+AUMENTO_CAPACIDADE_FREG);
    End;

    If (Trim(fGetDados(108,05)) <> '') Then
    Begin
      FReg34[intPosicaoAtualFReg34].strTipReg := fGetDados(001,03);
      FReg34[intPosicaoAtualFReg34].strNum_PV := fGetDados(004,09);
      FReg34[intPosicaoAtualFReg34].strNumDoc := fGetDados(013,11);
      FReg34[intPosicaoAtualFReg34].strDtaLan := fGetDados(024,08);
      FReg34[intPosicaoAtualFReg34].fltValLan := fGetDados(032,15,True);
      FReg34[intPosicaoAtualFReg34].strCredit := fGetDados(047,01);
      FReg34[intPosicaoAtualFReg34].strNumBco := fGetDados(048,03);
      FReg34[intPosicaoAtualFReg34].strNumAge := fGetDados(051,06);
      FReg34[intPosicaoAtualFReg34].strNumCCo := fGetDados(057,11);
      FReg34[intPosicaoAtualFReg34].strNum_RV := fGetDados(068,09);
      FReg34[intPosicaoAtualFReg34].strDta_RV := fGetDados(077,08);
      FReg34[intPosicaoAtualFReg34].fltValOri := fGetDados(085,15,True);
      FReg34[intPosicaoAtualFReg34].strDtaVen := fGetDados(100,08);
      FReg34[intPosicaoAtualFReg34].strParTot := fGetDados(108,05);
      FReg34[intPosicaoAtualFReg34].fltValBru := fGetDados(113,15,True);
      FReg34[intPosicaoAtualFReg34].fltValDes := fGetDados(128,15,True);
      FReg34[intPosicaoAtualFReg34].strPV_Ori := fGetDados(143,09);
      FReg34[intPosicaoAtualFReg34].strCodBan := fGetDados(152,01);
      FReg34[intPosicaoAtualFReg34].strNomArq := strNomArq;
      FReg34[intPosicaoAtualFReg34].strDtaArq := strDtaArq;
      FReg34[intPosicaoAtualFReg34].strParcel := fGetLetraAlfa(StrtoInt(LeftStr(FReg34[intPosicaoAtualFReg34].strParTot,2)));

      If FReg34[intPosicaoAtualFReg34].strParcel = #0 Then
        FReg34[intPosicaoAtualFReg34].strParcel := 'A';

      FReg34[intPosicaoAtualFReg34].strDtaImp := FormatDateTime('yyyy-mm-dd', nOw);

      If (FReg34[intPosicaoAtualFReg34].strNum_PV <> '') And
       (VS_ListaEstabelecimentos.IndexOf(FReg34[intPosicaoAtualFReg34].strNum_PV) < 0) Then
      VS_ListaEstabelecimentos.Add(FReg34[intPosicaoAtualFReg34].strNum_PV);

      Inc(intPosicaoAtualFReg34);
    End;
  End
  Else If (LeftStr(strString, 3) = '035') Then
  Begin
    If intPosicaoAtualFReg34 = Length(FReg34) Then
      SetLength(FReg34, Length(FReg34)+AUMENTO_CAPACIDADE_FREG);

    FReg34[intPosicaoAtualFReg34].strTipReg := fGetDados(001,03);
    FReg34[intPosicaoAtualFReg34].strNum_PV := fGetDados(004,09);
    FReg34[intPosicaoAtualFReg34].strNumDoc := fGetDados(013,11);
    FReg34[intPosicaoAtualFReg34].strDtaLan := fGetDados(171,08);
    if fGetDados(171,08) = '00000000' then
      FReg34[intPosicaoAtualFReg34].strDtaLan := fGetDados(024,08);
    FReg34[intPosicaoAtualFReg34].fltValLan := fGetDados(030,15,True) * (-1);
    FReg34[intPosicaoAtualFReg34].fltValBru := fGetDados(209,15,True);
    FReg34[intPosicaoAtualFReg34].strNum_RV := fGetDados(100,09);
    FReg34[intPosicaoAtualFReg34].strDtaMov := fGetDados(092,08);
    FReg34[intPosicaoAtualFReg34].strDta_RV := fGetDados(092,08);

    If FReg34[intPosicaoAtualFReg34].strDta_RV = '00000000' Then
      FReg34[intPosicaoAtualFReg34].strDta_RV := FReg34[intPosicaoAtualFReg34].strDtaLan;

    FReg34[intPosicaoAtualFReg34].strRegDeb := fGetDados(001,03);
    FReg34[intPosicaoAtualFReg34].fltValDeb := fGetDados(155,15,True);
    If (fGetDados(045,01) = 'D') And (FReg34[intPosicaoAtualFReg34].fltValDeb > 0) Then
      FReg34[intPosicaoAtualFReg34].fltValDeb := FReg34[intPosicaoAtualFReg34].fltValDeb * (-1);
    FReg34[intPosicaoAtualFReg34].strAutDeb := fGetDados(251,06);
    FReg34[intPosicaoAtualFReg34].strNSUDeb := fGetDados(239,12);
    FReg34[intPosicaoAtualFReg34].strCarDeb := fGetDados(076,16);
    FReg34[intPosicaoAtualFReg34].strMotAju := fGetDados(048,28);
    FReg34[intPosicaoAtualFReg34].strParTot := '01/01';

    If (FReg34[intPosicaoAtualFReg34].strNum_RV <> '000000000') And
       (FReg34[intPosicaoAtualFReg34].fltValDeb <> 0) Then
    Begin
      LEncontrou034Zerado := False;

      // Primeiro Busca no array em memoria - caso previsto: 034 zerado veio no mesmo EEFI
      For LIndiceRegistros := 0 To intPosicaoAtualFReg34 - 1 Do
      Begin
        If (FReg34[LIndiceRegistros].strTipReg = '034') And
           (FReg34[LIndiceRegistros].strNum_PV = FReg34[intPosicaoAtualFReg34].strNum_PV) And
           (FReg34[LIndiceRegistros].strNum_RV = FReg34[intPosicaoAtualFReg34].strNum_RV) And
           (FReg34[LIndiceRegistros].fltValLan = 0) And
           (Abs(FReg34[LIndiceRegistros].fltValBru) = Abs(FReg34[intPosicaoAtualFReg34].fltValDeb)) Then
        Begin
          LEncontrou034Zerado := True;
          Break;
        End;
      End;

      // Não encontrei no manual a possibilidade do 034 zerado ser importado em EEFI anterior
      // Eles via de regra andam juntos, no mesmo arquivo, deixei aqui para garantia de cenários
      If not LEncontrou034Zerado Then
      Begin
        LQryBusca034Zerado := VS_FuncoesExternas.fICriaQuery;
        Try
          LQryBusca034Zerado.SQL.Text := 'SELECT 1 FROM RED_EFIR34 ' +
                                         ' WHERE RED_TIPREG = "034" ' +
                                         '   AND RED_NUM_PV = :NUM_PV ' +
                                         '   AND RED_NUM_RV = :NUM_RV ' +
                                         '   AND RED_VALLAN = 0 ' +
                                         '   AND ABS(RED_VALBRU) = :VALDEB ' +
                                         ' LIMIT 1';
          LQryBusca034Zerado.ParamByName('NUM_PV').AsString := FReg34[intPosicaoAtualFReg34].strNum_PV;
          LQryBusca034Zerado.ParamByName('NUM_RV').AsString := FReg34[intPosicaoAtualFReg34].strNum_RV;
          LQryBusca034Zerado.ParamByName('VALDEB').AsFloat  := Abs(FReg34[intPosicaoAtualFReg34].fltValDeb);
          LQryBusca034Zerado.Open;

          LEncontrou034Zerado := Not LQryBusca034Zerado.IsEmpty;
        Finally
          LQryBusca034Zerado.Close;
          FreeAndNil(LQryBusca034Zerado);
        End;
      End;

      If LEncontrou034Zerado Then
      Begin
        FReg34[intPosicaoAtualFReg34].fltValDeb := 0;
        FReg34[intPosicaoAtualFReg34].fltValLan := 0;
      End

    End;

    FReg34[intPosicaoAtualFReg34].strNomArq := strNomArq;
    FReg34[intPosicaoAtualFReg34].strDtaArq := strDtaArq;
    FReg34[intPosicaoAtualFReg34].strDtaImp := FormatDateTime('yyyy-mm-dd', nOw);

    If FReg34[intPosicaoAtualFReg34].strNum_RV = '000000000' Then
    Begin
      FReg34[intPosicaoAtualFReg34].strNum_RV := '00000' + IntToStr(LContadorReg35);

      If FReg34[intPosicaoAtualFReg34].strNsuDeb = '000000000000' Then
        FReg34[intPosicaoAtualFReg34].strNsuDeb := '00000' + IntToStr(LContadorReg35);

      Inc(LContadorReg35);
    End;

    Inc(intPosicaoAtualFReg34);
  End
  Else If (LeftStr(strString, 3) = '045') Then
  Begin
    If intPosicaoAtualFReg34 = Length(FReg34) Then
      SetLength(FReg34, Length(FReg34)+AUMENTO_CAPACIDADE_FREG);

    FReg34[intPosicaoAtualFReg34].strTipReg := fGetDados(001,03);
    FReg34[intPosicaoAtualFReg34].strNum_PV := fGetDados(004,09);
    FReg34[intPosicaoAtualFReg34].strNumDoc := fGetDados(013,11);
    FReg34[intPosicaoAtualFReg34].strDtaLan := fGetDados(219,08);
    if fGetDados(219,08) = '00000000' then
      FReg34[intPosicaoAtualFReg34].strDtaLan := fGetDados(024,08);
    FReg34[intPosicaoAtualFReg34].fltValLan := fGetDados(032,15,True) * (-1);
    FReg34[intPosicaoAtualFReg34].strMotAju := fGetDados(049,28);
    FReg34[intPosicaoAtualFReg34].strCarDeb := fGetDados(077,16);
    FReg34[intPosicaoAtualFReg34].strNSUDeb := fGetDados(093,12);
    FReg34[intPosicaoAtualFReg34].strAutDeb := fGetDados(113,06);
    FReg34[intPosicaoAtualFReg34].fltValBru := fGetDados(119,15,True);
    FReg34[intPosicaoAtualFReg34].strNum_RV := fGetDados(134,09);

    FReg34[intPosicaoAtualFReg34].strDtaMov := fGetDados(143,08);
    FReg34[intPosicaoAtualFReg34].strDta_RV := fGetDados(143,08);
    FReg34[intPosicaoAtualFReg34].strRegDeb := fGetDados(001,03);
    FReg34[intPosicaoAtualFReg34].fltValDeb := fGetDados(204,15,True) * (-1);

    If fGetDados(143,08) = '00000000' Then
    Begin
      FReg34[intPosicaoAtualFReg34].strDtaMov := fGetDados(024,08);
      FReg34[intPosicaoAtualFReg34].strDta_RV := fGetDados(024,08);
    End;

    FReg34[intPosicaoAtualFReg34].fltValDes := 0;
    FReg34[intPosicaoAtualFReg34].strParTot := '01/01';
    FReg34[intPosicaoAtualFReg34].strNomArq := strNomArq;
    FReg34[intPosicaoAtualFReg34].strDtaArq := strDtaArq;

    FReg34[intPosicaoAtualFReg34].strDtaImp := FormatDateTime('yyyy-mm-dd', nOw);

    If (FReg34[intPosicaoAtualFReg34].strNum_PV <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FReg34[intPosicaoAtualFReg34].strNum_PV) < 0) Then
    VS_ListaEstabelecimentos.Add(FReg34[intPosicaoAtualFReg34].strNum_PV);

    Inc(intPosicaoAtualFReg34);
  End
  Else If (MatchStr(LeftStr(strString, 3), ['046', '047'])) Then
  Begin
    If intPosicaoAtualFReg34 = Length(FReg34) Then
      SetLength(FReg34, Length(FReg34)+AUMENTO_CAPACIDADE_FREG);

    FReg34[intPosicaoAtualFReg34].strTipReg := fGetDados(001,03);
    FReg34[intPosicaoAtualFReg34].strNum_PV := fGetDados(004,09);
    FReg34[intPosicaoAtualFReg34].strNumDoc := fGetDados(013,11);
    FReg34[intPosicaoAtualFReg34].strDtaLan := fGetDados(146,08);
    FReg34[intPosicaoAtualFReg34].fltValLan := fGetDados(121,17,True);
    FReg34[intPosicaoAtualFReg34].fltValBru := fGetDados(024,17,True);
    FReg34[intPosicaoAtualFReg34].fltValOri := fGetDados(024,17,True);
    FReg34[intPosicaoAtualFReg34].strNum_RV := fGetDados(058,09);
    FReg34[intPosicaoAtualFReg34].strPV_Ori := fGetDados(049,09);
    FReg34[intPosicaoAtualFReg34].strTipTra := fGetDados(075,01);
    FReg34[intPosicaoAtualFReg34].strCodBan := fGetDados(076,01);

    FReg34[intPosicaoAtualFReg34].strDtaMov := fGetDados(041,08);
    FReg34[intPosicaoAtualFReg34].strDta_RV := fGetDados(067,08);

    FReg34[intPosicaoAtualFReg34].strStsCre := fGetDados(174,02);

    FReg34[intPosicaoAtualFReg34].TipoNegociacao := fGetDados(077,01);
    FReg34[intPosicaoAtualFReg34].ContratoNegociacao := fGetDados(078,17);
    FReg34[intPosicaoAtualFReg34].CNPJParceiro := fGetDados(095,15);
    FReg34[intPosicaoAtualFReg34].NumeroOC := fGetDados(110,11);
    FReg34[intPosicaoAtualFReg34].DataNegociacao := fGetDados(138,08);

    FReg34[intPosicaoAtualFReg34].strNumBco := fGetDados(154,03);
    FReg34[intPosicaoAtualFReg34].strNumAge := fGetDados(157,06);
    FReg34[intPosicaoAtualFReg34].strNumCCo := fGetDados(163,11);

    FReg34[intPosicaoAtualFReg34].fltValDes := 0;
    FReg34[intPosicaoAtualFReg34].strParTot := '01/01';
    FReg34[intPosicaoAtualFReg34].strNomArq := strNomArq;
    FReg34[intPosicaoAtualFReg34].strDtaArq := strDtaArq;

    FReg34[intPosicaoAtualFReg34].strDtaImp := FormatDateTime('yyyy-mm-dd', nOw);

    If (FReg34[intPosicaoAtualFReg34].strNum_PV <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FReg34[intPosicaoAtualFReg34].strNum_PV) < 0) Then
    VS_ListaEstabelecimentos.Add(FReg34[intPosicaoAtualFReg34].strNum_PV);

    Inc(intPosicaoAtualFReg34);
  End;

end;

function TRedeCredito.fRetVal(strVal: String): Variant;
Begin
  If strVal.Trim.IsEmpty Then
    Exit(Null);

  Result := strVal;
End;

procedure TRedeCredito.pGravarRegistros(pgbProg: TcxProgressBar);
  Var
    qryDados: TUniQuery;
    strNomEmp: String;
begin
  strNomEmp := FstrNomEmp;

  GravarRegistrosTipo6(pgbProg);

  GravarRegistrosTipo8(pgbProg);

  GravarRegistrosTipo10(pgbProg);

  GravarRegistrosTipo12(pgbProg);

  GravarRegistrosTipo14(pgbProg);

  GravarRegistrosTipo34(pgbProg);

  TRedeCardFuncoes.GravarEstabelecimentos;

  {************************************}
  {* MARCANDO OS ARQUIVOS CONCILIADOS *}
  {* POR COMPLETO                     *}
  {*********************************AJ*}
  qryDados := VS_FuncoesExternas.fICriaQuery;
  Try
    qryDados.SQL.Text := 'UPDATE RED_EFIR34 A SET RED_IMPTOT=1 WHERE ' +
                         ' A.RED_IMPTOT = 0 AND A.RED_TIPREG NOT IN ("035", "045") AND ' +
                         ' A.RED_DTAIMP = ' + VS_FuncoesExternas.fICurrentDate + ' AND ' +
                         '(((SELECT COUNT(*) FROM RED_EVCR10 B WHERE ' +
                         ' B.RED_NUM_PV=A.RED_NUM_PV AND B.RED_NUM_RV=A.RED_NUM_RV AND ' +
                         ' B.RED_DTA_RV=A.RED_DTA_RV) > 0) AND ' +
                         '((SELECT COUNT(*) FROM RED_EVCR12 B WHERE ' +
                         ' B.RED_NUM_PV=A.RED_NUM_PV AND B.RED_NUM_RV=A.RED_NUM_RV AND ' +
                         ' B.RED_DTA_CV=A.RED_DTA_RV) > 0)) ';
    qryDados.ExecSql;

    qryDados.Close;
    qryDados.SQL.Text := 'UPDATE RED_EFIR34 A SET RED_IMPTOT=1 WHERE ' +
                         ' A.RED_IMPTOT = 0 AND A.RED_TIPREG NOT IN ("035", "045") AND ' +
                         ' A.RED_DTAIMP = ' + VS_FuncoesExternas.fICurrentDate + ' AND ' +
                         '(((SELECT COUNT(*) FROM RED_EVCR06 B WHERE ' +
                         ' B.RED_NUM_PV=A.RED_NUM_PV AND B.RED_NUM_RV=A.RED_NUM_RV AND ' +
                         ' B.RED_DTA_RV=A.RED_DTA_RV) > 0) AND ' +
                         '((SELECT COUNT(*) FROM RED_EVCR08 B WHERE ' +
                         ' B.RED_NUM_PV=A.RED_NUM_PV AND B.RED_NUM_RV=A.RED_NUM_RV AND ' +
                         ' B.RED_DTA_CV=A.RED_DTA_RV) > 0)) ';
    qryDados.ExecSql;

    Application.ProcessMessages;

    qryDados.Close;

    qryDados.SQL.Text := 'SELECT RED_NOMARQ, RED_NUM_PV, RED_NUM_RV, RED_DTA_RV, RED_TIPREG, ' +
                         ' RED_DTALAN, RED_VALLAN, RED_PARTOT FROM RED_EFIR34 ' +
                         ' WHERE RED_IMPTOT=0 AND RED_DTAIMP = CURRENT_DATE AND RED_TIPREG NOT IN ("035", "045", "047") ' +
                         ' GROUP BY RED_NOMARQ, RED_NUM_PV, RED_NUM_RV, RED_DTA_RV ORDER BY  ' +
                         ' RED_NOMARQ, RED_NUM_PV, RED_NUM_RV, RED_DTA_RV ';
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    TRedeCardFuncoes.fMensagem('AVISO','Foram encontrados RVs com arquivos de venda faltando!',['&OK']);

    VS_FuncoesExternas.prcIExecutaRelatorio(467,
                                            33624,
                                            [],
                                            [],
                                            [],
                                            Nil,
                                            Nil,
                                            True);
  Finally
    qryDados.Close;
    FreeAndNil(qryDados);
  End;
end;

procedure TRedeCredito.RegistraItemDescartado(const AstrTipoReg, AstrCampo: String);
begin
  FRegistrosDescartados.Add(Format('Registro %s - campo %s vazio',
                                   [AstrTipoReg, AstrCampo]));
end;

destructor TRedeCredito.Destroy;
begin
  FreeAndNil(FRegistrosDescartados);
  inherited;
end;

function TRedeCredito.fAcertaDataParaDiaUtil(
  const dtaOrigem: TDateTime): TDateTime;
begin
  Result := dtaOrigem;
  While (fDiaDeFolga(Result)) Do
    Result := Result + 1;
end;

function TRedeCredito.fDiaDeFolga(dtaDta: TDateTime;
  blnConsideraSabado: Boolean): Boolean;
  Const
    SABADO = 7;
    DOMINGO = 1;
begin
  If blnConsideraSabado Then
    Result := (DayOfWeek(dtaDta) In [DOMINGO, SABADO]) Or (fEhFeriado(dtaDta))
  Else
    Result := (DayOfWeek(dtaDta) = DOMINGO) Or (fEhFeriado(dtaDta));
end;

function TRedeCredito.fEhFeriado(dtaDta: TDateTime): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := VS_FuncoesExternas.fICriaQuery;

  Try
    qryAux.SQL.Text := 'SELECT COUNT(*) AS QTD FROM CADFER WHERE FER_DTAFER = "' + FormatDateTime('yyyy/mm/dd', dtaDta) + '"';
    qryAux.Open;

    Result := qryAux.FieldByName('QTD').AsInteger > 0;
  Finally
    qryAux.Close;
    FreeAndNil(qryAux);
  End;
end;

function TRedeCredito.fFloatToInt(fltNumero: Double): Integer;
begin
  Result := StrToIntDef(FloatToStrF(fltNumero, ffFixed, 12, 0), 0);
end;

function TRedeCredito.fGetLetraAlfa(intCol: Integer): String;
  Var
    strLetra : String;
    intLetra1: Integer;
    intLetra2: Integer;
    fltValor : Double;
begin
  strLetra := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  If intCol > 26 Then
  Begin
    fltValor  := (intCol / 26);
    intLetra1 := fFloatToInt(fltValor - Frac(fltValor));
    intLetra2 := fFloatToInt(intcol Mod 26);

    If intLetra2 = 0 Then
    Begin
      Dec(intLetra1);
      intLetra2 := 26;
    End;

    Result    := strLetra[intLetra1] + strLetra[intLetra2];
  End
  Else
    Result   := strLetra[intCol];

end;

end.
