unit untConsertoEquipGeraExcel;

interface

uses
  untExcel, untConsertoEquipamento, Uni, UniClientDataSet, Forms, SysUtils,
  cxProgressBar, untFuncoesGenerica, strUtils, DB;

type
  TGeraExcelOS = class
  private
    blnAbrirAoFinalizar: Boolean;
    FpgbProgresso: TcxProgressBar;
    FPais: TPais;
    objExcel  : TExcel;
    arrItensOS: Array Of Array [1..2] Of String;
    arrServOS : Array Of Array [1..2] Of String;

    strNomArq,
    strSQL   ,
    strUltCol: String;
    intQtdCol,
    intColSer: Integer;
    fltValICM: Double;
    fltTotIPI: Double;

    qryCadEmp: TUniQuery;
    qryCadCli: TUniQuery;
    qryCadEqu: TUniQuery;

    procedure pEscrever(AintLinha, AintColuna: Integer; AvarValor: Variant);
    procedure pMesclar(AstrCelulaInicial, AstrCelulaFinal: string);
    procedure pColuna(AintLinha: integer; AstrValor: string);
    procedure pColunaServ(AintLinha: integer; AstrValor: string);

    procedure pIniciaProgresso;
    procedure pDefineColunasItens;
    procedure pDefineColunasServicos;
    procedure pCarregaDadosEmpresa;
    procedure pCarregaDadosCliente;

    procedure pFormataCabecalho;
    procedure pIncluiDadosEmpresa;
    procedure pIncluiDadosOSCliente;
    procedure pIncluiDadosOSEquipamento;
    procedure pIncluiItens;
    procedure pIncluiServicos;
    procedure pIncluiObservacao;
    procedure pIncluiSomatorio;
    procedure pAlternaCorItensServicos(AintRecNo: Integer);

    function fCriaArquivo: Boolean;
    function fAcessorios: String;
    function fGarantia(AstrGarantia: String): String;
    function fDefeitos: String;
  public
    objConEqu : TConEqu;
    constructor Create(ApgbProgresso: TcxProgressBar);
    destructor Destroy; override;

    function fGeraExcel: String;
  end;

const
  NRO_LIN_CAB_EMP = 8;
  NRO_LIN_CAB_CLI = 10;
  NRO_LIN_CAB_EQU = 9;
  NRO_LIN_ROD_SOM = 7;

implementation

uses
  untFuncoesSimples, untPesqAux;

{ TGeraExcelOS }

constructor TGeraExcelOS.Create(ApgbProgresso: TcxProgressBar);
begin
  fltValICM := 0;
  fltTotIPI := 0;
  FpgbProgresso := ApgbProgresso;
  qryCadEmp := fCriaQuery;
  qryCadCli := fCriaQuery;
  qryCadEqu := fCriaQuery;
end;

destructor TGeraExcelOS.Destroy;
begin
  FreeAndNil(qryCadEmp);
  FreeAndNil(qryCadCli);
  FreeAndNil(qryCadEqu);
  inherited;
end;

function TGeraExcelOS.fAcessorios: String;
var
  strAcessorios: String;
  cdsDados: TUniClientDataSet;
begin
  Result := '';

  if objConEqu.cdsAceEqu.IsEmpty then
    Exit;

  cdsDados := TUniClientDataSet.Create(Nil);

  try
    pCloneDataSet(cdsDados, objConEqu.cdsAceEqu);

    cdsDados.First;
    strAcessorios := '';

    while not cdsDados.Eof do
    begin
      if not fEmptyStr(strAcessorios) then
        strAcessorios := strAcessorios + ' | ';

      strAcessorios := strAcessorios + cdsDados.FieldByName('QTDACE').AsString + ' ' + cdsDados.FieldByName('DESACE').AsString;

      cdsDados.Next;
    end;

    Result := strAcessorios;
  finally
    FreeAndNil(cdsDados);
  end;
end;

function TGeraExcelOS.fCriaArquivo: Boolean;
var
  strPathExe,
  strDirGrav: String;
begin
  Result := False;
  strPathExe := ExtractFilePath(Application.ExeName);

  if not DirectoryExists(strPathExe + 'Ordem Serviço') then
    CreateDir(strPathExe + 'Ordem Serviço');

  strDirGrav := strPathExe + 'Ordem Serviço';
  strNomArq  := strDirGrav + '\OS_' + objConEqu.strNumero + '_' + objConEqu.strCodEmp + '.xls';

  if (not objExcel.CriarArquivo(strNomArq)) then
    Exit;

  Result := True;
end;

function TGeraExcelOS.fDefeitos: String;
var
  strDefeitos: String;
  cdsDados: TUniClientDataSet;
begin
  Result := '';

  if objConEqu.cdsDfeEqu.IsEmpty then
    Exit;

  cdsDados := TUniClientDataSet.Create(Nil);

  try
    pCloneDataSet(cdsDados, objConEqu.cdsDfeEqu);

    cdsDados.First;
    strDefeitos := '';

    while not cdsDados.Eof do
    begin
      if not fEmptyStr(strDefeitos) then
        strDefeitos := strDefeitos + ' | ';

      strDefeitos := strDefeitos + cdsDados.FieldByName('DESDFE').AsString;

      cdsDados.Next;
    end;

    Result := strDefeitos;
  finally
    FreeAndNil(cdsDados);
  end;
end;

function TGeraExcelOS.fGarantia(AstrGarantia: String): String;
begin
  case (AnsiIndexStr(AstrGarantia, ['N', 'F', 'L', 'R'])) of
    0: Result := 'Não';
    1: Result := 'Fábrica';
    2: Result := 'Loja';
    3: Result := 'Retorno Garantia';
  end;
end;

function TGeraExcelOS.fGeraExcel: String;
begin
  Result := '';
  
  objExcel := TExcel.fCriarExcel(nil);

  try
    if (not fCriaArquivo) then
      Exit;

    SetLength(arrItensOS, 0);
    SetLength(arrServOS, 0);
    pDefineColunasItens;
    pDefineColunasServicos;

    pIniciaProgresso;
    pCarregaDadosEmpresa;
    pCarregaDadosCliente;
    pPesquisaCadEqu(qryCadEqu, qryCadEqu, objConEqu.strCodEqu);

    objExcel.LinhaAtual := 1;
    strUltCol  := fGetLetraAlfa(intQtdCol);

    objExcel.DefinirFonte(CourierNew, 10);

    pFormataCabecalho;

    pIncluiDadosEmpresa;
    pIncluiDadosOSCliente;
    pIncluiDadosOSEquipamento;
    pIncluiItens;
    pIncluiServicos;
    pIncluiObservacao;
    pIncluiSomatorio;

    objExcel.OrientacaoPagina(Paisagem);
    objExcel.AutoAjuste;

    objExcel.SalvarArquivo;
    objExcel.FblnShowOnTerminate := blnAbrirAoFinalizar;
    objExcel.FecharArquivo;

    Result := strNomArq;
  finally
    FreeAndNil(objExcel);
  end;
end;

procedure TGeraExcelOS.pAlternaCorItensServicos(AintRecNo: Integer);
begin
  if AintRecNo mod 2 = 0 then
    objExcel.CorFundo('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual), Cinza);
end;

procedure TGeraExcelOS.pCarregaDadosCliente;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADCLI.*, ';
  strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, " - ", CADCID.CID_ESTADO) AS CLI_NOMCID ';
  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  CADCLI ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON (CADCLI.CLI_CODCID = CADCID.CID_CODCID) ';
  strSQL := strSQL + 'WHERE CLI_CODCLI = :CODCLI ';

  qryCadCli.Close;
  qryCadCli.SQL.Clear;
  qryCadCli.SQL.Add(strSQL);
  qryCadCli.ParamByName('CODCLI').AsString := objConEqu.strCodCli;
  qryCadCli.Open;
end;

procedure TGeraExcelOS.pCarregaDadosEmpresa;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADEMP.EMP_CODEMP, ';
  strSQL := strSQL + '  CADEMP.EMP_NOMEMP,';
  strSQL := strSQL + '  CONCAT(CADEMP.EMP_ENDERE, ", ", IFNULL(CADEMP.EMP_ENDNUM,""),IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP))) AS EMP_ENDERE, ';
  strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, " - ", CADCID.CID_ESTADO) AS EMP_NOMCID,';
  strSQL := strSQL + '  IF(IFNULL(CADEMP.EMP_EMAILC, "") = "",  CADEMP.EMP_EMAIL_, CADEMP.EMP_EMAILC) AS EMP_EMAILC,';
  strSQL := strSQL + '  CADEMP.EMP_FONE01,';
  strSQL := strSQL + '  CADEMP.EMP_F_A_X_,';
  strSQL := strSQL + '  CADEMP.EMP_C_G_C_,';
  strSQL := strSQL + '  CADEMP.EMP_I_E_S_ ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON (CADEMP.EMP_CODCID = CADCID.CID_CODCID) ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CADEMP.EMP_CODEMP = :CODEMP ';

  qryCadEmp.Close;
  qryCadEmp.SQL.Clear;
  qryCadEmp.SQL.Add(strSQL);
  qryCadEmp.ParamByName('CODEMP').AsString := objConEqu.strCodEmp;
  qryCadEmp.Open;
end;

procedure TGeraExcelOS.pIncluiDadosOSCliente;
var
  strConPag,
  strNomVen: String;
begin
  strNomVen := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [objConEqu.strCodVen], False);

  objExcel.ProximaLinha;

  pEscrever(objExcel.ProximaLinha, 01, IIF(fCfgSis('PROSER', varBoolean), 'Protocolo: ' + objConEqu.strProtoc, ''));
  pEscrever(objExcel.LinhaAtual,   08, 'Vendedor:    ' + strNomVen);
  pEscrever(objExcel.ProximaLinha, 01, 'O.S. Nro.: ' + objConEqu.strNumero);
  pEscrever(objExcel.LinhaAtual,   08, 'Dt. Entrada:   ' + objConEqu.strDtaEnt);
  pEscrever(objExcel.ProximaLinha, 01, 'Nome:      ' + qryCadCli.FieldByName('CLI_NOMCLI').AsString);

  objExcel.DefinirFonte('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual), CourierNew, 14);

  pEscrever(objExcel.ProximaLinha, 01, 'Endereço:  ' + qryCadCli.FieldByName('CLI_ENDERE').AsString);
  pEscrever(objExcel.LinhaAtual,   08, 'Bairro:        ' + qryCadCli.FieldByName('CLI_BAIRRO').AsString);
  pEscrever(objExcel.ProximaLinha, 01, 'Município: ' + qryCadCli.FieldByName('CLI_NOMCID').AsString);
  pEscrever(objExcel.LinhaAtual,   08, 'C.E.P.:        ' + fFormataCEP(qryCadCli.FieldByName('CLI_C_E_P_').AsString));
  pEscrever(objExcel.ProximaLinha, 01, 'CNPJ:      ' + fFormataCpfCgc(qryCadCli.FieldByName('CLI_C_G_C_').AsString, FPais));
  pEscrever(objExcel.LinhaAtual,   08, 'I.E.:          ' + qryCadCli.FieldByName('CLI_I_E_S_').AsString);
  pEscrever(objExcel.ProximaLinha, 01, 'Fone:      ' + fFormataFone(qryCadCli.FieldByName('CLI_FONE01').AsString));
  pEscrever(objExcel.ProximaLinha, 01, 'Fax:       ' + qryCadCli.FieldByName('CLI_F_A_X_').AsString);
  pEscrever(objExcel.LinhaAtual,   08, 'Prev. Entrega: ' + objConEqu.strPrevis);

  strConPag := (fFormataCondPag(objConEqu.strConPag));
  strConPag := Copy(strConPag, 5, Length(strConPag)) + ' D.D.L.';
  pEscrever(objExcel.ProximaLinha, 01, 'Cond.Pgto: ' + strConPag + IIF(objConEqu.strConPag = '01000', '     PGTO A VISTA', ''));

  pEscrever(objExcel.LinhaAtual,   08, 'Contato:       ' + objConEqu.strCntTel);
  objExcel.ProximaLinha;
end;

procedure TGeraExcelOS.pIncluiDadosOSEquipamento;
begin
  objExcel.ProximaLinha;

  pEscrever(objExcel.ProximaLinha, 01, 'Equipamento:  ' + qryCadEqu.FieldByName('EQU_DESCRI').AsString);
  pEscrever(objExcel.ProximaLinha, 01, 'Marca:        ' + fRetNomMarca(qryCadEqu.FieldByName('EQU_CODMAR').AsString));
  pEscrever(objExcel.LinhaAtual,   08, 'Voltagem: ' + qryCadEqu.FieldByName('EQU_VOLTAG').AsString);
  pEscrever(objExcel.ProximaLinha, 01, 'Nº Série:     ' + objConEqu.strNSerie +
  '       | Nº Patrimônio: ' + objConEqu.strNumPat +
  '       | Dados Fabr.: ' + objConEqu.strDadFab);
  pEscrever(objExcel.ProximaLinha, 01, 'Nota Fiscal:  ' + objConEqu.strNFComp);
  pEscrever(objExcel.LinhaAtual,   08, 'Garantia: ' + fGarantia(objConEqu.strGarant));
  pEscrever(objExcel.ProximaLinha, 01, 'Acessório(s): ' + fAcessorios);
  objExcel.ProximaLinha;
  pEscrever(objExcel.ProximaLinha, 01, 'Defeito(s):   ' + fDefeitos);
  objExcel.ProximaLinha;
end;

procedure TGeraExcelOS.pIncluiItens;
var
  intCont: integer;
  strCodNCM: String;
  cdsDados : TUniClientDataSet;
begin
  if objConEqu.cdsIteEqu.IsEmpty then
    Exit;

  cdsDados := TUniClientDataSet.Create(Nil);

  try
    pCloneDataSet(cdsDados, objConEqu.cdsIteEqu);

    objExcel.ProximaLinha;
    pEscrever(objExcel.LinhaAtual, 01, 'PEÇAS');
    objExcel.Negrito('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual), True);
    objExcel.Alinhamento('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual), Centro);
    objExcel.Bordas('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual));
    pMesclar('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual));

    objExcel.ProximaLinha;

    for intCont := 1 To intQtdCol Do
    begin
      pEscrever(objExcel.LinhaAtual, intCont, arrItensOS[Pred(intCont), 01]);
      objExcel.Negrito(objExcel.LinhaAtual, intCont, True);

      if (arrItensOS[Pred(intCont), 02] = 'CODNCM') then
        objExcel.Alinhamento(objExcel.LinhaAtual,intCont, Esquerda)
      else if (cdsDados.FieldByName(arrItensOS[Pred(intCont), 02]).DataType = ftFloat) then
        objExcel.Alinhamento(objExcel.LinhaAtual,intCont, Direita)
      else
        objExcel.Alinhamento(objExcel.LinhaAtual,intCont, Esquerda);
    end;

    objExcel.CorFundo('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual), Preto);
    objExcel.CorFonte('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual), Branco);
    objExcel.Bordas('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual));

    cdsDados.First;

    while not cdsDados.Eof do
    begin
      objExcel.ProximaLinha;

      for intCont := 1 to intQtdCol do
      begin
        if arrItensOS[Pred(intCont), 02] = 'CODNCM' then
        begin
          strCodNCM := fCampoTabela('ITE_CLAIPI', 'CADITE', ['ITE_CODITE'], [cdsDados.FieldByName('CODITE').AsString], False);
          pEscrever(objExcel.LinhaAtual, intCont, strCodNCM);
          objExcel.Alinhamento(objExcel.LinhaAtual, intCont, Esquerda);
        end
        else if cdsDados.FieldByName(arrItensOS[Pred(intCont), 02]).DataType = ftFloat then
        begin
          pEscrever(objExcel.LinhaAtual, intCont, FormatFloat('#,##0.00', cdsDados.FieldByName(arrItensOS[Pred(intCont), 02]).AsFloat));
          objExcel.Alinhamento(objExcel.LinhaAtual, intCont, Direita);
        end
        else
        begin
          pEscrever(objExcel.LinhaAtual, intCont, '''' + cdsDados.FieldByName(arrItensOS[Pred(intCont), 02]).AsString);
          objExcel.Alinhamento(objExcel.LinhaAtual, intCont, Esquerda);
        end;
      end;

      objExcel.Bordas('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual));

      pAlternaCorItensServicos(cdsDados.RecNo);

      fltValICM := fltValICM + cdsDados.FieldByName('VALICM').AsFloat;
      fltTotIPI := fltTotIPI + cdsDados.FieldByName('VALIPI').AsFloat;

      cdsDados.Next;
    end;

    objExcel.ProximaLinha;
  finally
    FreeAndNil(cdsDados);
  end;
end;

procedure TGeraExcelOS.pIncluiObservacao;
var
  intLinIni: Integer;
begin
  pEscrever(objExcel.ProximaLinha, 02, 'DECLARO QUE ESTOU DE ACORDO COM OS ACESSÓRIOS DEIXADOS NA MÁQUINA DESCRITOS NA ORDEM DE SERVIÇO, ');
  pMesclar('B' + IntToStr(objExcel.LinhaAtual), 'F' + IntToStr(objExcel.LinhaAtual));
  intLinIni := objExcel.LinhaAtual;
  pEscrever(objExcel.ProximaLinha, 02, 'TAMBÉM AUTORIZO A ' + qryCadEmp.FieldByName('EMP_NOMEMP').AsString + ' A VENDER O ');
  pMesclar('B' + IntToStr(objExcel.LinhaAtual), 'F' + IntToStr(objExcel.LinhaAtual));
  pEscrever(objExcel.ProximaLinha, 02, 'EQUIPAMENTO PARA COBRIR AS DESPESAS, CASO O MESMO NÃO SEJA RETIRADO EM 90 DIAS. ');
  pMesclar('B' + IntToStr(objExcel.LinhaAtual), 'F' + IntToStr(objExcel.LinhaAtual));
  pEscrever(objExcel.ProximaLinha, 02, 'TAMBÉM ESTOU CIENTE QUE SÓ CONSIGO RETIRAR O EQUIPAMENTO MEDIANTE A ENTREGA DO CANHOTO QUE ');
  pMesclar('B' + IntToStr(objExcel.LinhaAtual), 'F' + IntToStr(objExcel.LinhaAtual));
  pEscrever(objExcel.ProximaLinha, 02, 'RECEBI NO MOMENTO DA ABERTURA DA ORDEM DE SERVIÇO');
  pMesclar('B' + IntToStr(objExcel.LinhaAtual), 'F' + IntToStr(objExcel.LinhaAtual));

  objExcel.Bordas('B' + IntToStr(intLinIni), 'F' + IntToStr(objExcel.LinhaAtual + NRO_LIN_ROD_SOM - 1), True, True, True, True);
  objExcel.Alinhamento('B' + IntToStr(intLinIni), 'F' + IntToStr(objExcel.LinhaAtual + NRO_LIN_ROD_SOM - 1), Esquerda);
end;

procedure TGeraExcelOS.pIncluiServicos;
var
  intCont,
  intColuna,
  intColDif: integer;
  cdsDados : TUniClientDataSet;
begin
  if objConEqu.cdsSerEqu.IsEmpty then
    Exit;

  cdsDados := TUniClientDataSet.Create(Nil);

  try
    pCloneDataSet(cdsDados, objConEqu.cdsSerEqu);

    objExcel.ProximaLinha;
    pEscrever(objExcel.LinhaAtual, 01, 'SERVIÇOS');
    objExcel.Negrito('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual), True);
    objExcel.Alinhamento('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual), Centro);
    objExcel.Bordas('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual));
    pMesclar('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual));

    objExcel.ProximaLinha;

    pMesclar('B' + IntToStr(objExcel.LinhaAtual), IIF((intColSer = 5), 'K', 'J') + IntToStr(objExcel.LinhaAtual));

    intColDif := intQtdCol - intColSer;

    for intCont := 1 To intColSer Do
    begin
      intColuna := IIF((intCont > 2), intCont + intColDif, intCont);

      pEscrever(objExcel.LinhaAtual, intColuna, arrServOS[Pred(intCont), 01]);
      objExcel.Negrito(objExcel.LinhaAtual, intColuna, True);

      if (cdsDados.FieldByName(arrServOS[Pred(intCont), 02]).DataType = ftFloat) then
        objExcel.Alinhamento(objExcel.LinhaAtual, intColuna, Direita)
      else
        objExcel.Alinhamento(objExcel.LinhaAtual, intColuna, Esquerda);
    end;

    objExcel.CorFundo('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual), Preto);
    objExcel.CorFonte('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual), Branco);
    objExcel.Bordas('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual));

    cdsDados.First;

    while not cdsDados.Eof do
    begin
      objExcel.ProximaLinha;

      pMesclar('B' + IntToStr(objExcel.LinhaAtual), IIF((intColSer = 5), 'K', 'J') + IntToStr(objExcel.LinhaAtual));

      for intCont := 1 to intColSer do
      begin
        intColuna := IIF((intCont > 2), intCont + intColDif, intCont);

        if cdsDados.FieldByName(arrServOS[Pred(intCont), 02]).DataType = ftFloat then
        begin
          pEscrever(objExcel.LinhaAtual, intColuna, FormatFloat('#,##0.00', cdsDados.FieldByName(arrServOS[Pred(intCont), 02]).AsFloat));
          objExcel.Alinhamento(objExcel.LinhaAtual, intColuna, Direita);
        end
        else
        begin
          pEscrever(objExcel.LinhaAtual, intCont, '''' + cdsDados.FieldByName(arrServOS[Pred(intCont), 02]).AsString);
          objExcel.Alinhamento(objExcel.LinhaAtual, intColuna, Esquerda);
        end;
      end;

      objExcel.Bordas('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual));

      pAlternaCorItensServicos(cdsDados.RecNo);

      cdsDados.Next;
    end;

    objExcel.ProximaLinha;
  finally
    FreeAndNil(cdsDados);
  end;
end;

procedure TGeraExcelOS.pIncluiSomatorio;
var
  intCont,
  intLinAtu: Integer;
begin
  intLinAtu := objExcel.LinhaAtual;

  for intCont := intLinAtu to intLinAtu + NRO_LIN_ROD_SOM do
  begin
    pMesclar('J' + IntToStr(intCont), 'K' + IntToStr(intCont));
    pMesclar('L' + IntToStr(intCont), 'N' + IntToStr(intCont));
    objExcel.Negrito('J' + IntToStr(intCont), 'N' + IntToStr(intCont), True);
    objExcel.Alinhamento('J' + IntToStr(intCont), 'K' + IntToStr(intCont), Esquerda);
    objExcel.Alinhamento('L' + IntToStr(intCont), 'N' + IntToStr(intCont), Direita);
  end;

  pEscrever(objExcel.LinhaAtual,   intQtdCol - 4, 'Total de Peças:');
  pEscrever(objExcel.LinhaAtual,   intQtdCol - 2, FormatFloat('#,##0.00', objConEqu.fltVlrPro));
  pEscrever(objExcel.ProximaLinha, intQtdCol - 4, 'Total de Serviços:');
  pEscrever(objExcel.LinhaAtual,   intQtdCol - 2, FormatFloat('#,##0.00', objConEqu.fltVlrSer));
  pEscrever(objExcel.ProximaLinha, intQtdCol - 4, 'Valor ST:');
  pEscrever(objExcel.LinhaAtual,   intQtdCol - 2, FormatFloat('#,##0.00', objConEqu.fltTotRet));
  pEscrever(objExcel.ProximaLinha, intQtdCol - 4, 'Valor ICMS:');
  pEscrever(objExcel.LinhaAtual,   intQtdCol - 2, FormatFloat('#,##0.00', fltValICM));
  pEscrever(objExcel.ProximaLinha, intQtdCol - 4, 'Valor IPI:');
  pEscrever(objExcel.LinhaAtual,   intQtdCol - 2, FormatFloat('#,##0.00', fltTotIPI));
  pEscrever(objExcel.ProximaLinha, intQtdCol - 4, 'Desconto:');
  pEscrever(objExcel.LinhaAtual,   intQtdCol - 2, FormatFloat('#,##0.00', objConEqu.fltDesEsp + objConEqu.fltDesEspSer));
  pEscrever(objExcel.ProximaLinha, intQtdCol - 4, 'Valor Total:');
  pEscrever(objExcel.LinhaAtual,   intQtdCol - 2, FormatFloat('#,##0.00', objConEqu.fltVlrCon));
end;

procedure TGeraExcelOS.pColuna(AintLinha: integer; AstrValor: string);
begin
  if AintLinha = 1 then
    SetLength(arrItensOS, Succ(Length(arrItensOS)));

  inc(intQtdCol);
  arrItensOS[Pred(intQtdCol)][AintLinha] := AstrValor;
end;

procedure TGeraExcelOS.pColunaServ(AintLinha: integer; AstrValor: string);
begin
  if AintLinha = 1 then
    SetLength(arrServOS, Succ(Length(arrServOS)));

  inc(intColSer);
  arrServOS[Pred(intColSer)][AintLinha] := AstrValor;
end;

procedure TGeraExcelOS.pEscrever(AintLinha, AintColuna: Integer;AvarValor: Variant);
begin
  objExcel.Escrever(AintLinha, AintColuna, AvarValor);

  FpgbProgresso.Position := FpgbProgresso.Position + 1;
  Application.ProcessMessages;
end;

procedure TGeraExcelOS.pFormataCabecalho;
var
  intCont,
  intPriLin_CLI: Integer;
  intPriLin_EQU: Integer;
  intUltLin_Cli: Integer;
  intUltLin_Equ: Integer;
begin
  intPriLin_CLI := NRO_LIN_CAB_EMP + 1;
  intUltLin_Cli := NRO_LIN_CAB_EMP + NRO_LIN_CAB_CLI;
  intPriLin_EQU := intUltLin_Cli   + 1;
  intUltLin_Equ := intUltLin_Cli   + NRO_LIN_CAB_EQU;

  {******************************************}
  {* ADICIONA BORDA NAS LINHAS DO CABEÇALHO *}
  {****************************************DH}
  objExcel.Bordas('A2',  strUltCol + IntToStr(NRO_LIN_CAB_EMP - 1), True, True, True, True);
  objExcel.Bordas('A' + IntToStr(NRO_LIN_CAB_EMP),  strUltCol + IntToStr(NRO_LIN_CAB_EMP), True, True, True, True);

  objExcel.Bordas('A' + IntToStr(intPriLin_CLI),  strUltCol + IntToStr(intUltLin_CLI - 1), True, True, True, True);
  objExcel.Bordas('A' + IntToStr(intUltLin_CLI),  strUltCol + IntToStr(intUltLin_CLI), True, True, True, True);

  objExcel.Bordas('A' + IntToStr(intPriLin_EQU),  strUltCol + IntToStr(intUltLin_EQU), True, True, True, True);

  {****************************************}
  {* FORMATA LINHAS DADOS DA EMPRESA      *}
  {**************************************DH}
  for intCont := 1 to NRO_LIN_CAB_EMP do
  begin
    objExcel.Negrito('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
    objExcel.Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Centro);
    pMesclar('A' + IntToStr(intCont), strUltCol + IntToStr(intCont));
  end;

  {****************************************}
  {* FORMATA LINHAS DADOS DO CLIENTE      *}
  {**************************************DH}
  for intCont := intPriLin_CLI to intUltLin_Cli -1 do
  begin
    objExcel.Negrito('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
    pMesclar('A' + IntToStr(intCont), 'G' + IntToStr(intCont));
    pMesclar('H' + IntToStr(intCont), strUltCol + IntToStr(intCont));
    objExcel.Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Esquerda);
  end;

  pMesclar('A' + IntToStr(intUltLin_Cli), strUltCol + IntToStr(intUltLin_Cli));

  {****************************************}
  {* FORMATA LINHAS DADOS DO EQUIPAMENTO  *}
  {**************************************DH}
  for intCont := intPriLin_EQU to intPriLin_EQU + 4 do
  begin
    pMesclar('A' + IntToStr(intCont), 'G' + IntToStr(intCont));
    pMesclar('H' + IntToStr(intCont), strUltCol + IntToStr(intCont));
    objExcel.Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Esquerda);
  end;

  for intCont := intPriLin_EQU + 5 to intUltLin_Equ do
  begin
    pMesclar('A' + IntToStr(intCont), strUltCol + IntToStr(intCont));
    objExcel.Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Esquerda);
  end;

  {*****************************************************}
  {* ALTERA COR ULT. LINHA EMPRESA E ULT. LINHA CLIENTE*}
  {***************************************************DH}
  objExcel.CorFundo('A' + IntToStr(NRO_LIN_CAB_EMP), strUltCol + IntToStr(NRO_LIN_CAB_EMP), Cinza);
  objExcel.CorFundo('A' + IntToStr(intUltLin_Cli), strUltCol + IntToStr(intUltLin_Cli), Cinza);
end;

procedure TGeraExcelOS.pIncluiDadosEmpresa;
begin
  pEscrever(objExcel.ProximaLinha, 01, qryCadEmp.FieldByName('EMP_NOMEMP').AsString);
  objExcel.DefinirFonte('A' + IntToStr(objExcel.LinhaAtual), strUltCol + IntToStr(objExcel.LinhaAtual), CourierNew, 14);

  pEscrever(objExcel.ProximaLinha,01, qryCadEmp.FieldByName('EMP_ENDERE').AsString);
  pEscrever(objExcel.ProximaLinha,01, qryCadEmp.FieldByName('EMP_NOMCID').AsString);
  pEscrever(objExcel.ProximaLinha,01, 'CNPJ: ' + fFormataCpfCgc(qryCadEmp.FieldByName('EMP_C_G_C_').AsString, FPais) +
                       ' | IE: ' + qryCadEmp.FieldByName('EMP_I_E_S_').AsString);
  pEscrever(objExcel.ProximaLinha,01, qryCadEmp.FieldByName('EMP_EMAILC').AsString);
  pEscrever(objExcel.ProximaLinha,01, 'Fone: ' + qryCadEmp.FieldByName('EMP_FONE01').AsString +
                       ' | Fax: ' + qryCadEmp.FieldByName('EMP_F_A_X_').AsString);
end;

procedure TGeraExcelOS.pIniciaProgresso;
begin
  FpgbProgresso.Position := 0;
  FpgbProgresso.Properties.Max := (objConEqu.cdsIteEqu.RecordCount * intQtdCol) + intQtdCol + // 59
                                  (objConEqu.cdsSerEqu.RecordCount * intColSer) + intColSer +
                                  NRO_LIN_CAB_EMP +
                                  (2 * NRO_LIN_CAB_CLI) +
                                  (2 * NRO_LIN_ROD_SOM);
end;

procedure TGeraExcelOS.pMesclar(AstrCelulaInicial, AstrCelulaFinal: string);
begin
  objExcel.Mesclar(AstrCelulaInicial, AstrCelulaFinal);

//  FpgbProgresso.Position := FpgbProgresso.Position + 1;
  Application.ProcessMessages;
end;

procedure TGeraExcelOS.pDefineColunasItens;
begin
  intQtdCol := 0;
  pColuna(1, 'CÓDIGO');
  pColuna(1, 'DESCRIÇÃO');
  pColuna(1, 'MARCA');
  pColuna(1, 'CÓD. FÁBRICA');
  pColuna(1, 'UNID.');
  pColuna(1, 'NCM');
  pColuna(1, 'CFOP');
  pColuna(1, 'CST');
  pColuna(1, 'QTDE');
  pColuna(1, 'PREÇO UNIT.');
  pColuna(1, 'ICMS ST');
  pColuna(1, '% IPI');
  pColuna(1, '% DESCONTO');
  pColuna(1, 'PREÇO TOTAL');

  intQtdCol := 0;
  pColuna(2, 'CODITE');
  pColuna(2, 'DESITE');
  pColuna(2, 'DESMAR');
  pColuna(2, 'CODFAB');
  pColuna(2, 'UNIDAD');
  pColuna(2, 'CODNCM');
  pColuna(2, 'CLAFIS');
  pColuna(2, 'CODFIS');
  pColuna(2, 'QTDITE');
  pColuna(2, 'UNITAR');
  pColuna(2, 'VALRET');
  pColuna(2, 'ALQIPI');
  pColuna(2, 'PERDES');
  pColuna(2, 'TOTITE');
end;

procedure TGeraExcelOS.pDefineColunasServicos;
begin
  intColSer := 0;
  pColunaServ(1, 'CÓDIGO');
  pColunaServ(1, 'DESCRIÇÃO');

  if (fCfgSis('QTDSER', varBoolean)) then
    pColunaServ(1, 'QTDE');

  pColunaServ(1, 'VALOR UNIT.');
  pColunaServ(1, '% DESCONTO');
  pColunaServ(1, 'VALOR TOTAL');

  intColSer := 0;
  pColunaServ(2, 'CODSER');
  pColunaServ(2, 'DESSER');

  if (fCfgSis('QTDSER', varBoolean)) then
    pColunaServ(2, 'QTDSER');

  pColunaServ(2, 'VALUNI');
  pColunaServ(2, 'PORDES');
  pColunaServ(2, 'VALSER');
end;

end.
