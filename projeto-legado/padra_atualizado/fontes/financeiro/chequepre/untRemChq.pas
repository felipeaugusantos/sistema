{******************************************}
{* UNIT CRIADA PARA EXPORTAÇÃO DE REMESSA *}
{* DE CHEQUES PARA CUSTORIA, POSSIBILITA  *}
{* IMPLEMENTAR EXPORTAÇÃO DE "N" BANCOS   *}
{*10/12/2013**BB001**ITAU341************JU*}
unit untRemChq;

interface
Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StrUtils, IniFiles, cxProgressBar, Uni, DBClient, DB, System.IOUtils;

Const
  Lay_BB  = '001';
  LayItau = '341';
  LaySantander = '033';
  LayBanrisul = '041';

Type

  {*********************************}
  {* TIPO ABTRATO, GERAR TODOS OS  *}
  {* BANCOS A PARTIR DESTE         *}
  {******************************JU*}
  TRemChq = Class
  private
    function fGetSeqLote(strEmpChq: String): String;
    function fGetSeqArq: Integer;
    procedure pExportaChq(qryCheque: TDataSet);
  protected
    strArq  : String;
    intSeq  : Integer;
    txtArq  : TextFile;
    FNumLot : String;
    FContRg : Integer;
    FQtdChq : Integer;
    FTotChq : Double;
    FContas : TStringList;
    FCGCEmp : String;
    FNomEmp : String;
    FEndere : String;
    FEndNum : String;
    FEndCmp : String;
    FCodCid : String;
    FNomCid : String;
    FEstado : String;
    FCEPEmp : String;
    FDtaCus: TDate;
    function fGetCodBan(): String; Virtual; Abstract;
    function fPrefixCfg(): String; Virtual; Abstract;
    function fNomeArq(): String; Virtual;
    function fValidaCfg(): Boolean; Virtual;
    procedure pIniciaExportacao(qryCheque: TDataSet); Virtual;
    procedure pGeraCabecalho; Virtual; Abstract;
    procedure pGeraCabLote; Virtual; Abstract;
    procedure pGeraDetalhe(qryCheque: TDataSet); Virtual; Abstract;
    procedure pGeraTraLote; Virtual; Abstract;
    procedure pGeraTrailer; Virtual; Abstract;
    procedure pFinalizaExportacao(); Virtual;
  public
    qryGenEmp : TUniQuery;
    Destructor Destroy; override;
    procedure pCarregaDadosEmpresa(fltValSel: Double; intQtdSel: Integer; dteDtaCus: TDate);

    class function fCriaRemChq(Owner: TComponent; strCodBco: String; qryCheque: TDataSet; fltValSel: Double; intQtdSel: Integer; dteDtaCus: TDate): TRemChq;

    property strNumLot: String      Read FNumLot Write FNumLot;
    property intContRg: Integer     Read FContRg Write FContRg;
    property intQtdChq: Integer     Read FQtdChq Write FQtdChq;
    property fltTotChq: Double      Read FTotChq Write FTotChq;
    property stlContas: TStringList Read FContas Write FContas;
    property strCGCEmp: String      Read FCGCEmp Write FCGCEmp;
    property strNomEmp: String      Read FNomEmp Write FNomEmp;
    property strEndere: String      Read FEndere Write FEndere;
    property strEndNum: String      Read FEndNum Write FEndNum;
    property strEndCmp: String      Read FEndCmp Write FEndCmp;
    property strCodCid: String      Read FCodCid Write FCodCid;
    property strNomCid: String      Read FNomCid Write FNomCid;
    property strEstado: String      Read FEstado Write FEstado;
    property strCepEmp: String      Read FCEPEmp Write FCEPEmp;
    property dtaDtaCus: TDate       Read FDtaCus Write FDtaCus;
  End;

  {******************************}
  {* TIPO BANCO DO BRASIL       *}
  {***************************JU*}
  TRemChq001 = Class (TRemChq)
  protected
    function fGetCodBan(): String; Override;
    function fPrefixCfg(): String; Override;
    procedure pGeraCabecalho; Override;
    procedure pGeraCabLote; Override;
    procedure pGeraDetalhe(qryCheque: TDataSet); Override;
    procedure pGeraTraLote; Override;
    procedure pGeraTrailer; Override;
  End;

  {*****************************}
  {* TIPO ITAU                 *}
  {**************************JU*}
  TRemChq341 = Class (TRemChq)
  protected
    function fGetCodBan(): String; Override;
    function fPrefixCfg(): String; Override;
    function fValidaCfg(): Boolean; Override;
    procedure pGeraCabecalho; Override;
    procedure pGeraCabLote; Override;
    procedure pGeraDetalhe(qryCheque: TDataSet); Override;
    procedure pGeraTraLote; Override;
    procedure pGeraTrailer; Override;
  End;

  {*****************************}
  {* TIPO SANTANDER            *}
  {**************************RS*}
  TRemChq033 = Class (TRemChq)
  protected
    function fGetCodBan(): String; Override;
    function fPrefixCfg(): String; Override;
    function fValidaCfg(): Boolean; Override;
    procedure pGeraCabecalho; Override;
    procedure pGeraCabLote; Override;
    procedure pGeraDetalhe(qryCheque: TDataSet); Override;
    procedure pGeraTraLote; Override;
    procedure pGeraTrailer; Override;
  End;

  {*****************************}
  {* TIPO BANRISUL             *}
  {**************************RS*}
  TRemChq041 = Class (TRemChq)
  private
    intIndInterface: Integer;
    intContTotal: Integer;
    strSeq: String;
    function fIncrementaString(strValor: String): String;
    function fIncrementaChar(chrValor: Char): Char;
  protected
    function fGetCodBan(): String; Override;
    function fPrefixCfg(): String; Override;
    function fNomeArq(): String; Override;
    function fValidaCfg(): Boolean; Override;
    procedure pIniciaExportacao(qryCheque: TDataSet); Override;
    procedure pGeraCabecalho; Override;
    procedure pGeraCabLote; Override;
    procedure pGeraDetalhe(qryCheque: TDataSet); Override;
    procedure pGeraTraLote; Override;
    procedure pGeraTrailer; Override;
    procedure pFinalizaExportacao(); Override;
  End;

implementation
uses  untfuncoesSimples,  MaskUtils;

{ TRemChq }

destructor TRemChq.Destroy;
begin
  If Assigned(qryGenEmp) Then
    FreeAndNil(qryGenEmp);

  inherited Destroy;
end;

class function TRemChq.fCriaRemChq(Owner: TComponent; strCodBco: String;
  qryCheque: TDataSet; fltValSel: Double; intQtdSel: Integer; dteDtaCus: TDate): TRemChq;
begin

  If strCodBco = Lay_BB Then
    Result := TRemChq001.Create()
  Else If strCodBco = LayItau Then
    Result := TRemChq341.Create()
  Else If strCodBco = LaySantander Then
    Result := TRemChq033.Create()
  Else If strCodBco = LayBanrisul Then
    Result := TRemChq041.Create();

  If not Result.fValidaCfg() Then
  Begin
    FreeAndNil(Result);
    Exit;
  End;

  try
    Result.pCarregaDadosEmpresa(fltValSel, intQtdSel, dteDtaCus);
    Result.pExportaChq(qryCheque);
  except
    pMensagensErro('Não foi possivel criar o arquivo ' + Result.strArq, 'TRemChq.fCriaRemChq');
    FreeAndNil(Result);
  end;
end;

function TRemChq.fGetSeqArq: Integer;
begin

  Result := fCfgSisL(fPrefixCfg() + 'NREM', varInteger);
  fAtuCfgSis(fPrefixCfg() + 'NREM', fStrZero(Result + 1, 6));

end;

function TRemChq.fGetSeqLote(strEmpChq: String): String;
  Var
    qryGenCtr: TUniQuery;
begin
  Try
    qryGenCtr := fCriaQuery;

    Repeat
      Result := fRetSequencial(fPrefixCfg() + 'PXLT');

      With qryGenCtr Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT CHQ_NUMCHQ ');
        SQL.Add('  FROM CADCHQ     ');
        SQL.Add(' WHERE CHQ_LOTCUS = :LOTCUS ');
        SQL.Add('   AND CHQ_CODEMP = :CODEMP ');

        ParamByName('LOTCUS').AsString := Result;
        ParamByName('CODEMP').AsString := strEmpChq;

        Open;
      End;
    Until qryGenCtr.IsEmpty;

  Finally
    FreeAndNil(qryGenCtr);
  End;
end;

function TRemChq.fNomeArq: String;
begin
  Result := fCfgSis(fPrefixCfg() + 'PATH') +
                     '\CUSTODIA_' + FormatDateTime('YYYYMMDD', VS_Date) + '.TXT';
end;

function TRemChq.fValidaCfg: Boolean;
var
  strPath: String;
begin

  Result := True;
  strPath := fCfgSis(fPrefixCfg() + 'PATH');

  If fEmptyStr(strPath) Then
  Begin
    fMensagem('', 'É necessário informar o Path para exportação do arquivo' + #13#10 +
                  'na opção "Custódia de Cheques" nas Configurações do Sistema.', ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not DirectoryExists(strPath) Then
  Begin
    fMensagem('', 'O caminho informado para geração do arquivo de Custódia' + #13#10 + 'não existe ou é inválido!', ['&Ok']);
    Result := False;
    Exit;
  End;

  try
    TDirectory.SetCurrentDirectory(strPath);
  except
    fMensagem('', 'O caminho informado para geração do arquivo de Custódia' + #13#10 + 'não é acessível ao usuário do sistema operacional!', ['&Ok']);
    Result := False;
    Exit;
  End;

end;

procedure TRemChq.pCarregaDadosEmpresa(fltValSel: Double; intQtdSel: Integer;
  dteDtaCus: TDate);
  Var
    strSQL : String;

begin
  qryGenEmp := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT        ';
  strSQL := strSQL + '  EMP_C_G_C_, ';
  strSQL := strSQL + '  EMP_NOMEMP, ';
  strSQL := strSQL + '  EMP_ENDERE, ';
  strSQL := strSQL + '  EMP_ENDNUM, ';
  strSQL := strSQL + '  EMP_ENDCMP, ';
  strSQL := strSQL + '  EMP_CODCID, ';
  strSQL := strSQL + '  CID_NOMCID, ';
  strSQL := strSQL + '  CID_ESTADO, ';
  strSQL := strSQL + '  EMP_C_E_P_  ';
  strSQL := strSQL + 'FROM          ';
  strSQL := strSQL + '  CADEMP      ';
  strSQL := strSQL + '  INNER JOIN CADCID ON CID_CODCID = EMP_CODCID ';
  strSQL := strSQL + 'WHERE         ';
  strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

  With qryGenEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    FCGCEmp := FieldByName('EMP_C_G_C_').AsString;
    FNomEmp := FieldByName('EMP_NOMEMP').AsString;
    FEndere := FieldByName('EMP_ENDERE').AsString;
    FEndNum := FieldByName('EMP_ENDNUM').AsString;
    FEndCmp := FieldByName('EMP_ENDCMP').AsString;
    FCodCid := FieldByName('EMP_CODCID').AsString;
    FNomCid := FieldByName('CID_NOMCID').AsString;
    FEstado := FieldByName('CID_ESTADO').AsString;
    FCEPEmp := FieldByName('EMP_C_E_P_').AsString;

  End;

  FQtdChq := intQtdSel;
  FTotChq := fltValSel;
  FDtaCus := dteDtaCus;
  FContas := TStringList.Create;
  FContas.Duplicates := dupIgnore;
end;

procedure TRemChq.pExportaChq(qryCheque: TDataSet);
begin

  Try
    FNumLot := VS_strCodEmp + fGetCodBan() + fGetSeqLote(VS_strCodEmp);

    pIniciaExportacao(qryCheque);
    pGeraCabecalho;
    pGeraCabLote;
    pGeraDetalhe(qryCheque);
    pGeraTraLote;
    pGeraTrailer;
    pFinalizaExportacao;
  Except
    On E: exception Do
    Begin
      Raise;
    End;
  End;

  CloseFile(txtArq);

end;

procedure TRemChq.pFinalizaExportacao;
begin

end;

procedure TRemChq.pIniciaExportacao(qryCheque: TDataSet);
begin
  strArq := fNomeArq();
  intSeq := fGetSeqArq;
  AssignFile(txtArq, strArq);
  Rewrite(txtArq);
end;

{ TRemChq341 }

function TRemChq341.fGetCodBan: String;
begin
  Result := LayItau;
end;

function TRemChq341.fPrefixCfg: String;
begin
  Result := 'IT';
end;

function TRemChq341.fValidaCfg: Boolean;
begin
  Result := inherited fValidaCfg();
  If Not Result Then
    Exit;

  If fEmptyStr(fCfgSis('ITAGMC')) Then
  Begin
    fMensagem('', 'É necessário informar o número da agência mantenedora da conta' + #13#10 + 'nas Configurações do Sistema.', ['&Ok']);
    Result := False;
    Exit;
  End;

  If fEmptyStr(fCfgSis('ITNRCC')) Then
  Begin
    fMensagem('', 'É necessário informar o número da conta corrente' + #13#10 + 'nas Configurações do Sistema.', ['&Ok']);
    Result := False;
    Exit;
  End;

  If fEmptyStr(fCfgSis('ITDVAC')) Then
  Begin
    fMensagem('', 'É necessário informar o dígito verificador da agência mantenedora da conta' + #13#10 + 'nas Configurações do Sistema.', ['&Ok']);
    Result := False;
    Exit;
  End;
end;

procedure TRemChq341.pGeraCabecalho;
var
  strLinha: String;
begin
  {*****************************************}
  {* HEADER DE ARQUIVO - REGISTRO = 0      *}
  {**************************************JU*}

  strLinha := LayItau;                                            // 001/003 - COD BANCO COMPENSAÇÃO
  strLinha := strLinha + '0000';                                  // 004/007 - LOTE DE SERVIÇO
  strLinha := strLinha + '0';                                     // 008/008 - REGISTRO HEADER DE ARQUIVO
  strLinha := strLinha + '         ';                             // 009/017 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + '2';                                     // 018/018 - TIPO DE INSCRIÇÃO (CPF/CGC)
  strLinha := strLinha + fPadL(FCGCEmp,14,'0');                   // 019/032 - NRO INSCRIÇÃO DA EMPRESA
  strLinha := strLinha + fPadL(' ', 20, ' ');                     // 033/052 - COD DE CONVENIO NO BANCO (NÃO USADO NO ITAU SEMPRE BRANCOS)
  strLinha := strLinha + fPadL('0', 1);                           // 053/053 - COMPLEMENTO DE REGISTRO = ZERO
  strLinha := strLinha + fPadL(fCfgSis('ITAGMC'), 4, '0');        // 054/057 - AGENCIA MANTENEDORA DA CONTA
  strLinha := strLinha + fPadR(' ', 1);                           // 058/058 - COMPLEMENTO DE REGISTRO
  strLinha := strLinha + fPadR('0', 7, '0');                      // 059/065 - COMPLEMENTO DE REGISTRO
  strLinha := strLinha + fPadL(fCfgSis('ITNRCC'), 5, '0');        // 066/070 - NUMERO DA CONTA CORRENTE
  strLinha := strLinha + fPadL(' ', 1);                           // 071/071 - COMPLEMENTO DE REGISTRO
  strLinha := strLinha + fPadR(fCfgSis('ITDVAC'), 1);             // 072/072 - DIGITO VERIF DA AG/CONTA
  strLinha := strLinha + fPadR(fTiraCaracEspeciais(FNomEmp), 30); // 073/102 - NOME DA EMPRESA
  strLinha := strLinha + fPadR(fRetNomBanco(LayItau), 30);        // 103/132 - NOME DO BANCO
  strLinha := strLinha + fPadR(' ', 10);                          // 133/142 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + '1';                                     // 143/143 - IDENTIFICADOR DO TIPO DE ARQ
  strLinha := strLinha + FormatDateTime('DDMMYYYY', VS_Date);     // 144/151 - DATA GERAÇÃO DO ARQUIVO
  strLinha := strLinha + FormatDateTime('HHMMSS', fTime());       // 152/157 - HORA GERAÇÃO DO ARQUIVO
  strLinha := strLinha + fStrZero(intSeq, 6);                     // 158/163 - NRO SEQUENCIAL DO ARQUIVO
  strLinha := strLinha + '040';                                   // 164/166 - NRO DA VERSÃO DO LAYOUT
  strLinha := strLinha + '00000';                                 // 167/171 - COMPLEMENTO DE REGISTRO
  strLinha := strLinha + fPadR(' ', 20);                          // 172/191 - USO RESERVADO DO BANCO
  strLinha := strLinha + fPadR(' ', 49);                          // 192/240 - BRANCOS

  Writeln(txtArq, strLinha);

end;

procedure TRemChq341.pGeraCabLote;
var
  strLinha: String;
begin

  {*****************************************}
  {* HEADER DE LOTE - REGISTRO = 1         *}
  {**************************************JU*}

  strLinha := LayItau;                                            // 001/003 - COD BANCO COMPENSAÇÃO
  strLinha := strLinha + '0001';                                  // 004/007 - LOTE DE SERVIÇO
  strLinha := strLinha + '1';                                     // 008/008 - REGISTRO HEADER DE LOTE
  strLinha := strLinha + 'C';                                     // 009/009 - TIPO DA OPERAÇÃO (REM/RET)
  strLinha := strLinha + '06';                                    // 010/011 - TIPO DO SERVIÇO (CAPTURA DE CHQ)
  strLinha := strLinha + '01';                                    // 012/013 - FORMA DE LANÇAMENTO
  strLinha := strLinha + '030';                                   // 014/016 - NRO VERSÃO DO LAYOUT DO LOTE
  strLinha := strLinha + ' ';                                     // 017/017 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + '2';                                     // 018/018 - TIPO DE INSCRIÇÃO (CPF/CGC)
  strLinha := strLinha + fPadR(FCGCEmp, 14);                      // 019/032 - NRO INSCRIÇÃO DA EMPRESA
  strLinha := strLinha + fPadL(' ', 20);                          // 033/052 - COD DE CONVENIO NO BANCO (NÃO USADO NO ITAU SEMPRE BRANCOS)
  strLinha := strLinha + fPadL('0', 1);                           // 053/053 - COMPLEMENTO DE REGISTRO = ZERO
  strLinha := strLinha + fPadL(fCfgSis('ITAGMC'), 4, '0');        // 054/057 - AGENCIA MANTENEDORA DA CONTA
  strLinha := strLinha + fPadR(' ', 1);                           // 058/058 - COMPLEMENTO DE REGISTRO
  strLinha := strLinha + fPadR('0', 7, '0');                      // 059/065 - COMPLEMENTO DE REGISTRO
  strLinha := strLinha + fPadL(fCfgSis('ITNRCC'), 5, '0');        // 066/070 - NUMERO DA CONTA CORRENTE
  strLinha := strLinha + fPadL(' ', 1);                           // 071/071 - COMPLEMENTO DE REGISTRO
  strLinha := strLinha + fPadR(fCfgSis('ITDVAC'), 1);             // 072/072 - DIGITO VERIF DA AG/CONTA
  strLinha := strLinha + fPadR(fTiraCaracEspeciais(FNomEmp), 30); // 073/102 - NOME DA EMPRESA
  strLinha := strLinha + fPadR(' ', 07);                          // 103/109 - BRANCOS
  strLinha := strLinha + fPadR(' ', 05);                          // 110/114 - BRANCOS
  strLinha := strLinha + fPadR(' ', 125);                         // 115/239 - BRANCOS
  strLinha := strLinha + fPadR('2', 01);                          // 240/240 - TIPO DE DEPÓSITO

  Writeln(txtArq, strLinha);

end;

procedure TRemChq341.pGeraDetalhe(qryCheque: TDataSet);
var
  strLinha: String;
begin
  {*****************************************}
  {* DETALHE - REGISTRO = 3                *}
  {**************************************JU*}
  FContRg := 0;

  With qryCheque Do
  Begin
    First;

    While Not Eof Do
    Begin

      If FieldByName('CHQ_MARDES').AsString = 'M' Then
      Begin

        {*****************************************}
        {* DETALHE - REGISTRO = 3 SEGMENTO "N"   *}
        {**************************************JU*}
        Inc(FContRg);

        strLinha := LayItau;                                                                              // 001/003 - COD BANCO COMPENSAÇÃO
        strLinha := strLinha + '0001';                                                                      // 004/007 - LOTE DE SERVIÇO
        strLinha := strLinha + '3';                                                                         // 008/008 - REGISTRO DETALHE DE LOTE
        strLinha := strLinha + fStrZero(FContRg, 5);                                                        // 009/013 - SEQUENCIAL DO REGISTRO NO LOTE
        strLinha := strLinha + 'D';                                                                         // 014/014 - COD DE SEGMENTO DO REG DETALHE
        strLinha := strLinha + '000';                                                                       // 015/017 - COD INSTRUÇÃO POR MOVIMENTO
        strLinha := strLinha + '2';                                                                         // 018/018 - TIPO DE INSCRIÇÃO (CPF/CGC)
        strLinha := strLinha + fPadR(FCGCEmp, 14);                                                          // 019/032 - NRO INSCRIÇÃO DA EMPRESA
        strLinha := strLinha + fPadL(' ', 20);                                                              // 033/052 - COD DE CONVENIO NO BANCO (NÃO USADO NO ITAU SEMPRE BRANCOS)
        strLinha := strLinha + fPadL('0', 1);                                                               // 053/053 - COMPLEMENTO DE REGISTRO = ZERO
        strLinha := strLinha + fPadL(fCfgSis('ITAGMC'), 4, '0');                                            // 054/057 - AGENCIA MANTENEDORA DA CONTA
        strLinha := strLinha + fPadR(' ', 1);                                                               // 058/058 - COMPLEMENTO DE REGISTRO
        strLinha := strLinha + fPadR('0', 7, '0');                                                          // 059/065 - COMPLEMENTO DE REGISTRO
        strLinha := strLinha + fPadL(fCfgSis('ITNRCC'), 5, '0');                                            // 066/070 - NUMERO DA CONTA CORRENTE
        strLinha := strLinha + fPadL(' ', 1);                                                               // 071/071 - COMPLEMENTO DE REGISTRO
        strLinha := strLinha + fPadR(fCfgSis('ITDVAC'), 1);                                                 // 072/072 - DIGITO VERIF DA AG/CONTA
        strLinha := strLinha + fPadR(fTiraCaracEspeciais(FieldByName('CHQ_NOMEMI').AsString), 30);          // 073/102 - NOME DO EMIENTE
        strLinha := strLinha + fPadR(IIF(FieldByName('CHQ_CGCCPF').AsString = '1', '2', '1'), 1);           // 103/103 - TIPO DE INSCRIÇÃO DO EMITENTE
        strLinha := strLinha + fPadL(FieldByName('CHQ_C_G_C_').AsString, 14, '0');                          // 104/117 - NÚMERO CNPJ/CPF
        strLinha := strLinha + fPadR(FormatDateTime('ddmmyyyy', FieldByName('CHQ_DTACAD').AsDateTime), 08); // 118/125 - DATA DO MOVIMENTO
        strLinha := strLinha + fPadR(FormatDateTime('ddmmyyyy', FieldByName('CHQ_DTAVEN').AsDateTime), 08); // 126/133 - DATA BOA PARA DEPÓSITO

        strLinha := strLinha + fPadL(fTiraCaracEspeciais(FieldByName('CHQ_CODCMC').AsString, True, True, True, True, True, True), 30, '0');     // 134/163 - CMC7

        strLinha := strLinha + fValNumForm(FieldByName('CHQ_VALCHQ').AsFloat, 18);                          // 164/181 - VALOR DO CHEQUE
        strLinha := strLinha + fPadL('0', 7, '0');                                                          // 182/188 - NÚMERO DO ENVELOPE/MALOTE
        strLinha := strLinha + fPadL(' ', 16);                                                              // 189/204 - USO EXCLUSIVO DO BANCO
        strLinha := strLinha + fPadR(Trim(FieldByName('AUTOINCREM').AsString), 24);                           // 205/228 - CHAVE ÚNICA BANCO + AGENCIA + CONTA + Nº CHEQUE + EMPRESA
        strLinha := strLinha + fPadR('000040', 06);                                                         // 229/234 - OCORRÊNCIA
        strLinha := strLinha + fPadR(' ', 05);                                                              // 235/239 - BRANCOS
        strLinha := strLinha + fPadR('2', 01);                                                              // 240/240 - FORMA DE ENTRADA DE DADOS

        Writeln(txtArq, strLinha);

        FContas.Add(FieldByName('CHQ_CONCOR').AsString);

      End;

      Next;
    End;

  End;
end;

procedure TRemChq341.pGeraTrailer;
var
  strLinha: String;
begin
  {*****************************************}
  {* TRAILER DO ARQUIVO - REGISTRO = 9     *}
  {**************************************JU*}

  strLinha := LayItau;                           // 001/003 - COD BANCO COMPENSAÇÃO
  strLinha := strLinha + '9999';                   // 004/007 - LOTE DE SERVIÇO
  strLinha := strLinha + '9';                      // 008/008 - REGISTRO HEADER DE LOTE
  strLinha := strLinha + fPadR('', 9);             // 009/017 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + '000001';                 // 018/023 - QTDE DE LOTES DO ARQUIVO
  strLinha := strLinha + fStrZero(FContRg + 2, 6); // 024/029 - QTDE DE REG DO ARQUIVO
  strLinha := strLinha + fValNumForm(FTotChq, 18); // 030/047 - SOMATORIO DO VALOR DOS CHEQUES
  strLinha := strLinha + fPadR(' ', 193);          // 048/240 - USO EXCLUSIVO FEBRABAN/CNAB

  Writeln(txtArq, strLinha);
end;

procedure TRemChq341.pGeraTraLote;
var
  strLinha: String;
begin
  {*****************************************}
  {* TRAILER DE LOTE - REGISTRO = 5        *}
  {**************************************JU*}

  strLinha := LayItau;                                   // 001/003 - COD BANCO COMPENSAÇÃO
  strLinha := strLinha + '0001';                           // 004/007 - LOTE DE SERVIÇO
  strLinha := strLinha + '5';                              // 008/008 - REGISTRO HEADER DE LOTE
  strLinha := strLinha + fPadR('', 9);                     // 009/017 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + '2';                              // 018/018 - TIPO DE INSCRIÇÃO (CPF/CGC)
  strLinha := strLinha + fPadR(FCGCEmp, 14);               // 019/032 - NRO INSCRIÇÃO DA EMPRESA
  strLinha := strLinha + fPadL(' ', 20);                   // 033/052 - COD DE CONVENIO NO BANCO (NÃO USADO NO ITAU SEMPRE BRANCOS)
  strLinha := strLinha + fPadL('0', 1);                    // 053/053 - COMPLEMENTO DE REGISTRO = ZERO
  strLinha := strLinha + fPadL(fCfgSis('ITAGMC'), 4, '0'); // 054/057 - AGENCIA MANTENEDORA DA CONTA
  strLinha := strLinha + fPadR(' ', 1);                    // 058/058 - COMPLEMENTO DE REGISTRO
  strLinha := strLinha + fPadR('0', 7, '0');               // 059/065 - COMPLEMENTO DE REGISTRO
  strLinha := strLinha + fPadL(fCfgSis('ITNRCC'), 5, '0'); // 066/070 - NUMERO DA CONTA CORRENTE
  strLinha := strLinha + fPadL(' ', 1);                    // 071/071 - COMPLEMENTO DE REGISTRO
  strLinha := strLinha + fPadR(fCfgSis('ITDVAC'), 1);      // 072/072 - DIGITO VERIF DA AG/CONTA
  strLinha := strLinha + fPadR(' ', 98);                   // 073/170 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + fStrZero(FQtdChq + 2, 6);         // 171/176 - SOMATORIO DA QTDE DOS CHQS
  strLinha := strLinha + fValNumForm(FTotChq, 18);         // 177/194 - SOMATORIO DO VALOR DOS CHQS
  strLinha := strLinha + fPadR('', 46);                    // 195/240 - BRANCOS

  Writeln(txtArq, strLinha);
end;

{ TRemChq001 }

function TRemChq001.fGetCodBan: String;
begin
  Result := Lay_BB;
end;

function TRemChq001.fPrefixCfg: String;
begin
  Result := 'BB';
end;

procedure TRemChq001.pGeraCabecalho;
var
  strLinha: String;
begin
  {*****************************************}
  {* HEADER DE ARQUIVO - REGISTRO = 0      *}
  {**************************************JU*}

  strLinha := Lay_BB;                                             //1.01 001/003 - COD BANCO COMPENSAÇÃO
  strLinha := strLinha + '0000';                                  //1.02 004/007 - LOTE DE SERVIÇO
  strLinha := strLinha + '0';                                     //1.03 008/008 - REGISTRO HEADER DE ARQUIVO
  strLinha := strLinha + '         ';                             //1.08 009/017 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + '2';                                     //1.09 018/018 - TIPO DE INSCRIÇÃO (CPF/CGC)
  strLinha := strLinha + fPadL(FCGCEmp,14,'0');                   //1.10 019/032 - NRO INSCRIÇÃO DA EMPRESA
  strLinha := strLinha + fPadL(fCfgSis('BBCONV'), 9, '0');        //1.11 033/041 - COD DE CONVENIO NO BANCO
  strLinha := strLinha + fPadR('', 11);                           //1.12 042/052 - USO RESERVADO DO BANCO
  strLinha := strLinha + fPadL(fCfgSis('BBAGMC'), 5, '0');        //1.13 053/057 - AGENCIA MANTENEDORA DA CONTA
  strLinha := strLinha + fPadR(fCfgSis('BBDVAG'), 1);             //1.14 058/058 - DIGITO VERIFICADOR DA AGENCIA
  strLinha := strLinha + fPadL(fCfgSis('BBNRCC'), 12, '0');       //1.15 059/070 - NUMERO DA CONTA CORRENTE
  strLinha := strLinha + fPadR(fCfgSis('BBDVCC'), 1);             //1.16 071/071 - DIGITO VERIFICADOR DA CONTA
  strLinha := strLinha + fPadR(fCfgSis('BBDVAC'), 1);             //1.17 072/072 - DIGITO VERIF DA AG/CONTA
  strLinha := strLinha + fPadR(fTiraCaracEspeciais(FNomEmp), 30); //1.18 073/102 - NOME DA EMPRESA
  strLinha := strLinha + fPadR(fRetNomBanco(Lay_BB), 30);         //1.19 103/132 - NOME DO BANCO
  strLinha := strLinha + fPadR('', 10);                           //1.20 133/142 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + '1';                                     //1.21 143/143 - IDENTIFICADOR DO TIPO DE ARQ
  strLinha := strLinha + FormatDateTime('DDMMYYYY', VS_Date);     //1.22 144/151 - DATA GERAÇÃO DO ARQUIVO
  strLinha := strLinha + FormatDateTime('HHMMSS', fTime());       //1.23 152/157 - HORA GERAÇÃO DO ARQUIVO
  strLinha := strLinha + fStrZero(intSeq, 6);                     //1.24 158/163 - NRO SEQUENCIAL DO ARQUIVO
  strLinha := strLinha + '030';                                   //1.25 164/166 - NRO DA VERSÃO DO LAYOUT
  strLinha := strLinha + '00000';                                 //1.26 167/171 - DENSIDADE GRAVAÇÃO DO ARQ. (BPI)
  strLinha := strLinha + fPadR('', 20);                           //1.27 172/191 - USO RESERVADO DO BANCO
  strLinha := strLinha + fPadR('', 20);                           //1.28 192/211 - USO RESERVADO DA EMPRESA
  strLinha := strLinha + fPadR('', 19);                           //1.29 212/230 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + '  ';                                    //1.30 231/232 - CODIGO DO RETORNO
  strLinha := strLinha + '        ';                              //     233/240 - CODIGO OCORRENCIAS P/ RETORNO

  Writeln(txtArq, strLinha);

end;

procedure TRemChq001.pGeraCabLote;
var
  strLinha: String;
begin

  {*****************************************}
  {* HEADER DE LOTE - REGISTRO = 1         *}
  {**************************************JU*}

  strLinha := Lay_BB;                                             //1.01 001/003 - COD BANCO COMPENSAÇÃO
  strLinha := strLinha + '0001';                                  //1.02 004/007 - LOTE DE SERVIÇO
  strLinha := strLinha + '1';                                     //1.03 008/008 - REGISTRO HEADER DE LOTE
  strLinha := strLinha + 'R';                                     //1.04 009/009 - TIPO DA OPERAÇÃO (REM/RET)
  strLinha := strLinha + '07';                                    //1.05 010/011 - TIPO DO SERVIÇO (CAPTURA DE CHQ)
  strLinha := strLinha + '01';                                    //1.06 012/013 - FORMA DE LANÇAMENTO
  strLinha := strLinha + '020';                                   //1.07 014/016 - NRO VERSÃO DO LAYOUT DO LOTE
  strLinha := strLinha + ' ';                                     //1.08 017/017 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + '2';                                     //1.09 018/018 - TIPO DE INSCRIÇÃO (CPF/CGC)
  strLinha := strLinha + fPadR(FCGCEmp, 14);                      //1.10 019/032 - NRO INSCRIÇÃO DA EMPRESA
  strLinha := strLinha + fPadL(fCfgSis('BBCONV'), 9, '0');        //1.11 033/041 - COD DE CONVENIO NO BANCO
  strLinha := strLinha + fPadR('', 11);                           //1.12 042/052 - USO RESERVADO DO BANCO
  strLinha := strLinha + fPadL(fCfgSis('BBAGRC'), 5, '0');        //1.13 053/057 - PREF. AGENCIA DE ENTREGA DO CHQ
  strLinha := strLinha + fPadR(fCfgSis('BBDVAR'), 1);             //1.14 058/058 - DV PREF. AGENCIA DE ENTREGA
  strLinha := strLinha + fStrZero(intSeq, 6);                     //1.15 059/064 - NUMERO DA REMESSA
  strLinha := strLinha + fPadL(fCfgSis('BBAGMC'), 5, '0');        //1.16 065/069 - AGENCIA MANTENEDORA DA CONTA
  strLinha := strLinha + fPadR(fCfgSis('BBDVAG'), 1);             //1.17 070/070 - DIGITO VERIFICADOR DA AGENCIA
  strLinha := strLinha + fPadL(fCfgSis('BBNRCC'), 12, '0');       //1.18 071/082 - NUMERO DA CONTA CORRENTE
  strLinha := strLinha + fPadR(fCfgSis('BBDVCC'), 1);             //1.19 083/083 - DIGITO VERIFICADOR DA CONTA
  strLinha := strLinha + fPadR(fCfgSis('BBDVAC'), 1);             //1.20 084/084 - DIGITO VERIF DA AG/CONTA
  strLinha := strLinha + fPadR(fTiraCaracEspeciais(FNomEmp), 30); //1.21 085/114 - NOME DA EMPRESA
  strLinha := strLinha + FormatDateTime('DDMMYYYY', VS_Date);     //1.22 115/122 - DATA DA REMESSA DO ARQUIVO
  strLinha := strLinha + fPadR('', 06);                           //1.23 123/128 - NUMERO REMESSA ORIGEM
  strLinha := strLinha + fPadR('', 10);                           //1.24 129/138 - USO LIVRE PARA O CLIENTE
  strLinha := strLinha + fPadR('', 04);                           //1.25 139/142 - MENSAGEM
  strLinha := strLinha + fPadR(fTiraCaracEspeciais(FEndere), 30); //1.26 143/172 - LOGRADOURO
  strLinha := strLinha + fPadL(FEndNum, 5,'0');                   //1.27 173/177 - NUMERO DO LOCAL
  strLinha := strLinha + fPadR(FEndCmp, 15);                      //1.28 178/192 - COMPLEMENTO
  strLinha := strLinha + fPadR(fTiraCaracEspeciais(FNomCid), 20); //1.29 193/212 - NOME DA CIDADE
  strLinha := strLinha + LeftStr(FCEPEmp, 5);                     //1.30 213/217 - CEP
  strLinha := strLinha + RightStr(FCEPEmp,3);                     //1.31 218/220 - COMPL DO CEP
  strLinha := strLinha + fPadR(FEstado, 02);                      //1.32 221/222 - SIGLA DO ESTADO
  strLinha := strLinha + fPadR('', 8);                            //1.33 223/230 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + '  ';                                    //1.34 231/232 - CODIGO DO RETORNO
  strLinha := strLinha + '        ';                              //     233/240 - CODIGO OCORRENCIAS P/ RETORNO

  Writeln(txtArq, strLinha);

end;

procedure TRemChq001.pGeraDetalhe(qryCheque: TDataSet);
var
  strLinha: String;
begin
  {*****************************************}
  {* DETALHE - REGISTRO = 3                *}
  {**************************************JU*}
  FContRg := 0;

  With qryCheque Do
  Begin
    First;

    While Not Eof Do
    Begin

      If FieldByName('CHQ_MARDES').AsString = 'M' Then
      Begin

        {*****************************************}
        {* DETALHE - REGISTRO = 3 SEGMENTO "N"   *}
        {**************************************JU*}
        Inc(FContRg);

        strLinha := Lay_BB;                                                                                                             //3.01 001/003 - COD BANCO COMPENSAÇÃO
        strLinha := strLinha + '0001';                                                                                                    //3.02 004/007 - LOTE DE SERVIÇO
        strLinha := strLinha + '3';                                                                                                       //3.03 008/008 - REGISTRO DETALHE DE LOTE
        strLinha := strLinha + fStrZero(FContRg, 5);                                                                                      //3.04 009/013 - SEQUENCIAL DO REGISTRO NO LOTE
        strLinha := strLinha + 'N';                                                                                                       //3.05 014/014 - COD DE SEGMENTO DO REG DETALHE
        strLinha := strLinha + '0';                                                                                                       //3.06 015/015 - TIPO DE MOVIMENTO
        strLinha := strLinha + '02';                                                                                                      //3.07 016/017 - COD INSTRUÇÃO POR MOVIMENTO

        strLinha := strLinha + fPadR(IIF(LeftStr(FieldByName('CHQ_CODCMC').AsString,1) = '<',
                             FieldByName('CHQ_CODCMC').AsString,
                             FormatMaskText('\<aaaaaaaa\<aaaaaaaaaa\>aaaaaaaaaaaa\:;0;_',FieldByName('CHQ_CODCMC').AsString)), 34); //3.08 018/051 - DADOS DO CMC7

        strLinha := strLinha + fPadR(FieldByName('CHQ_C_G_C_').AsString, 14);                                                             //3.09 052/065 - CGC/CPF EMITENTE
        strLinha := strLinha + fValNumForm(FieldByName('CHQ_VALCHQ').AsFloat, 15);                                                        //3.10 066/080 - VALOR DO CHEQUE
        strLinha := strLinha + fPadR(FormatDateTime('DDMMYYYY', FieldByName('CHQ_DTAVEN').AsDateTime), 08);                               //3.11 081/088 - DATA "BOM PARA"
        strLinha := strLinha + fPadR(FieldByName('CHQ_NUMAGE').AsString, 10);                                                             //3.12 089/098 - USO LIVRE PARA O CLIENTE
        strLinha := strLinha + fPadR('', 10);                                                                                             //3.13 099/108 - USO EXCLUSIVO DO BANCO
        strLinha := strLinha + '000';                                                                                                     //3.14 109/111 - COD COMPENSAÇÃO DO ACOLHIMENTO
        strLinha := strLinha + '001';                                                                                                     //3.15 112/114 - BANCO REMETENTE
        strLinha := strLinha + fPadL(fCfgSis('BBAGRC'), 5, '0');                                                                          //3.16 115/119 - PREF. AG ENTREGA S/ DV
        strLinha := strLinha + fPadL(fCfgSis('BBAGMC'), 5, '0');                                                                          //3.17 120/124 - PREF. AG DA C/C S/ DV
        strLinha := strLinha + fPadL(fCfgSis('BBNRCC'), 12, '0');                                                                         //3.18 125/136 - NRO CONTA DEPOSITANTE S/ DV
        strLinha := strLinha + fPadR('', 15);                                                                                             //3.19 137/151 - JUROS SOBRE DESCONTO
        strLinha := strLinha + fPadR('', 15);                                                                                             //3.20 152/166 - IOF SOBRE DESCONTO
        strLinha := strLinha + fPadR('', 15);                                                                                             //3.21 167/181 - OUTROS ENCARGOS S. DESCONTO
        strLinha := strLinha + fPadR('', 49);                                                                                             //3.22 182/230 - USO EXCLUSIVO FEBRABAN/CNAB
        strLinha := strLinha + '  ';                                                                                                      //3.24 231/232 - CODIGO DO RETORNO
        strLinha := strLinha + '        ';                                                                                                //     233/240 - CODIGO OCORRENCIAS P/ RETORNO
        Writeln(txtArq, strLinha);

        FContas.Add(FieldByName('CHQ_CONCOR').AsString);

      End;

      Next;
    End;

  End;
end;

procedure TRemChq001.pGeraTrailer;
var
  strLinha: String;
begin
  {*****************************************}
  {* TRAILER DO ARQUIVO - REGISTRO = 9     *}
  {**************************************JU*}

  strLinha := Lay_BB;                              //5.01 001/003 - COD BANCO COMPENSAÇÃO
  strLinha := strLinha + '9999';                     //5.02 004/007 - LOTE DE SERVIÇO
  strLinha := strLinha + '9';                        //5.03 008/008 - REGISTRO HEADER DE LOTE
  strLinha := strLinha + fPadR('', 9);               //5.04 009/017 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + '000001';                   //5.05 018/023 - QTDE DE LOTES DO ARQUIVO
  strLinha := strLinha + fStrZero(FContRg + 4, 6);   //5.06 024/029 - QTDE DE REG DO ARQUIVO
  strLinha := strLinha + fStrZero(FContas.Count, 6); //5.07 030/035 - QTDE DE CONTAS DO ARQUIVO
  strLinha := strLinha + fPadR('', 205);             //5.08 036/240 - USO EXCLUSIVO FEBRABAN/CNAB

  Writeln(txtArq, strLinha);
end;

procedure TRemChq001.pGeraTraLote;
var
  strLinha: String;
begin
  {*****************************************}
  {* TRAILER DE LOTE - REGISTRO = 5        *}
  {**************************************JU*}

  strLinha := Lay_BB;                            //5.01 001/003 - COD BANCO COMPENSAÇÃO
  strLinha := strLinha + '0001';                   //5.02 004/007 - LOTE DE SERVIÇO
  strLinha := strLinha + '5';                      //5.03 008/008 - REGISTRO HEADER DE LOTE
  strLinha := strLinha + fPadR('', 9);             //5.04 009/017 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + fStrZero(FContRg + 2, 6); //5.05 018/023 - QTDE DE REG DO LOTE
  strLinha := strLinha + fValNumForm(FTotChq, 18); //5.06 024/041 - SOMATORIO DO VALOR DOS CHQS
  strLinha := strLinha + fStrZero(FQtdChq, 6);     //5.07 042/047 - SOMATORIO DA QTDE DOS CHQS
  strLinha := strLinha + fPadR('', 52);            //5.08 048/099 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + fPadR('', 18);            //5.09 100/117 - TOTAL JUROS SOBRE DESCONTO
  strLinha := strLinha + fPadR('', 18);            //5.10 118/135 - TOTAL IOF SOBRE DESCONTOS
  strLinha := strLinha + fPadR('', 18);            //5.11 136/153 - TOTAL OUTROS ENCARGOS S. DESCONTO
  strLinha := strLinha + fPadR('', 06);            //5.12 154/159 - QTDE DE CHHQS PROCESSADOS
  strLinha := strLinha + fPadR('', 18);            //5.13 160/177 - VALOR DOS CHQS PROCESSADOS
  strLinha := strLinha + fPadR('', 63);            //5.14 178/240 - USO EXCLUSIVO FEBRABAN/CNAB

  Writeln(txtArq, strLinha);
end;

{ TRemChq033 }

function TRemChq033.fGetCodBan: String;
begin
  Result := LaySantander;
end;

function TRemChq033.fPrefixCfg: String;
begin
  Result := 'ST';
end;

function TRemChq033.fValidaCfg: Boolean;
begin
  Result := inherited fValidaCfg();
  If Not Result Then
    Exit;

  If fEmptyStr(fCfgSis('STCONV')) Then
  Begin
    fMensagem('', 'É necessário informar o código do convênio' + #13#10 + 'nas Configurações do Sistema.', ['&Ok']);
    Result := False;
    Exit;
  End;

  If fEmptyStr(fCfgSis('STAGMC')) Then
  Begin
    fMensagem('', 'É necessário informar o número da agência mantenedora da conta' + #13#10 + 'nas Configurações do Sistema.', ['&Ok']);
    Result := False;
    Exit;
  End;

  If fEmptyStr(fCfgSis('STNRCC')) Then
  Begin
    fMensagem('', 'É necessário informar o número da conta corrente' + #13#10 + 'nas Configurações do Sistema.', ['&Ok']);
    Result := False;
    Exit;
  End;

  If fEmptyStr(fCfgSis('STDVCC')) Then
  Begin
    fMensagem('', 'É necessário informar o dígito verificador do número da conta' + #13#10 + 'nas Configurações do Sistema.', ['&Ok']);
    Result := False;
    Exit;
  End;
end;

procedure TRemChq033.pGeraCabecalho;
var
  strLinha: String;
begin
  {*****************************************}
  {* HEADER DE ARQUIVO - REGISTRO = 0      *}
  {**************************************RS*}

  strLinha := LaySantander;                                       // 001/003 - COD BANCO COMPENSAÇÃO
  strLinha := strLinha + '0000';                                  // 004/007 - LOTE DE SERVIÇO
  strLinha := strLinha + '0';                                     // 008/008 - REGISTRO HEADER DE ARQUIVO
  strLinha := strLinha + '         ';                             // 009/017 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + '2';                                     // 018/018 - TIPO DE INSCRIÇÃO (CPF/CGC)
  strLinha := strLinha + fPadL(FCGCEmp, 14, '0');                 // 019/032 - NRO INSCRIÇÃO DA EMPRESA
  strLinha := strLinha + fPadL(fCfgSis('STCONV'), 9, '0');        // 033/041 - COD DE CONVENIO NO BANCO
  strLinha := strLinha + fPadL(' ', 11, ' ');                     // 042/052 - RESERVADO (USO BANCO)
  strLinha := strLinha + fPadL(fCfgSis('STAGMC'), 5, '0');        // 053/057 - AGENCIA MANTENEDORA DA CONTA
  strLinha := strLinha + fPadR(' ', 1);                           // 058/058 - DIGITO VERIFICADOR DA AGNCIA
  strLinha := strLinha + fPadL(fCfgSis('STNRCC'), 12, '0');       // 059/070 - NUMERO DA CONTA CORRENTE
  strLinha := strLinha + fPadL(fCfgSis('STDVCC'), 1);             // 071/071 - DÍGITO VERIFICADOR DA CONTA
  strLinha := strLinha + ' ';                                     // 072/072 - DIGITO VERIF DA AG/CONTA
  strLinha := strLinha + fPadR(fTiraCaracEspeciais(FNomEmp), 30); // 073/102 - NOME DA EMPRESA
  strLinha := strLinha + fPadR('BANCO SANTANDER', 30);            // 103/132 - NOME DO BANCO
  strLinha := strLinha + fPadR(' ', 10);                          // 133/142 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + '1';                                     // 143/143 - IDENTIFICADOR DO TIPO DE ARQ
  strLinha := strLinha + FormatDateTime('DDMMYYYY', VS_Date);     // 144/151 - DATA GERAÇÃO DO ARQUIVO
  strLinha := strLinha + FormatDateTime('HHMMSS', fTime());       // 152/157 - HORA GERAÇÃO DO ARQUIVO
  strLinha := strLinha + fStrZero(intSeq, 6);                     // 158/163 - NRO SEQUENCIAL DO ARQUIVO
  strLinha := strLinha + '082';                                   // 164/166 - NRO DA VERSÃO DO LAYOUT
  strLinha := strLinha + '     ';                                 // 167/171 - COMPLEMENTO DE REGISTRO
  strLinha := strLinha + fPadR(' ', 69);                          // 172/240 - BRANCOS

  Writeln(txtArq, strLinha);

end;

procedure TRemChq033.pGeraCabLote;
var
  strLinha: String;
begin

  {*****************************************}
  {* HEADER DE LOTE - REGISTRO = 1         *}
  {**************************************RS*}

  strLinha := LaySantander;                                       // 001/003 - COD BANCO COMPENSAÇÃO
  strLinha := strLinha + '0001';                                  // 004/007 - LOTE DE SERVIÇO
  strLinha := strLinha + '1';                                     // 008/008 - REGISTRO HEADER DE LOTE
  strLinha := strLinha + 'R';                                     // 009/009 - TIPO DA OPERAÇÃO (REM/RET)
  strLinha := strLinha + '06';                                    // 010/011 - TIPO DO SERVIÇO (CAPTURA DE CHQ)
  strLinha := strLinha + '  ';                                    // 012/013 - RESERVADO (USO BANCO)
  strLinha := strLinha + '010';                                   // 014/016 - NRO VERSÃO DO LAYOUT DO LOTE
  strLinha := strLinha + ' ';                                     // 017/017 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + '2';                                     // 018/018 - TIPO DE INSCRIÇÃO (CPF/CGC)
  strLinha := strLinha + fPadR(FCGCEmp, 14, '0');                 // 019/032 - NRO INSCRIÇÃO DA EMPRESA
  strLinha := strLinha + fPadL(fCfgSis('STCONV'), 9, '0');        // 033/041 - COD DE CONVENIO NO BANCO
  strLinha := strLinha + fPadR(' ', 11);                          // 042/052 - BRANCOS
  strLinha := strLinha + fPadL(fCfgSis('STAGMC'), 5, '0');        // 053/057 - AGENCIA MANTENEDORA DA CONTA
  strLinha := strLinha + fPadR(' ', 1);                           // 058/058 - DV AGENCIA
  strLinha := strLinha + fPadL(fCfgSis('STNRCC'), 12, '0');       // 059/070 - NUMERO DA CONTA CORRENTE
  strLinha := strLinha + fPadR(fCfgSis('STDVCC'), 1);             // 071/071 - DIGITO VERIF DA CONTA
  strLinha := strLinha + ' ';                                     // 072/072 - DIGITO VERIF DA AG/CONTA
  strLinha := strLinha + fPadR(fTiraCaracEspeciais(FNomEmp), 30); // 073/102 - NOME DA EMPRESA
  strLinha := strLinha + fPadR(' ', 26);                          // 103/128 - BRANCOS
  strLinha := strLinha + fPadR(' ', 14);                          // 129/142 - BRANCOS
  strLinha := strLinha + fPadR(' ', 98);                          // 143/240 - BRANCOS

  Writeln(txtArq, strLinha);

end;

procedure TRemChq033.pGeraDetalhe(qryCheque: TDataSet);
var
  strLinha: String;
begin
  {*****************************************}
  {* DETALHE - REGISTRO = 3                *}
  {**************************************RS*}
  FContRg := 0;

  With qryCheque Do
  Begin
    First;

    While Not Eof Do
    Begin

      If FieldByName('CHQ_MARDES').AsString = 'M' Then
      Begin

        {*****************************************}
        {* DETALHE - REGISTRO = 3 SEGMENTO "N"   *}
        {**************************************RS*}
        Inc(FContRg);

        strLinha := LaySantander;                                                                           // 001/003 - COD BANCO COMPENSAÇÃO
        strLinha := strLinha + '0001';                                                                      // 004/007 - LOTE DE SERVIÇO
        strLinha := strLinha + '3';                                                                         // 008/008 - REGISTRO DETALHE DE LOTE
        strLinha := strLinha + fStrZero(FContRg, 5);                                                        // 009/013 - SEQUENCIAL DO REGISTRO NO LOTE
        strLinha := strLinha + 'D';                                                                         // 014/014 - COD DE SEGMENTO DO REG DETALHE
        strLinha := strLinha + ' ';                                                                         // 015/015 - RESERVADO (USO BANCO)
        strLinha := strLinha + '01';                                                                        // 016/017 - COD INSTRUÇÃO POR MOVIMENTO
        strLinha := strLinha + '01';                                                                        // 018/019 - CÓDIGO DA FINALIDADE
        strLinha := strLinha + '1';                                                                         // 020/020 - FORMA DE ENTRADA

        strLinha := strLinha + fPadR(FormatMaskText(' 00000000 0000000000 000000000000 ;0; ',
                                     fTiraCaracEspeciais(FieldByName('CHQ_CODCMC').AsString)), 34);         // 021/054 - DADOS DO CMC7

        strLinha := strLinha + fPadR(IIF(FieldByName('CHQ_CGCCPF').AsString = '1', '2', '1'), 1);           // 055/055 - TIPO DE INSCRIÇÃO DO EMITENTE
        strLinha := strLinha + fPadL(FieldByName('CHQ_C_G_C_').AsString, 14, '0');                          // 056/069 - NÚMERO CNPJ/CPF
        strLinha := strLinha + fValNumForm(FieldByName('CHQ_VALCHQ').AsFloat, 15);                          // 070/084 - VALOR DO CHEQUE
        strLinha := strLinha + fPadR(FormatDateTime('ddmmyyyy', FieldByName('CHQ_DTACAD').AsDateTime), 08); // 085/092 - DATA DA CAPTURA DO CHEQUE NO CLIENTE
        strLinha := strLinha + fPadR(FormatDateTime('ddmmyyyy', FieldByName('CHQ_DTAVEN').AsDateTime), 08); // 093/100 - DATA PARA DEPÓSITO
        strLinha := strLinha + '00000000';                                                                  // 101/108 - DATA PARA CRÉDITO
        strLinha := strLinha + fPadR(Trim(FieldByName('AUTOINCREM').AsString), 20);                         // 109/128 - CHAVE ÚNICA BANCO + AGENCIA + CONTA + Nº CHEQUE + EMPRESA
        strLinha := strLinha + fPadR(' ', 14);                                                              // 129/142 - RESERVADO (USO BANCO)
        strLinha := strLinha + ' ';                                                                         // 143/143 - RESERVADO (USO BANCO)
        strLinha := strLinha + fPadR('0', 5, '0');                                                          // 144/148 - AGENCIA PARA DEVOLUÇÃO
        strLinha := strLinha + fPadR('0', 12, '0');                                                         // 149/160 - CONTA PARA DEVOLUÇÃO
        strLinha := strLinha + fPadR('0', 57, '0');                                                         // 161/217 - COMPLEMENTO DE REGISTRO
        strLinha := strLinha + fPadL(' ', 23);                                                              // 218/240 - COMPLEMENTO DE REGISTRO

        Writeln(txtArq, strLinha);

        FContas.Add(FieldByName('CHQ_CONCOR').AsString);

      End;

      Next;
    End;

  End;
end;

procedure TRemChq033.pGeraTrailer;
var
  strLinha: String;
begin
  {*****************************************}
  {* TRAILER DO ARQUIVO - REGISTRO = 9     *}
  {**************************************RS*}

  strLinha := LaySantander;                        // 001/003 - COD BANCO COMPENSAÇÃO
  strLinha := strLinha + '9999';                   // 004/007 - LOTE DE SERVIÇO
  strLinha := strLinha + '9';                      // 008/008 - REGISTRO HEADER DE LOTE
  strLinha := strLinha + fPadR('', 9);             // 009/017 - USO EXCLUSIVO FEBRABAN/CNAB
  strLinha := strLinha + '000001';                 // 018/023 - QTDE DE LOTES DO ARQUIVO
  strLinha := strLinha + fStrZero(FContRg + 2, 6); // 024/029 - QTDE DE REG DO ARQUIVO
  strLinha := strLinha + '000000';                 // 030/035 - ZEROS
  strLinha := strLinha + fPadR(' ', 205);          // 036/240 - BRANCOS

  Writeln(txtArq, strLinha);
end;

procedure TRemChq033.pGeraTraLote;
var
  strLinha: String;
begin
  {*****************************************}
  {* TRAILER DE LOTE - REGISTRO = 5        *}
  {**************************************RS*}

  strLinha := LaySantander;                                // 001/003 - COD BANCO COMPENSAÇÃO
  strLinha := strLinha + '0001';                           // 004/007 - LOTE DE SERVIÇO
  strLinha := strLinha + '5';                              // 008/008 - REGISTRO HEADER DE LOTE
  strLinha := strLinha + fPadR('', 9);                     // 009/017 - BRANCOS
  strLinha := strLinha + fStrZero(FQtdChq + 2, 6);         // 018/023 - QUANTIDADE DE REGISTROS
  strLinha := strLinha + fValNumForm(FTotChq, 18);         // 024/041 - SOMATORIO DO VALOR DOS CHQS
  strLinha := strLinha + fStrZero(FQtdChq, 6);             // 042/047 - QUANTIDADE DE CHEQUES
  strLinha := strLinha + fPadR('0', 48, '0');              // 048/095 - ZEROS
  strLinha := strLinha + fPadR('', 145);                   // 096/240 - BRANCOS

  Writeln(txtArq, strLinha);
end;

{ TRemChq041 }

function TRemChq041.fGetCodBan: String;
begin
  Result := LayBanrisul;
end;

function TRemChq041.fIncrementaChar(chrValor: Char): Char;
begin
  if chrValor = '9' then
  begin
    Result := 'A';
  end
  else
  if chrValor = 'Z' then
  begin
    Result := '1';
  end
  else
  begin
    Result := Chr(Succ(Ord(chrValor)));
  end;
end;

function TRemChq041.fIncrementaString(strValor: String): String;
var
  i: word;
begin
  Result := strValor;

  For i := Length(strValor) downto 1 do
  begin
    Result[i] := fIncrementaChar(strValor[i]);
  end;
end;

function TRemChq041.fNomeArq: String;
begin
  Result := fCfgSis('BSPATH') + '\CUSTODIA_BANRISUL';

  If Not DirectoryExists(Result) Then
  begin
    ForceDirectories(Result);
  end;

  If Not DirectoryExists(Result + '\'+ FormatDateTime('dd_mm_yyyy', VS_Date)) Then
  begin
    ForceDirectories(Result + '\'+ FormatDateTime('dd_mm_yyyy', VS_Date));
    fAtuCfgSis('BSNREM', '1');
    fAtuCfgSis('BSNRAR', '1');
  end;

  strSeq := fCfgSisL('BSNRAR', varString);  //Qtd para controla o nome do arquivo 1-9/A-Z

  Result := Result + '\'+ FormatDateTime('dd_mm_yyyy', VS_Date);
  Result := Result + '\' + 'BIUVCM' + strSeq + '.MOV';
end;

function TRemChq041.fPrefixCfg: String;
begin
  Result := 'BS';
end;

function TRemChq041.fValidaCfg: Boolean;
begin
  Result := inherited fValidaCfg();
  If Not Result Then
    Exit;

  If fEmptyStr(fCfgSis('BSAGDP')) or
     fEmptyStr(fCfgSis('BSAGAP')) or
     fEmptyStr(fCfgSis('BSCCDP')) or
     fEmptyStr(fCfgSis('BSCEMP')) Then
  Begin
    fMensagem('', 'Existem configurações em branco para exportação do arquivo de remessa do Banco Branrisul. ' +
                  'Informá-las na opção "Custódia de Cheques" nas Configurações do Sistema.', ['&Ok']);

    Result := False;
    Exit;
  End;
end;

procedure TRemChq041.pFinalizaExportacao;
begin
  strSeq := fIncrementaString(strSeq);
  fAtuCfgSis('BSNRAR', strSeq);
end;

procedure TRemChq041.pGeraCabecalho;
var
  strLinha: String;
begin
  {**********}
  {* HEADER *}
  {*******MO*}
  strLinha := 'H';                                                             // H01-001/001 - TIPO DE REGISTRO
  strLinha := strLinha + fPadR(fCfgSis('BSAGDP'), 04);                         // H02-002/005 - AGÊNCIA DO DEPOSITANTE
  strLinha := strLinha + fPadR(fCfgSis('BSCCDP'), 10);                         // H03-006/015 - CONTA DO DEPOSITANTE
  strLinha := strLinha + fPadR(fTiraCaracEspeciais(FNomEmp), 25);              // H04-016/040 - NOME DA EMPRESA DEPOSITANTE
  strLinha := strLinha + '041';                                                // H05-041/043 - NÚMERO DO BANCO APRESENTANTE
  strLinha := strLinha + '8';                                                  // H06-044/044 - DV DO NÚMERO DO BANCO
  strLinha := strLinha + fPadL(IntToStr(intIndInterface), 1);                  // H07-045/045 - INDICADOR DE INTERFACE
  strLinha := strLinha + FormatDateTime('YYYYMMDD', FDtaCus);                  // H08-046/053 - DATA DO MOVIMENTO
  strLinha := strLinha + FormatDateTime('YYYYMMDD', VS_Date);                  // H09-054/061 - DATA DA CRIAÇÃO DO ARQUIVO
  strLinha := strLinha + FormatDateTime('HHMM', fTime());                      // H10-062/065 - HORA E MINUTO DA CRIAÇÃO DO ARQUIVO
  strLinha := strLinha + fPadL(IntToStr(intSeq), 4, '0');                      // H11-066/069 - SEQUÊNCIA DA REMESSA
  strLinha := strLinha + fPadR('', 02);                                        // H12-070/071 - CÓDIGO DE DEVOLUÇÃO
  strLinha := strLinha + fPadR('', 01);                                        // H13-072/072 - FILLER
  strLinha := strLinha + fPadR(fCfgSis('BSCEMP'), 4);                          // H14-073/076 - CÓDIGO DA EMPRESA
  strLinha := strLinha + '01';                                                 // H15-077/078 - CONVÊNIO(FIXO 01 FORNECIDO NO MANUAL)
  strLinha := strLinha + '00' + fPadR(fCfgSis('BSCEMP'), 4);                   // H16-079/084 - CÓDIGO DO ARQUIVO
  strLinha := strLinha + fPadR(fCfgSis('BSAGAP'), 04);                         // H17-085/088 - AGÊNCIA DO APRESENTANTE
  strLinha := strLinha + fPadR('', 62);                                        // H18-089/150 - FILLER
  strLinha := strLinha + fPadL(IntToStr(intContTotal), 10, '0');               // H19-151/160 - SEQUENCIAL DO REGISTRO
  strLinha := strLinha + fPadR('', 02); //CHR(13) + CHR(10);                   // H20-161/162 - FINAL DO REGISTRO

  Writeln(txtArq, strLinha);
end;

procedure TRemChq041.pGeraCabLote;
begin

end;

procedure TRemChq041.pGeraDetalhe(qryCheque: TDataSet);
var
  strLinha: String;
  intRecNo: Integer;
  strCodDV1: String;
  strCodDV2: String;
  strCodDV3: String;
  strCodTipificacao: String;
  strCodCamaraCompe: String;
  strDtaVen: String;
  intContRg: Integer;
begin
  {***********}
  {* DETALHE *}
  {********MO*}
  intContRg := 0;

  With qryCheque Do
  Begin
    intRecNo := RecNo;
    DisableControls;
    First;

    While Not Eof Do
    Begin

      If FieldByName('CHQ_MARDES').AsString = 'M' Then
      Begin
        strCodDV1         := Copy(FieldByName('CHQ_CODCMC').AsString, 19, 01);
        strCodDV2         := Copy(FieldByName('CHQ_CODCMC').AsString, 08, 01);
        strCodDV3         := Copy(FieldByName('CHQ_CODCMC').AsString, 30, 01);
        strCodTipificacao := Copy(FieldByName('CHQ_CODCMC').AsString, 18, 01);
        strCodCamaraCompe := Copy(FieldByName('CHQ_CODCMC').AsString, 09, 03);

        strDtaVen := FormatDateTime('DDMMYYYY', FieldByName('CHQ_DTAVEN').AsDateTime);
        Inc(intContRg);

        strLinha := fPadR(strCodCamaraCompe, 03);                                                // D01-001/003 - COMPE DE DESTINO
        strLinha := strLinha + fPadR(FieldByName('CHQ_CODBCO').AsString, 03);                    // D02-004/006 - BANCO DE DESTINO
        strLinha := strLinha + fPadR(FieldByName('CHQ_NUMAGE').AsString, 04);                    // D03-007/010 - AGÊNCIA DE DESTINO
        strLinha := strLinha + fPadR(strCodDV2, 01);                                             // D04-011/011 - CONTROLE DV2
        strLinha := strLinha + fPadR(FieldByName('CHQ_CONCOR').AsString, 12);                    // D05-012/023 - NÚMERO DA CONTA DE DESTINO
        strLinha := strLinha + fPadR(strCodDV1, 01);                                             // D06-024/024 - CONTROLE DV1
        strLinha := strLinha + fPadR(FieldByName('CHQ_NUMCHQ').AsString, 06);                    // D07-025/030 - NÚMERO DO DOCUMENTO
        strLinha := strLinha + fPadR(strCodDV3, 01);                                             // D08-031/031 - CONTROLE DV3
        strLinha := strLinha + '00';                                                             // D09-032/033 - TIPO DE DOCUMENTO
        strLinha := strLinha + fValNumForm(FieldByName('CHQ_VALCHQ').AsFloat,17);                // D10-034/050 - VALOR
        strLinha := strLinha + fPadR('', 02);                                                    // D11-051/052 - CÓDIGO DE DEVOLUÇÃO
        strLinha := strLinha + fPadR(strCodTipificacao, 01);                                     // D12-053/053 - TIPIFICAÇÃO
        strLinha := strLinha + '041';                                                            // D13-054/056 - BANCO DO APRESENTANTE
        strLinha := strLinha + fPadR(fCfgSis('BSCEMP'), 4);                                      // D14-057/060 - CÓDIGO DA LOJA
        strLinha := strLinha + '000';                                                            // D15-061/063 - IMPRESSORA FISCAL - POS
        strLinha := strLinha + fStrZero(intContRg, 06);                                          // D16-064/069 - SEQUENCIA DO CHEQUE NO LOTE
        strLinha := strLinha + fPadR('', 01);                                                    // D17-070/070 - FILLER
        strLinha := strLinha + FormatDateTime('YYYYMMDD', FieldByName('CHQ_DTADEP').AsDateTime); // D18-071/078 - DATA DE EFETIVAÇÃO
        strLinha := strLinha + fPadR('', 14);                                                    // D19-079/092 - CÓDIGO DE GARANTIA
        strLinha := strLinha + fPadR('0', 08);                                                   // D20-093/100 - CONTROLE DA EMPRESA
        strLinha := strLinha + fPadR('0', 06);                                                   // D21-101/106 - LOTE DA EMPRESA
        strLinha := strLinha + fPadR('', 20);                                                    // D22-107/126 - FILLER
        strLinha := strLinha + fPadL(FieldByName('CHQ_C_G_C_').AsString, 14, '0');               // D23-127/140 - CPF/CNPJ EMITENTE
        strLinha := strLinha + fPadR('', 10);                                                    // D24-141/150 - FILLER
        strLinha := strLinha + fStrZero(intContRg, 10);                                          // D25-151/160 - SEQUENCIAL DO REGISTRO
        strLinha := strLinha + fPadR('', 02); //CHR(13) + CHR(10);                               // D26-161/162 - FINAL DO REGISTRO

        Writeln(txtArq, strLinha);

        stlContas.Add(FieldByName('CHQ_CONCOR').AsString);

      End;

      Next;
    End;

    RecNo := intRecNo;
    EnableControls;
  End;
end;

procedure TRemChq041.pGeraTrailer;
var
  strLinha: String;
begin
  {*****************************************}
  {* TRAILER DE LOTE - REGISTRO = 5        *}
  {**************************************IV*}

  strLinha := 'T';                                                                // T01-001/001 - TIPO DE REGISTRO
  strLinha := strLinha + fPadR(fCfgSis('BSAGDP'), 04);                            // T02-002/005 - AGÊNCIA DO DEPOSITANTE
  strLinha := strLinha + fPadR(fCfgSis('BSCCDP'), 10);                            // T03-006/015 - CONTA DO DEPOSITANTE
  strLinha := strLinha + fPadR(fTiraCaracEspeciais(FNomEmp), 25);                 // T04-016/040 - NOME DA EMPRESA DEPOSITANTE
  strLinha := strLinha + '041';                                                   // T05-041/043 - NÚMERO DO BANCO APRESENTANTE
  strLinha := strLinha + '8';                                                     // T06-044/044 - DV DO NÚMERO DO BANCO
  strLinha := strLinha + fPadL(IntToStr(intIndInterface), 1);                     // T07-045/045 - INDICADOR DE INTERFACE
  strLinha := strLinha + FormatDateTime('YYYYMMDD', FDtaCus);                     // T08-046/053 - DATA DO MOVIMENTO
  strLinha := strLinha + FormatDateTime('YYYYMMDD', VS_Date);                     // T09-054/061 - DATA DE CRIAÇÃO DO ARQUIVO
  strLinha := strLinha + FormatDateTime('HHMM', fTime());                         // T10-062/065 - HORA E MINUTO DA CRIAÇÃO DO ARQUIVO
  strLinha := strLinha + fPadR(IntToStr(intSeq), 04);                             // T11-066/069 - SEQUENCIA DA REMESSA
  strLinha := strLinha + fPadR('', 02);                                           // T12-070/071 - CÓDIGO DE DEVOLUÇÃO
  strLinha := strLinha + fPadR('', 01);                                           // T13-072/072 - FILLER
  strLinha := strLinha + fPadR(fCfgSis('BSCEMP'), 4);                             // T14-073/076 - CÓDIGO DA EMPRESA
  strLinha := strLinha + fPadR('', 03);                                           // T15-077/079 - FILLER
  strLinha := strLinha + fValNumForm(FTotChq, 15);                                // T16-080/094 - TOTAL DO ARQUIVO
  strLinha := strLinha + fPadR('0', 56);                                          // T17-095/150 - FILLER
  strLinha := strLinha + fPadL(IntToStr(intContTotal), 10, '0');                  // T18-151/160 - SEQUENCIAL DO ARQUIVO
  strLinha := strLinha + fPadR('', 02); //CHR(13) + CHR(10);                      // T19-161/162 - FINAL DO REGISTRO

  Writeln(txtArq, strLinha);
end;

procedure TRemChq041.pGeraTraLote;
begin

end;

procedure TRemChq041.pIniciaExportacao(qryCheque: TDataSet);
var
  intRecNo: Integer;
begin
  inherited;

  With qryCheque Do
  Begin
    intRecNo := RecNo;
    DisableControls;
    First;
    intIndInterface := 0;

    While Not Eof Do
    Begin
      If FieldByName('CHQ_MARDES').AsString = 'M' Then
      Begin
        If FieldByName('CHQ_VALCHQ').AsFloat <= 299.99 Then
        begin
          if intIndInterface = 2 Then
          begin
            intIndInterface := 9;
            Break;
          end
          else
          begin
            intIndInterface := 1;
          end;
        end
        else
        If FieldByName('CHQ_VALCHQ').AsFloat > 299.99 Then
        begin
          if intIndInterface = 1 Then
          begin
            intIndInterface := 9;
            Break;
          end
          else
          begin
            intIndInterface := 2;
          end;
        end;
      End;
      Next;
    End;
    RecNo := intRecNo;
    EnableControls;
  End;

  intContTotal := 0;
  With qryCheque Do
  Begin
    intRecNo := RecNo;
    DisableControls;
    First;
    While Not Eof Do
    Begin
      If FieldByName('CHQ_MARDES').AsString = 'M' Then
      Begin
        Inc(intContTotal);
      end;
      Next;
    end;
    RecNo := intRecNo;
    EnableControls;
  end;
end;

end.
