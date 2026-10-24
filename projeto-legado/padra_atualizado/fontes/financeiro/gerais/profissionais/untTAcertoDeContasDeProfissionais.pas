unit untTAcertoDeContasDeProfissionais;

interface

Uses System.Classes, System.SysUtils, System.StrUtils, Uni, UniClientDataset,
     Data.DB, cxProgressBar;

Type
  TCamposFiltroTela = Record
    CodigoEmpresa,
    CodigoProfissional,
    ProfissionaisComCartao,
    RecalcularJuros,
    Titulos: String;

    DataInicial,
    DataFinal: TDateTime;

    ComissaoAPagar: Double;
  End;

Type
  TAcertoDeContasDeProfissionais = class
  private
    FDatasetGrid,
    FDuplicatasCtr: TUniClientDataSet;

    FComissoesBaixadas: TUniQuery;

    FSeqMod,
    FPlanoDeContasCTR,
    FPortadorCTR,
    FHistoricoCTR,
    FPlanoDeContasCTP,
    FPortadorCTP,
    FCentroDeCustosCTP,
    FHistoricoCTP: String;

    FSeqRcxCtp,
    FSeqConCTP,
    FSeqConCTR: Integer;

    FFiltrosSelecionados: TCamposFiltroTela;

    FTipoBaixaCTR,
    FTipoBaixaCTP: String;

    FDescontoAteVencimento: Boolean;

    FPercentualJuros,
    FPercentualMulta: Double;

    FTodasAsComissoes: Boolean;

    FHoraBaixaComissao: TTime;

    function RetornaFiltrosDaTela(AFiltrosSelecionados: TCamposFiltroTela): String;

    function RetornaCampoVendedorVenda: String;

    procedure AbreClientDuplicatasCTR(AFiltrosSelecionados: TCamposFiltroTela;
                                      ACodigoCliente: String);

    function RetonaValorTotalCTR(ASomaNegativos: Boolean): Double;

    procedure RetornaValoresDuplicata(out AValorJuros: Double;
                                      out AValorDesconto: Double;
                                      out AValorCorrigido: Double);

    function RetornaValorDoDesconto: Double;

    function RetornaValorDeCreditos: Double;

    procedure GravaTabelaDeLogDaBaixa;

    procedure AtualizaDadosSequenciaisBaixa;

    function RetornaDifOriBaixaParcial(AValorBaixa: Double): Double;
    function RetornaDataVencimentoBaixaParcial: TDateTime;
  public
    constructor Create; overload;

    property PortadorCTR: String read FPortadorCTR write FPortadorCTR;
    property PlanoDeContasCTR: String read FPlanoDeContasCTR write FPlanoDeContasCTR;
    property HistoricoCTR: String read FHistoricoCTR write FHistoricoCTR;
    property PortadorCTP: String read FPortadorCTP write FPortadorCTP;
    property PlanoDeContasCTP: String read FPlanoDeContasCTP write FPlanoDeContasCTP;
    property CentroDeCustosCTP: String read FCentroDeCustosCTP write FCentroDeCustosCTP;
    property HistoricoCTP: String read FHistoricoCTP write FHistoricoCTP;
    property DatasetGrid: TUniClientDataSet read FDatasetGrid write FDatasetGrid;
    property FiltrosSelecionados: TCamposFiltroTela read FFiltrosSelecionados write FFiltrosSelecionados;

    property PercentualJuros: Double read FPercentualJuros write FPercentualJuros;
    property PercentualMulta: Double read FPercentualMulta write FPercentualMulta;
    property TodasAsComissoes: Boolean read FTodasAsComissoes write FTodasAsComissoes;

    function RetornaDadosFiltradosComissoes(AFiltrosSelecionados: TCamposFiltroTela;
                                            ACarregaVazio: Boolean = False): TUniClientDataset;

    function RetornaDadosComissoesEmAberto(AFiltrosSelecionados: TCamposFiltroTela;
                                           ACodigoProfissional: String): TUniClientDataset;

    //BAIXAS
    function BaixaComissoesProfissional(AFiltrosSelecionados: TCamposFiltroTela;
                                        ACodigoProfissional,
                                        ANomeFormulario: String): Boolean;

    function BaixaDuplicatasContasAReceber(AFiltrosSelecionados: TCamposFiltroTela;
                                           ACodigoCliente,
                                           ANomeFormulario: String;
                                           AValorBaixar: Double;
                                           AGravaMOVBAN: Boolean = False): Boolean;

    function BaixaCreditosContasAReceber(AFiltrosSelecionados: TCamposFiltroTela;
                                         ACodigoCliente,
                                         ANomeFormulario: String): Boolean;

    function GravaEBaixaContasAPagar(ACodigoCliente,
                                     ANomeFormulario: String;
                                     AValorComissao: Double): Boolean;

    function RealizarBaixaDosRegistros(pgbStatus: TcxProgressBar): Boolean;

    procedure RecalcularJuros;
  end;

implementation
Uses untFuncoesSimples, untLogCom, untCadRec, untLogCtr, untFuncoes, untConstantes,
     untCadPag, untTBanCtpRepository, untTBanCtrRepository, untMovBan,
  untTypesSistema;

{ TAcertoDeContasDeProfissionais }

procedure TAcertoDeContasDeProfissionais.AbreClientDuplicatasCTR(
  AFiltrosSelecionados: TCamposFiltroTela; ACodigoCliente: String);
  Var
    LConsulta: TUniQuery;

    LValorJuros,
    LValorDesconto,
    LValorCorrigido: Double;
begin
  If Assigned(FDuplicatasCTR) Then
    FreeAndNil(FDuplicatasCTR);

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM, ' +
                          '       CTR_NUMDUP, ' +
                          '       CTR_ESPDOC, ' +
                          '       CTR_CODEMP, ' +
                          '       CTR_PARCEL, ' +
                          '       CTR_CODCLI, ' +
                          '       CTR_DTAVEN, ' +
                          '       CTR_QTDDAV, ' +
                          '       CTR_RECAUT, ' +
                          '       CTR_DESSUJ, ' +
                          '       CTR_JURSUJ, ' +
                          '       CTR_DESCOB, ' +
                          '       CTR_VALIPI, ' +
                          '       CTR_VALRET, ' +
                          '       CTR_VALCBS, ' +
                          '       CTR_VALIBS, ' +
                          '       CTR_VAL_IS, ' +
                          '       CTR_VALACE, ' +
                          '       CTR_VALFRE, ' +
                          '       CTR_VALFCP, ' +
                          '       CTR_VALDUP, ' +
                          '       CTR_PERDPO, ' +
                          ' 0.00 AS CTR_TAXJUR, ' +
                          ' 0.00 AS CTR_PERMUL, ' +
                          ' "N" AS BAIXADO,   ' +
                          ' " " AS TIPOBAIXA, ' +
                          ' 0.00 AS VALORBAIXA, ';

      If Not FDescontoAteVencimento Then
        LConsulta.SQL.Add('  (CTR_VALDUP - IFNULL(CTR_DESSUJ, 0) + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0)) AS VALORDUPLICATA, ')
      Else
      Begin
        LConsulta.SQL.Add('  (CTR_VALDUP - IFNULL(CTR_DESSUJ, 0) + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0)) AS DUPLICATA_COM_DESC, ');
        LConsulta.SQL.Add('  (CTR_VALDUP - IF( CTR_DTAVEN >= ' + fCurrentDate + ', IFNULL(CTR_DESSUJ, 0), 0 ) + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0)) AS VALORDUPLICATA, ');
        LConsulta.SQL.Add('  (CTR_VALDUP - IF( CTR_DTAVEN >= ' + fCurrentDate + ', IFNULL(CTR_DESSUJ, 0), 0 ) + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0)) AS DUPLICATA_ORI, ');
      End;

      LConsulta.SQL.Add('0.00 AS VALORJUROS, ' +
                        '0.00 AS VALORDESCONTO, ' +
                        '0.00 AS VALORCORRIGIDO ' +
                        'FROM CADREC ' +
                        'WHERE CTR_CODCLI="' + ACodigoCliente + '" ' +
                        '  AND CTR_DTAREC IS NULL ' +
                        '  AND CTR_DOCDIV IS NULL ' +
                        '  AND CTR_TX_PIX IS NULL ');

    If AFiltrosSelecionados.Titulos = 'V' Then
      LConsulta.SQL.Add(' AND CTR_DTAVEN < "' + FormatDateTime('yyyy/mm/dd', VS_Date) + '" ')
    Else If AFiltrosSelecionados.Titulos = 'A' Then
      LConsulta.SQL.Add(' AND CTR_DTAVEN >= "' + FormatDateTime('yyyy/mm/dd', VS_Date) + '" ');

    LConsulta.SQL.Add(' ORDER BY CTR_DTAVEN, CTR_VALDUP ');

    LConsulta.Open;

    FDuplicatasCTR := fCriaClientDatSet(LConsulta);

    FDuplicatasCTR.First;
    While Not FDuplicatasCTR.Eof Do
    Begin
      RetornaValoresDuplicata(LValorJuros,
                              LValorDesconto,
                              LValorCorrigido);

      FDuplicatasCTR.Edit;
      FDuplicatasCTR.FieldByName('CTR_TAXJUR').AsFloat := FPercentualJuros;
      FDuplicatasCTR.FieldByName('CTR_PERMUL').AsFloat := FPercentualMulta;
      FDuplicatasCTR.FieldByName('VALORJUROS').AsFloat := LValorJuros;
      FDuplicatasCTR.FieldByName('VALORDESCONTO').AsFloat := LValorDesconto;
      FDuplicatasCTR.FieldByName('VALORCORRIGIDO').AsFloat := LValorCorrigido;
      FDuplicatasCTR.Post;

      FDuplicatasCTR.Next;
    End;

    FreeAndNil(LConsulta);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + ' - [TAcertoDeContasDeProfissionais.AbreClientDuplicatasCTR]');
  End;
end;

procedure TAcertoDeContasDeProfissionais.AtualizaDadosSequenciaisBaixa;
begin
  FSeqConCtr := 0;
  FSeqConCtp := 0;
  FSeqRcxCtp := 0;
  FSeqMod := '';

  fStartTransaction;
  If fFormataFloat(FDatasetGrid.FieldByName('TOTALCTR').AsFloat, 2) > 0 Then
  Begin
    FSeqConCtr := StrToInt(fRetRcxCon);
    FSeqMod := fRetSequencial('MODCTR');
  End;

  If fFormataFloat(FDatasetGrid.FieldByName('COMISSAOAPAGAR').AsFloat, 2) > 0 Then
  Begin
    FSeqConCtp := fRetCtpCon;
    FSeqRcxCtp := StrToInt(fRetRcxCon);
  End;
  fCommit;
end;

function TAcertoDeContasDeProfissionais.BaixaComissoesProfissional(
  AFiltrosSelecionados: TCamposFiltroTela;
  ACodigoProfissional,
  ANomeFormulario: String): Boolean;
begin
  FComissoesBaixadas := fCriaQuery;

  Try
    FComissoesBaixadas.SQL.Text := 'SELECT AUTOINCREM, ' +
                                   '       COM_DTABAI, ' +
                                   '       COM_HORBAI, ' +
                                   '       COM_OPEBAI, ' +
                                   '       COM_VRCOMI * IF(COM_CREDEB="C", 1, (-1)) AS COM_VRCOMI ' +
                                   'FROM COMPRO ' +
                                   'WHERE COM_CODPRO=:CODPRO ' +
                                   '  AND COM_DTABAI IS NULL ' +
                                   '  AND COM_DTACAD BETWEEN :DTAIN ' +
                                   '                     AND :DTAFIN ';

    If Not AFiltrosSelecionados.CodigoEmpresa.IsEmpty Then
      FComissoesBaixadas.SQL.Add(' AND COM_CODEMP IN (' + AFiltrosSelecionados.CodigoEmpresa + ') ');

    FComissoesBaixadas.ParamByName('CODPRO').AsString := ACodigoProfissional;
    FComissoesBaixadas.ParamByName('DTAIN').AsDateTime := AFiltrosSelecionados.DataInicial;
    FComissoesBaixadas.ParamByName('DTAFIN').AsDateTime := AFiltrosSelecionados.DataFinal;

    FComissoesBaixadas.Open;
    While Not FComissoesBaixadas.Eof Do
    Begin
      FComissoesBaixadas.Edit;
      FComissoesBaixadas.FieldByName('COM_DTABAI').AsDateTime := VS_Date;
      FComissoesBaixadas.FieldByName('COM_HORBAI').AsDateTime := FHoraBaixaComissao;
      FComissoesBaixadas.FieldByName('COM_OPEBAI').AsString := strLoginUsuarioLogado;
      FComissoesBaixadas.Post;

      untLogCom.fGravaLogCom(FComissoesBaixadas.FieldByName('AUTOINCREM').AsString,
                             'BAIXA',
                             ANomeFormulario);

      FComissoesBaixadas.Next;
    End;

    Result := True;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + ' - [TAcertoDeContasDeProfissionais.BaixaComissoesProfissional]');
  End;
end;

function TAcertoDeContasDeProfissionais.BaixaCreditosContasAReceber(
  AFiltrosSelecionados: TCamposFiltroTela; ACodigoCliente,
  ANomeFormulario: String): Boolean;
  Var
    LValorDesconto: Double;

    LSequencialMOVBAN: String;

    LBanCtr: TBanCtrRepository;
begin
  Result := False;

  LValorDesconto := 0;

  LBanCtr := TBanCtrRepository.Create;

  FDuplicatasCTR.Filter := 'CTR_VALDUP < 0';
  FDuplicatasCTR.Filtered := True;

  LSequencialMOVBAN := '';

  FDuplicatasCTR.First;
  While Not FDuplicatasCTR.Eof Do
  Begin
    If FTipoBaixaCTR = 'A' Then
    Begin
      //Grava MOVBAN
      LBanCtr.pClear;
      LBanCtr.fAdd(FDuplicatasCTR.FieldByName('CTR_NUMDUP').AsString,
                   FDuplicatasCTR.FieldByName('CTR_PARCEL').AsString,
                   FDuplicatasCTR.FieldByName('CTR_ESPDOC').AsString,
                   FDuplicatasCTR.FieldByName('CTR_CODEMP').AsString,
                   FDuplicatasCTR.FieldByName('CTR_CODCLI').AsString,
                   FHistoricoCTR,
                   '',
                   0,
                   FDuplicatasCTR.FieldByName('VALORCORRIGIDO').AsFloat,
                   FDuplicatasCTR.FieldByName('VALORJUROS').AsFloat,
                   LValorDesconto,
                   FDuplicatasCTR.FieldByName('CTR_VALDUP').AsFloat);

      LSequencialMOVBAN := fGravaMovBan(FPlanoDeContasCTR,
                                        FPortadorCTR,
                                        strLoginUsuarioLogado,
                                        VS_Date,
                                        fTime(),
                                        FDuplicatasCTR.FieldByName('CTR_NUMDUP').AsString,
                                        'D',
                                        VS_strCodEmp,
                                        FDuplicatasCTR.FieldByName('VALORCORRIGIDO').AsFloat,
                                        FHistoricoCTR,
                                        '',
                                        FDuplicatasCTR.FieldByName('CTR_CODCLI').AsString,
                                        '',
                                        FDuplicatasCTR.FieldByName('CTR_NUMDUP').AsString,
                                        0,
                                        FDuplicatasCTR.FieldByName('CTR_PARCEL').AsString,
                                        FDuplicatasCTR.FieldByName('CTR_CODEMP').AsString,
                                        '',
                                        '',
                                        '',
                                        LBanCtr.fGetList,
                                        0,
                                        0,
                                        FormatDateTime('mm/yyyy', VS_Date));
    End;

    Result := fBaixaTotal(FDuplicatasCTR.FieldByName('CTR_NUMDUP').AsString,
                          FDuplicatasCTR.FieldByName('CTR_PARCEL').AsString,
                          FDuplicatasCTR.FieldByName('CTR_ESPDOC').AsString,
                          FDuplicatasCTR.FieldByName('CTR_CODEMP').AsString,
                          FDuplicatasCTR.FieldByName('CTR_CODCLI').AsString,
                          FDuplicatasCTR.FieldByName('CTR_VALDUP').AsFloat,
                          FDuplicatasCTR.FieldByName('VALORCORRIGIDO').AsFloat,
                          FDuplicatasCTR.FieldByName('VALORJUROS').AsFloat,
                          LValorDesconto,
                          0.00,
                          0.00,
                          FDuplicatasCTR.FieldByName('VALORCORRIGIDO').AsFloat,
                          0.00,
                          0.00,
                          0.00,
                          VS_Date,
                          LSequencialMOVBAN,
                          FHistoricoCTR,
                          FPlanoDeContasCtr,
                          FPortadorCtr,
                          strLoginUsuarioLogado,
                          StrToInt(FSeqMod),
                          False,
                          False,
                          True,
                          False,
                          False,
                          False,
                          0,
                          FSeqConCTR,
                          VS_Date,
                          FDuplicatasCTR.FieldByName('CTR_RECAUT').AsString,
                          '',
                          '',
                          '',
                          '',
                          False,
                          FDuplicatasCTR.FieldByName('CTR_DESCOB').AsFloat,
                          'S');

    untLogCtr.GravaLogCtr(FDuplicatasCTR.FieldByName('AUTOINCREM').AsString,
                          'BAIXA TOTAL',
                          ANomeFormulario);

    FDuplicatasCTR.Next;
  End;

  FreeAndNil(LBanCtr);
end;

function TAcertoDeContasDeProfissionais.BaixaDuplicatasContasAReceber(
  AFiltrosSelecionados: TCamposFiltroTela; ACodigoCliente,
  ANomeFormulario: String; AValorBaixar: Double; AGravaMOVBAN: Boolean = False): Boolean;
  Var
    LValorBaixa,
    LValorJuros,
    LValorBaixado,
    LValorDesconto,
    LValorRecebido: Double;

    LSequencialMOVBAN,
    LAutoIncremNovaDuplicata: String;

    LSequecialParcial: Integer;

    LNovoValori,
    LNovoValdup,
    LDifOri: Double;

    LDataVencimento: TDateTime;

    LBanCtr: TBanCtrRepository;
begin
  Result := True;

  If AValorBaixar = 0 Then
    Exit;

  FDuplicatasCTR.Filter := 'CTR_VALDUP > 0 AND (BAIXADO=''N'' OR TIPOBAIXA=''P'')';
  FDuplicatasCTR.Filtered := True;

  If FDuplicatasCTR.IsEmpty Then
    Exit;

  If FTipoBaixaCTR <> 'A' Then
    LSequencialMOVBAN := IIF(AGravaMOVBAN, fSeqContaBanco, '');

  LValorBaixado := 0;

  LBanCtr := TBanCtrRepository.Create;

  FDuplicatasCTR.First;
  While Not FDuplicatasCTR.Eof Do
  Begin
    LValorBaixa := FDuplicatasCTR.FieldByName('VALORCORRIGIDO').AsFloat;
    LValorJuros := FDuplicatasCTR.FieldByName('VALORJUROS').AsFloat;
    LValorDesconto := FDuplicatasCTR.FieldByName('VALORDESCONTO').AsFloat;
    If FDuplicatasCTR.FieldByName('TIPOBAIXA').AsString = 'P' Then
    Begin
      LValorBaixa := LValorBaixa - FDuplicatasCTR.FieldByName('VALORBAIXA').AsFloat;
      LValorJuros := 0.00;
      LValorDesconto := 0.00;
    End;

    LValorRecebido := LValorBaixa;
    If fFormataFloat(AValorBaixar, 2) - fFormataFloat(LValorBaixa, 2) < 0 Then
    Begin
      LValorRecebido := AValorBaixar;
      LValorJuros := 0.00;
      LValorDesconto := 0.00;
    End;

    If AGravaMovBan Then
    Begin
      LBanCtr.fAdd(FDuplicatasCTR.FieldByName('CTR_NUMDUP').AsString,
                   FDuplicatasCTR.FieldByName('CTR_PARCEL').AsString,
                   FDuplicatasCTR.FieldByName('CTR_ESPDOC').AsString,
                   FDuplicatasCTR.FieldByName('CTR_CODEMP').AsString,
                   FDuplicatasCTR.FieldByName('CTR_CODCLI').AsString,
                   FHistoricoCTR,
                   '',
                   0,
                   LValorRecebido,
                   LValorJuros,
                   LValorDesconto,
                   FDuplicatasCTR.FieldByName('CTR_VALDUP').AsFloat);

      If  FTipoBaixaCTR = 'A' Then
      Begin
        //Grava MOVBAN
        LSequencialMOVBAN := fGravaMovBan(FPlanoDeContasCTR,
                                          FPortadorCTR,
                                          strLoginUsuarioLogado,
                                          VS_Date,
                                          fTime(),
                                          FDuplicatasCTR.FieldByName('CTR_NUMDUP').AsString,
                                          'C',
                                          VS_strCodEmp,
                                          LValorRecebido,
                                          FHistoricoCTR,
                                          '',
                                          FDuplicatasCTR.FieldByName('CTR_CODCLI').AsString,
                                          '',
                                          FDuplicatasCTR.FieldByName('CTR_NUMDUP').AsString,
                                          0,
                                          FDuplicatasCTR.FieldByName('CTR_PARCEL').AsString,
                                          FDuplicatasCTR.FieldByName('CTR_CODEMP').AsString,
                                          '',
                                          '',
                                          '',
                                          LBanCtr.fGetList,
                                          0,
                                          0,
                                          FormatDateTime('mm/yyyy', VS_Date));

        LBanCtr.pClear;
      End;
    End;

    If fFormataFloat(AValorBaixar, 2) - fFormataFloat(LValorBaixa, 2) >= 0 Then
    Begin
      Result := fBaixaTotal(FDuplicatasCTR.FieldByName('CTR_NUMDUP').AsString,
                            FDuplicatasCTR.FieldByName('CTR_PARCEL').AsString,
                            FDuplicatasCTR.FieldByName('CTR_ESPDOC').AsString,
                            FDuplicatasCTR.FieldByName('CTR_CODEMP').AsString,
                            FDuplicatasCTR.FieldByName('CTR_CODCLI').AsString,
                            FDuplicatasCTR.FieldByName('CTR_VALDUP').AsFloat,
                            LValorBaixa,
                            LValorJuros,
                            LValorDesconto,
                            0.00,
                            0.00,
                            LValorBaixa,
                            0.00,
                            0.00,
                            0.00,
                            VS_Date,
                            LSequencialMOVBAN,
                            FHistoricoCTR,
                            FPlanoDeContasCtr,
                            FPortadorCtr,
                            strLoginUsuarioLogado,
                            StrToInt(FSeqMod),
                            False,
                            False,
                            True,
                            False,
                            False,
                            False,
                            0,
                            FSeqConCTR,
                            VS_Date,
                            FDuplicatasCTR.FieldByName('CTR_RECAUT').AsString,
                            '',
                            '',
                            '',
                            '',
                            False,
                            FDuplicatasCTR.FieldByName('CTR_DESCOB').AsFloat,
                            'S');

      untLogCtr.GravaLogCtr(FDuplicatasCTR.FieldByName('CTR_NUMDUP').AsString,
                            FDuplicatasCTR.FieldByName('CTR_ESPDOC').AsString,
                            FDuplicatasCTR.FieldByName('CTR_CODCLI').AsString,
                            FDuplicatasCTR.FieldByName('CTR_CODEMP').AsString,
                            FDuplicatasCTR.FieldByName('CTR_PARCEL').AsString, 0,
                            'BAIXA TOTAL',
                            ANomeFormulario);

      FDuplicatasCTR.Edit;
      FDuplicatasCTR.FieldByName('BAIXADO').AsString := 'S';
      FDuplicatasCTR.FieldByName('TIPOBAIXA').AsString := 'T';
      FDuplicatasCTR.FieldByName('VALORBAIXA').AsFloat := LValorBaixa;
      FDuplicatasCTR.Post;

      LValorBaixado := LValorBaixado + LValorBaixa;
    End
    Else
    Begin
      LDifOri := RetornaDifOriBaixaParcial(LValorBaixa);

      LDataVencimento := RetornaDataVencimentoBaixaParcial;

      LNovoValDup := FDuplicatasCTR.FieldByName('VALORCORRIGIDO').AsFloat -
                     FDuplicatasCTR.FieldByName('VALORBAIXA').AsFloat -
                     AValorBaixar;

      LNovoValOri := FDuplicatasCTR.FieldByName('CTR_VALDUP').AsFloat;

      Result := fBaixaParcial(FDuplicatasCTR.FieldByName('CTR_NUMDUP').AsString,
                              FDuplicatasCTR.FieldByName('CTR_PARCEL').AsString,
                              FDuplicatasCTR.FieldByName('CTR_CODEMP').AsString,
                              FDuplicatasCTR.FieldByName('CTR_ESPDOC').AsString,
                              FDuplicatasCTR.FieldByName('CTR_CODCLI').AsString,
                              AValorBaixar,
                              LValorJuros,
                              LValorDesconto,
                              VS_Date,
                              LDataVencimento,
                              FPortadorCtr,
                              FHistoricoCTR,
                              FPlanoDeContasCtr,
                              strLoginUsuarioLogado,
                              LSequencialMOVBAN,
                              LNovoValori,
                              LNovoValDup,
                              0.00,
                              0.00,
                              AValorBaixar,
                              0.00,
                              0.00,
                              0.00,
                              0,
                              StrToInt(FSeqMod),
                              False,
                              False,
                              True,
                              False,
                              False,
                              False,
                              LSequecialParcial,
                              LAutoIncremNovaDuplicata,
                              FSeqConCTR,
                              FDuplicatasCTR.FieldByName('CTR_VALIPI').AsFloat,
                              FDuplicatasCTR.FieldByName('CTR_VALRET').AsFloat,
                              FDuplicatasCTR.FieldByName('CTR_VALACE').AsFloat,
                              FDuplicatasCTR.FieldByName('CTR_VALFRE').AsFloat,
                              FDuplicatasCTR.FieldByName('CTR_VALFCP').AsFloat,
                              LDifOri,
                              VS_Date,
                              AValorBaixar,
                              0,
                              1.0000000,
                              0,
                              0,
                              LNovoValori,
                              FDuplicatasCTR.FieldByName('CTR_RECAUT').AsString,
                              '',
                              fGetValOriDuplicata(FDuplicatasCTR.FieldByName('CTR_NUMDUP').AsString,
                                                  FDuplicatasCTR.FieldByName('CTR_ESPDOC').AsString,
                                                  FDuplicatasCTR.FieldByName('CTR_CODEMP').AsString,
                                                  FDuplicatasCTR.FieldByName('CTR_PARCEL').AsString,
                                                  FDuplicatasCTR.FieldByName('CTR_CODCLI').AsString),
                              '',
                              '',
                              '',
                              'N',
                              0,
                              0,
                              FDuplicatasCTR.FieldByName('CTR_VALCBS').AsFloat,
                              FDuplicatasCTR.FieldByName('CTR_VALIBS').AsFloat,
                              FDuplicatasCTR.FieldByName('CTR_VAL_IS').AsFloat);

      untLogCtr.GravaLogCtr(FDuplicatasCTR.FieldByName('CTR_NUMDUP').AsString,
                            FDuplicatasCTR.FieldByName('CTR_ESPDOC').AsString,
                            FDuplicatasCTR.FieldByName('CTR_CODCLI').AsString,
                            FDuplicatasCTR.FieldByName('CTR_CODEMP').AsString,
                            FDuplicatasCTR.FieldByName('CTR_PARCEL').AsString,
                            LSequecialParcial,
                            'BAIXA PARCIAL',
                            ANomeFormulario);

      untLogCtr.GravaLogCtr(LAutoIncremNovaDuplicata,
                            'ALTERAÇÃO DE BAIXA',
                            ANomeFormulario);

      FDuplicatasCTR.Edit;
      FDuplicatasCTR.FieldByName('BAIXADO').AsString := 'S';
      FDuplicatasCTR.FieldByName('TIPOBAIXA').AsString := 'P';
      FDuplicatasCTR.FieldByName('VALORBAIXA').AsFloat := AValorBaixar;
      FDuplicatasCTR.Post;

      LValorBaixado := LValorBaixado + AValorBaixar;

      FDuplicatasCTR.Next;
    End;

    AValorBaixar := AValorBaixar - fFormataFloat(LValorBaixa, 2);

    If AValorBaixar <= 0 Then
      Break;
  End;

  If FTipoBaixaCTR <> 'A' Then
  Begin
    If AGravaMovBan Then
      LSequencialMOVBAN := fGravaMovBan(FPlanoDeContasCTR,
                                        FPortadorCTR,
                                        strLoginUsuarioLogado,
                                        VS_Date,
                                        fTime(),
                                        '',
                                        'C',
                                        VS_strCodEmp,
                                        LValorBaixado,
                                        FHistoricoCTR,
                                        '',
                                        '',
                                        '',
                                        '',
                                        0,
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
                                        LBanCtr.fGetList,
                                        0,
                                        0,
                                        FormatDateTime('mm/yyyy', VS_Date),
                                        '',
                                        LSequencialMOVBAN);
  End;

  FreeAndNil(LBanCtr);
end;

constructor TAcertoDeContasDeProfissionais.Create;
begin
  FTipoBaixaCTR := fCfgSis('CTR_AS');
  FTipoBaixaCTP := fCfgSis('CTP_AS');
  FDescontoAteVencimento := fCfgSis('UTDEFN') = '2';
end;

function TAcertoDeContasDeProfissionais.GravaEBaixaContasAPagar(ACodigoCliente,
  ANomeFormulario: String; AValorComissao: Double): Boolean;
  Var
    LNumeroDuplicata,
    LAutoIncremCadPag,
    LSequencialMOVBAN: String;

    LValorContasAPagar: Double;

    LBanCtp: TBanCtpRepository;
begin
  LNumeroDuplicata := fRetSequencialCadPag;
  LAutoIncremCadPag := fRetAutoIncrem('CADPAG', VS_strCodEmp);

  //Grava MOVBAN
  LBanCtp := TBanCtpRepository.Create;
  LBanCtp.pClear;
  LBanCtp.fAdd(LNumeroDuplicata,
               'A',
               '',
               VS_strCodEmp,
               FDatasetGrid.FieldByName('DIV_CODFOR').AsString,
               FHistoricoCTP,
               '',
               FPlanoDeContasCTP,
               VS_strCodEmp,
               0,
               AValorComissao,
               0,
               0,
               0,
               0,
               0,
               0,
               AValorComissao);

  LSequencialMOVBAN := fGravaMovBan(FPlanoDeContasCTP,
                                    FPortadorCTP,
                                    strLoginUsuarioLogado,
                                    VS_Date,
                                    fTime(),
                                    LNumeroDuplicata,
                                    'D',
                                    VS_strCodEmp,
                                    AValorComissao,
                                    FHistoricoCTP,
                                    '',
                                    '',
                                    FDatasetGrid.FieldByName('DIV_CODFOR').AsString,
                                    LNumeroDuplicata,
                                    0,
                                    'A',
                                    VS_strCodEmp,
                                    '',
                                    FCentroDeCustosCTP,
                                    '',
                                    LBanCtp.fGetList,
                                    0,
                                    FSeqConCTP,
                                    FormatDateTime('mm/yyyy', VS_Date));

  //Grava CADPAG
  Result :=  fGravaCadPag(ANomeFormulario,
                          'INCLUSAO - ACERTO DE CONTAS DE PROFISSIONAIS',
                          FDatasetGrid.FieldByName('DIV_CODFOR').AsString,
                          LNumeroDuplicata,
                          'A',
                          VS_strCodEmp,
                          FPlanoDeContasCTP,
                          '',
                          0,
                          VS_Date,
                          VS_Date,
                          0,
                          AValorComissao,
                          'N',
                          'N',
                          'N',
                          FHistoricoCTP,
                          '',
                          FHistoricoCTP,
                          FPortadorCTP,
                          FPlanoDeContasCTP,
                          LSequencialMOVBAN,
                          strLoginUsuarioLogado,
                          VS_Date,
                          AValorComissao,
                          0,
                          0,
                          VS_strCodEmp,
                          FCentroDeCustosCTP,
                          'N',
                          FPortadorCTP,
                          '',
                          0,
                          0,
                          FSeqConCTP,
                          False,
                          FSeqRcxCTP,
                          '1',
                          0,
                          'N',
                          '',
                          '',
                          '',
                          LAutoIncremCadPag,
                          '',
                          '',
                          '',
                          'N',
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          AValorComissao,
                          0,
                          0,
                          0,
                          '',
                          0,
                          0);

  If Result Then
  Begin
    LValorContasAPagar := AValorComissao;

    FComissoesBaixadas.Last;

    While Not FComissoesBaixadas.Bof Do
    Begin
      LValorContasAPagar := LValorContasAPagar - FComissoesBaixadas.FieldByName('COM_VRCOMI').AsFloat;

      untCadPag.GravarCTPCOM(LNumeroDuplicata,
                             'A',
                             '',
                             FDatasetGrid.FieldByName('DIV_CODFOR').AsString,
                             VS_strCodEmp,
                             FComissoesBaixadas.FieldByName('AUTOINCREM').AsString);

      FComissoesBaixadas.Prior;

      If LValorContasAPagar < 0 Then
        Break;
    End;
  End;

  FreeAndNil(LBanCtp);
end;

procedure TAcertoDeContasDeProfissionais.GravaTabelaDeLogDaBaixa;
  Var
    LGravacao: TUniQuery;

    LSequencialControle: String;
begin
  FDatasetGrid.Filter := 'MARCADO=''S'' ';
  FDatasetGrid.Filtered := True;

  If FDatasetGrid.IsEmpty Then
    Exit;

  LGravacao := fCriaQuery;
  Try
    LGravacao.SQL.Text := 'SELECT * FROM ACECOM_LOG WHERE FALSE';
    LGravacao.Open;

    LSequencialControle := fAtualizaProCod('ACECOM_LOG', 'COM_CODACE', '', 1, Nil,
      function (const AValue : String) : String
      begin
        Result := fRetEmpresaFisica + fPadL(AValue, 17, '0');
      end
    );

    fStartTransaction;

    FDatasetGrid.First;
    While Not FDatasetGrid.Eof Do
    Begin
      LGravacao.Append;
      LGravacao.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ACECOM_LOG', VS_strCodEmp);
      LGravacao.FieldByName('COM_CODACE').AsString := LSequencialControle;

      LGravacao.FieldByName('COM_CODDIV').AsString := FDatasetGrid.FieldByName('DIV_CODDIV').AsString;
      LGravacao.FieldByName('COM_VALCOM').AsFloat := FDatasetGrid.FieldByName('TOTALCOMISSOES').AsFloat;
      LGravacao.FieldByName('COM_NROCOM').AsInteger := FDatasetGrid.FieldByName('QTDECOMISSOES').AsInteger;
      LGravacao.FieldByName('COM_QTDCLI').AsInteger := FDatasetGrid.FieldByName('QTDECLIENTES').AsInteger;
      LGravacao.FieldByName('COM_VALCTR').AsFloat := FDatasetGrid.FieldByName('TOTALCTR').AsFloat;
      LGravacao.FieldByName('COM_SALDO_').AsFloat := FDatasetGrid.FieldByName('SALDOFINAL').AsFloat;
      LGravacao.FieldByName('COM_COMPAG').AsFloat := FDatasetGrid.FieldByName('COMISSAOAPAGAR').AsFloat;
      LGravacao.FieldByName('COM_SEQCTR').AsInteger := FDatasetGrid.FieldByName('SEQCONCTR').AsInteger;
      LGravacao.FieldByName('COM_SEQCTP').AsInteger := FDatasetGrid.FieldByName('SEQCONCTP').AsInteger;

      LGravacao.FieldByName('COM_EMPBAI').AsString := VS_strCodEmp;
      LGravacao.FieldByName('COM_DTABAI').AsDateTime := VS_Date;
      LGravacao.FieldByName('COM_HORBAI').AsDateTime := FHoraBaixaComissao;
      LGravacao.FieldByName('COM_OPEBAI').AsString := strLoginUsuarioLogado;
      LGravacao.Post;

      FDatasetGrid.Next;
    End;

    fCommit;
  Finally
    FreeAndNil(LGravacao);
  End;
end;

function TAcertoDeContasDeProfissionais.RealizarBaixaDosRegistros(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Result := False;

  Try
    FDatasetGrid.Filter := 'MARCADO=''S'' ';
    FDatasetGrid.Filtered := True;

    pgbStatus.Properties.Max := FDatasetGrid.RecordCount;
    pgbStatus.Position := 0;

    FHoraBaixaComissao := fTime();

    FDatasetGrid.First;
    While Not FDatasetGrid.Eof Do
    Begin
      AtualizaDadosSequenciaisBaixa;

      Result := fStartTransaction;

      If Not Result Then
        Raise Exception.Create('Ocorreu um erro ao iniciar a transação da rotina. [TAcertoDeContasDeProfissionais.RealizarBaixaDosRegistros]');

      Result := BaixaComissoesProfissional(FFiltrosSelecionados,
                                           FDatasetGrid.FieldByName('DIV_CODDIV').AsString,
                                           'frmAcertoDeContasDeProfissionais');

      FDatasetGrid.Edit;
      If fFormataFloat(FDatasetGrid.FieldByName('TOTALCTR').AsFloat, 2) > 0 Then
      Begin
        AbreClientDuplicatasCTR(FFiltrosSelecionados,
                                FDatasetGrid.FieldByName('DIV_CODCLI').AsString);

        BaixaCreditosContasAReceber(FFiltrosSelecionados,
                                    FDatasetGrid.FieldByName('DIV_CODCLI').AsString,
                                    'frmAcertoDeContasDeProfissionais');

        BaixaDuplicatasContasAReceber(FFiltrosSelecionados,
                                      FDatasetGrid.FieldByName('DIV_CODCLI').AsString,
                                      'frmAcertoDeContasDeProfissionais',
                                      RetornaValorDeCreditos,
                                      FTipoBaixaCTR = 'A');

        BaixaDuplicatasContasAReceber(FFiltrosSelecionados,
                                      FDatasetGrid.FieldByName('DIV_CODCLI').AsString,
                                      'frmAcertoDeContasDeProfissionais',
                                      FDatasetGrid.FieldByName('TOTALCOMISSOES').AsFloat,
                                      True);

        FDatasetGrid.FieldByName('SEQCONCTR').AsInteger := FSeqConCTR;
      End;

      If fFormataFloat(FDatasetGrid.FieldByName('COMISSAOAPAGAR').AsFloat, 2) > 0 Then
      Begin
        Result := GravaEBaixaContasAPagar(FDatasetGrid.FieldByName('DIV_CODCLI').AsString,
                                          'frmAcertoDeContasDeProfissionais',
                                          FDatasetGrid.FieldByName('COMISSAOAPAGAR').AsFloat);

        FDatasetGrid.FieldByName('SEQCONCTP').AsInteger := FSeqConCTP;
      End;
      FDatasetGrid.Post;

      If Not Result Then
        Raise ExceptionAutcom.Create('Não foi possível realizar a baixa da comissão do profissional ' +  FDatasetGrid.FieldByName('DIV_CODDIV').AsString + '.' +
                                     ' - [TAcertoDeContasDeProfissionais.RealizarBaixaDosRegistros]');

      pStepStatusGravacao(pgbStatus, '');

      Result := fCommit;

      FDatasetGrid.Next;
    End;

    GravaTabelaDeLogDaBaixa;
  Except
    On E: Exception Do
    Begin
      fRollback;

      Raise Exception.Create(E.Message);
    End;

    On E: ExceptionAutcom Do
    Begin
      fRollback;

      Raise ExceptionAutcom.Create(E.Message);
    End;
  End;
end;

procedure TAcertoDeContasDeProfissionais.RecalcularJuros;
begin
  If FTodasAsComissoes Then
    FDatasetGrid.First;

  While Not FDatasetGrid.Eof Do
  Begin
    AbreClientDuplicatasCTR(FFiltrosSelecionados,
                            FDatasetGrid.FieldByName('DIV_CODCLI').AsString);

    FDatasetGrid.Edit;
    FDatasetGrid.FieldByName('TOTALCTR').AsFloat := RetonaValorTotalCTR(True);

    FDatasetGrid.FieldByName('PERCENTUALJUROS').AsFloat := FPercentualJuros;
    FDatasetGrid.FieldByName('PERCENTUALMULTA').AsFloat := FPercentualMulta;

    FDatasetGrid.FieldByName('SALDOFINAL').AsFloat := FDatasetGrid.FieldByName('TOTALCOMISSOES').AsFloat -
                                                      FDatasetGrid.FieldByName('TOTALCTR').AsFloat;

    FDatasetGrid.FieldByName('COMISSAOAPAGAR').AsFloat := FDatasetGrid.FieldByName('TOTALCOMISSOES').AsFloat;
    If FDatasetGrid.FieldByName('TOTALCTR').AsFloat > 0 Then
      FDatasetGrid.FieldByName('COMISSAOAPAGAR').AsFloat := FDatasetGrid.FieldByName('COMISSAOAPAGAR').AsFloat -
                                                            FDatasetGrid.FieldByName('TOTALCTR').AsFloat;

    If FDatasetGrid.FieldByName('COMISSAOAPAGAR').AsFloat < 0 Then
      FDatasetGrid.FieldByName('COMISSAOAPAGAR').AsFloat := 0;

    FDatasetGrid.Post;

    If Not FTodasAsComissoes Then
      Exit;

    FDatasetGrid.Next;
  End;
end;

function TAcertoDeContasDeProfissionais.RetonaValorTotalCTR(ASomaNegativos: Boolean): Double;
begin
  Result := 0.00;

  FDuplicatasCTR.First;
  While Not FDuplicatasCTR.Eof Do
  Begin
    If Not ASomaNegativos Then
    Begin
      If FDuplicatasCTR.FieldByName('VALORDUPLICATA').AsFloat < 0 Then
      Begin
        FDuplicatasCTR.Next;

        Continue;
      End;
    End;

    Result := Result + FDuplicatasCTR.FieldByName('VALORCORRIGIDO').AsFloat;

    FDuplicatasCTR.Next;
  End;

end;

function TAcertoDeContasDeProfissionais.RetornaCampoVendedorVenda: String;
begin
  Result := '(SELECT CONCAT(O.OPE_CODOPE, "-", O.OPE_NOMOPE) '+
            'FROM CADREC C ' +
            'LEFT JOIN CADOPE O ON O.OPE_CODOPE=C.CTR_CODVEN ' +
            'WHERE C.CTR_NUMDUP=R.COM_NUMDOC ' +
            '  AND C.CTR_ESPDOC=R.COM_ESPDOC ' +
            '  AND C.CTR_CODEMP=R.COM_CODEMP ' +
            '  AND C.CTR_CODCLI=R.COM_CODCLI ' +
            'LIMIT 1) AS VENDEDOR ';
end;

function TAcertoDeContasDeProfissionais.RetornaDadosComissoesEmAberto(
  AFiltrosSelecionados: TCamposFiltroTela; ACodigoProfissional: String): TUniClientDataset;
  Var
    LSQL: String;

    LConsulta: TUniQuery;
begin
  LSQL := 'SELECT ';
  LSQL := LSQL + '  R.COM_CODCOM, ';
  LSQL := LSQL + '  R.COM_DTACAD, ';
  LSQL := LSQL + '  R.COM_CREDEB, ';
  LSQL := LSQL + '  CONCAT(R.COM_NUMDOC, "-", R.COM_ESPDOC, "-", R.COM_CODEMP) AS CONTASARECEBER, ';
  LSQL := LSQL + '  R.COM_VRVEND, ';
  LSQL := LSQL + ' (IF(R.COM_CREDEB = "C", R.COM_VRCOMI, R.COM_VRCOMI * (-1))) AS COM_VRCOMI, ';

  LSQL := LSQL + '  C.CLI_NOMCLI, ';
  LSQL := LSQL + '  R.AUTOINCREM, ';
  LSQL := LSQl + RetornaCampoVendedorVenda;
  LSQL := LSQL + 'FROM      ';
  LSQL := LSQL + '  COMPRO R ';
  LSQL := LSQL + '  LEFT JOIN CADCLI C ON C.CLI_CODCLI = R.COM_CODCLI ';
  LSQL := LSQL + '  LEFT JOIN CADDIV D ON D.DIV_CODDIV = R.COM_CODPRO ';
  LSQL := LSQL + 'WHERE     ';

  LSQL := LSQL + '  R.COM_DTABAI IS NULL AND  ';
  LSQL := LSQL + '  R.COM_CODPRO = "' + ACodigoProfissional + '"  ';

  LSQL := LSQL + RetornaFiltrosDaTela(AFiltrosSelecionados);

  LSQL := LSQL  + ' AND IF(IFNULL(R.COM_TCOPRO, "") = "", "' + fCfgSis('TCOPRO') +
                                       '", R.COM_TCOPRO) = "' + fCfgSis('TCOPRO') + '" ';

  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
    Result.First;

  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TAcertoDeContasDeProfissionais.RetornaDadosFiltradosComissoes(
  AFiltrosSelecionados: TCamposFiltroTela; ACarregaVazio: Boolean = False): TUniClientDataset;
  Var
    LSQL: String;

    LConsulta: TUniQuery;
begin
  LSQL := 'SELECT D.DIV_CODDIV, ' +
          '       D.DIV_NOMDIV, ' +
          '       D.DIV_CODCLI, ' +
          '       D.DIV_CODFOR, ' +
          '       SUM(IF(R.COM_CREDEB = "C", R.COM_VRCOMI, R.COM_VRCOMI * (-1))) AS TOTALCOMISSOES, ' +
          '       COUNT(R.AUTOINCREM) AS QTDECOMISSOES, ' +
          '       COUNT(DISTINCT R.COM_CODCLI) AS QTDECLIENTES, ' +
          '       0.00 AS TOTALCTR, ' +
          '       0.00 AS SALDOFINAL, ' +
          '       0.00 AS COMISSAOAPAGAR, ' +
          '          0 AS QTDMARCADO, ' +
          '       0.00 AS COMISSAOMARCADO, ' +
          '       0.00 AS CTRMARCADO, ' +
          '       0.00 AS PAGARCARCADO, ' +
          '          0 AS SEQCONCTR, ' +
          '          0 AS SEQCONCTP, ' +
          '       "D" AS MARCADO, ' +
          '       0.00 AS PERCENTUALJUROS, ' +
          '       0.00 AS PERCENTUALMULTA ' +

          'FROM CADDIV D ' +
          'LEFT JOIN COMPRO R ON ' +
          '        R.COM_CODPRO=D.DIV_CODDIV ';


  If ACarregaVazio Then
    LSQL := LSQL + 'WHERE FALSE '
  Else
  Begin
    LSQL := LSQL + 'WHERE R.COM_DTABAI IS NULL ';

    LSQL := LSQL + RetornaFiltrosDaTela(AFiltrosSelecionados);
  End;

  LSQL := LSQL + 'GROUP BY D.DIV_CODDIV, ' +
                 '         D.DIV_NOMDIV  ' +
                 'HAVING SUM(R.COM_VRCOMI) <> 0.00 ';

  Try
    FPercentualJuros := fCfgSis('JURATR', varDouble);
    FPercentualMulta := fCfgSis('MULATR', varDouble);

    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);

    TFloatField(Result.FieldByName('TOTALCOMISSOES')).DisplayFormat := ',0.00;-,0.00';
    TFloatField(Result.FieldByName('TOTALCTR')).DisplayFormat := ',0.00;-,0.00';

    Result.First;
    While Not Result.Eof Do
    Begin
      AbreClientDuplicatasCTR(AFiltrosSelecionados,
                              Result.FieldByName('DIV_CODCLI').AsString);

      Result.Edit;
      Result.FieldByName('TOTALCTR').AsFloat := RetonaValorTotalCTR(True);

      Result.FieldByName('PERCENTUALJUROS').AsFloat := FPercentualJuros;
      Result.FieldByName('PERCENTUALMULTA').AsFloat := FPercentualMulta;

      Result.FieldByName('SALDOFINAL').AsFloat := Result.FieldByName('TOTALCOMISSOES').AsFloat -
                                                  Result.FieldByName('TOTALCTR').AsFloat;

      Result.FieldByName('COMISSAOAPAGAR').AsFloat := Result.FieldByName('TOTALCOMISSOES').AsFloat;
      If Result.FieldByName('TOTALCTR').AsFloat > 0 Then
        Result.FieldByName('COMISSAOAPAGAR').AsFloat := Result.FieldByName('COMISSAOAPAGAR').AsFloat -
                                                        Result.FieldByName('TOTALCTR').AsFloat;

      If Result.FieldByName('COMISSAOAPAGAR').AsFloat < 0 Then
        Result.FieldByName('COMISSAOAPAGAR').AsFloat := 0;

      Result.Post;

      If AFiltrosSelecionados.ComissaoAPagar <> 0 Then
      Begin
        If Result.FieldByName('COMISSAOAPAGAR').AsFloat < AFiltrosSelecionados.ComissaoAPagar Then
        Begin
          Result.Delete;
          Continue;
        End;
      End;

      Result.Next;
    End;

    Result.First;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TAcertoDeContasDeProfissionais.RetornaDataVencimentoBaixaParcial: TDateTime;
begin
  Result := VS_Date;

  If (FDuplicatasCTR.FieldByName('CTR_DTAVEN').AsDateTime > VS_Date) Then
    Result := FDuplicatasCTR.FieldByName('CTR_DTAVEN').AsDateTime
  Else If (FDuplicatasCTR.FieldByName('CTR_VALDUP').AsFloat = FDuplicatasCTR.FieldByName('VALORCORRIGIDO').AsFloat) Then
  Begin
    If (fCfgSis('MANVEN') = 'S') Then
      Result := FDuplicatasCTR.FieldByName('CTR_DTAVEN').AsDateTime;
  End;
end;

function TAcertoDeContasDeProfissionais.RetornaDifOriBaixaParcial(
  AValorBaixa: Double): Double;
begin
  Result := AValorBaixa;

  If fCfgSis('UTDEFN') = '2' Then
  Begin
    If (VS_Date <= FDuplicatasCTR.FieldByName('CTR_DTAVEN').AsDateTime +
                   FDuplicatasCTR.FieldByName('CTR_QTDDAV').AsInteger) Then
      Result := Result - (FDuplicatasCTR.FieldByName('CTR_VALDUP').AsFloat +
                          FDuplicatasCTR.FieldByName('CTR_JURSUJ').AsFloat +
                          FDuplicatasCTR.FieldByName('CTR_DESCOB').AsFloat -
                          FDuplicatasCTR.FieldByName('CTR_DESSUJ').AsFloat)
    Else
      Result := Result - (FDuplicatasCTR.FieldByName('CTR_VALDUP').AsFloat +
                          FDuplicatasCTR.FieldByName('CTR_JURSUJ').AsFloat +
                          FDuplicatasCTR.FieldByName('CTR_DESCOB').AsFloat );
  End
  Else
    Result := Result - (FDuplicatasCTR.FieldByName('CTR_VALDUP').AsFloat +
                        FDuplicatasCTR.FieldByName('CTR_JURSUJ').AsFloat +
                        FDuplicatasCTR.FieldByName('CTR_DESCOB').AsFloat -
                        FDuplicatasCTR.FieldByName('CTR_DESSUJ').AsFloat);

  If AValorBaixa < 0 Then
    Result := 0;
end;

function TAcertoDeContasDeProfissionais.RetornaFiltrosDaTela(
  AFiltrosSelecionados: TCamposFiltroTela): String;
begin
  Result := ' AND R.COM_DTACAD BETWEEN "' + FormatDateTime('yyyy/mm/dd', AFiltrosSelecionados.DataInicial) + '" ' +
            '                      AND "' + FormatDateTime('yyyy/mm/dd', AFiltrosSelecionados.DataFinal) + '" ';

  If Not AFiltrosSelecionados.CodigoEmpresa.IsEmpty Then
    Result := Result + ' AND R.COM_CODEMP IN (' + AFiltrosSelecionados.CodigoEmpresa + ') ';

  If Not AFiltrosSelecionados.CodigoProfissional.IsEmpty Then
    Result := Result + ' AND D.DIV_CODDIV IN (' + AFiltrosSelecionados.CodigoProfissional + ') ';

  If MatchStr(AFiltrosSelecionados.ProfissionaisComCartao, ['S', 'N']) Then
    Result := Result + ' AND D.DIV_CARPRO="' + AFiltrosSelecionados.ProfissionaisComCartao + '" ';
end;

function TAcertoDeContasDeProfissionais.RetornaValorDeCreditos: Double;
begin
  FDuplicatasCTR.Filter := 'CTR_VALDUP < 0';
  FDuplicatasCTR.Filtered := True;

  Result := 0.00;

  FDuplicatasCTR.First;
  While Not FDuplicatasCTR.Eof Do
  Begin
    Result := Result  + fFormataFloat(FDuplicatasCTR.FieldByName('CTR_VALDUP').AsFloat, 2);

    FDuplicatasCTR.Next;
  End;

  Result := Abs(Result);
end;

function TAcertoDeContasDeProfissionais.RetornaValorDoDesconto: Double;
begin
  If FDescontoAteVencimento Then
  Begin
    Result := 0.00;
    If VS_Date <= FDuplicatasCTR.FieldByName('CTR_DTAVEN').asDateTime Then
      Result := FDuplicatasCTR.FieldByName('CTR_DESSUJ').AsFloat;
  End
  Else
    Result := FDuplicatasCTR.FieldByName('CTR_DESSUJ').AsFloat;
end;

procedure TAcertoDeContasDeProfissionais.RetornaValoresDuplicata(
  out AValorJuros, AValorDesconto, AValorCorrigido: Double);
  Var
    LValorCorrigido,
    LJuros,
    LDescontoPontualidade: Double;
begin
  LDescontoPontualidade := 0.00;

  LJuros := fCalculaJurosCadCtr(FDuplicatasCTR.FieldByName('CTR_DTAVEN').AsDateTime,
                                FDuplicatasCTR.FieldByName('VALORDUPLICATA').AsFloat,
                                FPercentualJuros,
                                FPercentualMulta);

  LValorCorrigido := FDuplicatasCTR.FieldByName('VALORDUPLICATA').AsFloat + LJuros;

  If FDuplicatasCTR.FieldByName('CTR_ESPDOC').AsString <> 'CC' Then
  Begin
    IF LJuros <= 0 Then
    begin
      If (fCfgSis('DESPON', varBoolean)) Then
      Begin
        if (FDescontoAteVencimento) then
        begin
          If (VS_Date <= (FDuplicatasCTR.FieldByName('CTR_DTAVEN').asDateTime + FDuplicatasCTR.FieldByName('CTR_QTDDAV').AsInteger)) Then
            LDescontoPontualidade  := fFormataFloat(LValorCorrigido * ( FDuplicatasCTR.FieldByName('CTR_PERDPO').AsFloat / 100.00 ),2);
        end
        else If (VS_Date <= (FDuplicatasCTR.FieldByName('CTR_DTAVEN').asDateTime - FDuplicatasCTR.FieldByName('CTR_QTDDAV').AsInteger)) Then
          LDescontoPontualidade  := fFormataFloat(LValorCorrigido * ( FDuplicatasCTR.FieldByName('CTR_PERDPO').AsFloat / 100.00 ),2);

        if LDescontoPontualidade > 0 then
          LValorCorrigido := LValorCorrigido - LDescontoPontualidade;
      end;
    End;
  End
  Else
    LValorCorrigido := LValorCorrigido - LJuros;

  AValorJuros := LJuros + FDuplicatasCTR.FieldByName('CTR_JURSUJ').AsFloat;

  AValorDesconto := LDescontoPontualidade;

  AValorDesconto := AValorDesconto + RetornaValorDoDesconto;

  AValorCorrigido := LValorCorrigido;

end;

end.
