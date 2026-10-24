{******************************************************************************}
{* OS MÉTODOS DESSA CLASSE DEVEM SER EXECUTADOS PELA CLASSE TControleCashback *}
{* DA UNIT Cashback.Controle                                                  *}
{**************************************************************************WL**}

unit Cashback.Calculo;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  UniClientDataSet, untFuncoesSimples,
{$ENDIF}
  System.Classes, System.SysUtils, System.StrUtils, System.DateUtils, Uni,
  Data.DB, Cashback.Classes, System.Generics.Collections;

type
  TRegraCalculoCashback = class
  strict private
    FcdsCashback           : TUniClientDataSet;
    FcdsItensVendaCashback : TUniClientDataSet;
    FObjVendaCashback      : TVendaCashback;
    FTiposCashback         : TTipoCashback;
    FSimulacaoPedido       : Boolean;
    FstrOrigem             : String;

    procedure SetObjVendaCashback(const Value: TVendaCashback);
    procedure SetcdsCashback(const Value: TUniClientDataSet);
    procedure SetcdsItensVendaCashback(const Value: TUniClientDataSet);
    procedure SetSimulacaoPedido(const Value: Boolean);
    procedure SetstrOrigem(const Value: String);

  strict protected
    procedure pDistruibuirProporcaoCashbackItens;
    function fRetornaGeracaoResumoCalculo: String; virtual; abstract;

    property TiposCashback : TTipoCashback read FTiposCashback;

  public
    constructor Create;
    destructor Destroy; override;

    function fRetornaResumoCalculo: String;
    procedure pCalcularCashback; virtual; abstract;

    property objVendaCashback      : TVendaCashback    read FObjVendaCashback      write SetObjVendaCashback;
    property cdsCashback           : TUniClientDataSet read FcdsCashback           write SetcdsCashback;
    property cdsItensVendaCashback : TUniClientDataSet read FcdsItensVendaCashback write SetcdsItensVendaCashback;
    property blnSimulacaoPedido    : Boolean           read FSimulacaoPedido       write SetSimulacaoPedido;
    property strOrigem             : String            read FstrOrigem             write SetstrOrigem;
  end;

  TRegraCalculoCashbackValorFixoVenda = class(TRegraCalculoCashback)
  strict protected
    function fRetornaGeracaoResumoCalculo: String; override;
  public
    procedure pCalcularCashback; override;
  end;

  TRegraCalculoCashbackPercentualVenda = class(TRegraCalculoCashback)
  strict protected
    function fRetornaGeracaoResumoCalculo: String; override;
  public
    procedure pCalcularCashback; override;
  end;

  TRegraCalculoCashbackAcumuloVenda = class(TRegraCalculoCashback)
  strict protected
    function fRetornaGeracaoResumoCalculo: String; override;
  public
    procedure pCalcularCashback; override;
  end;

  TRegraCalculoCashbackPercentualItem = class(TRegraCalculoCashback)
  strict protected
    function fRetornaGeracaoResumoCalculo: String; override;
  public
    procedure pCalcularCashback; override;
  end;

  TRegraCalculoCashbackValorFixoItem = class(TRegraCalculoCashback)
  strict protected
    function fRetornaGeracaoResumoCalculo: String; override;
  public
    procedure pCalcularCashback; override;
  end;

  TRegraCalculoCashbackDevolucaoEmbalagem = class(TRegraCalculoCashback)
  strict protected
    function fRetornaGeracaoResumoCalculo: String; override;
  public
    procedure pCalcularCashback; override;
  end;

  TProcesssaRegraCashback = class sealed
  strict private
    FcdsCashback           : TUniClientDataSet;
    FcdsItensVendaCashback : TUniClientDataSet;
    FlstVendaCashback      : TList<TVendaCashback>;
    FblnPermiteGravar      : Boolean;
    FblnSilenciarAvisos    : Boolean;
    FblnOcorreuErro        : Boolean;
    FSimulacaoPedido       : Boolean;
    FstrNumDoc             : String;
    FstrEspDoc             : String;
    FstrCodEmp             : String;
    FstrCodCli             : String;
    FstrCodCnd             : String;
    FstrCodVen             : String;
    FstrCodOpe             : String;
    FstrOrigem             : String;
    FfltQtdEmb             : Double;
    FstrFonCli             : String;
    FstrCgcCpf             : String;
    FstrCpfCli             : String;

    FcdsItens              : TUniClientDataSet;
    FblnUtilizouCashback   : Boolean;

    procedure SetblnSilenciarAvisos(const Value: Boolean);
    procedure SetSimulacaoPedido(const Value: Boolean);
    procedure SetCodEmp(const Value: String);
    procedure SetEspDoc(const Value: String);
    procedure SetNumDoc(const Value: String);
    procedure SetCodCli(const Value: String);
    procedure SetCodCnd(const Value: String);
    procedure SetCodVen(const Value: String);
    procedure SetCodOpe(const Value: String);
    procedure SetOrigem(const Value: String);
    procedure SetQtdEmb(const Value: Double);
    procedure SetFonCli(const Value: String);
    procedure SetCgcCpf(const Value: String);
    procedure SetCpfCli(const Value: String);

    procedure SetCdsItens(const Value: TUniClientDataSet);
    procedure SetUtilizouCashback(const Value: Boolean);

  strict private
    procedure pAdicionaCamposDataSetVenda(const qryConsulta: TUniQuery);

    function fEhRegraValidaParaVenda(const blnRegra: Boolean): Boolean;

    procedure pCarregaVenda;
    procedure pCarregaItensVenda; overload;
    procedure pCarregaItensVenda(const strCodCsh: String); overload;

    procedure pCarregaSimulacaoVenda;
    procedure pCarregaSimulacaoItensVenda(const blnEhRegraItens: Boolean;
      const strCodCsh: String);

    function fExecutaRegraCashback(
      const objCalculoCashback: TRegraCalculoCashback): Boolean;

    function fExisteCondicaoPagamentoRegraCashback(const strCodCsh,
      strCodCnd: String): Boolean;

    function fExisteCanalAcessoRegraCashback(const strCodCsh,
      strCodCac: String): Boolean;

    function fExisteDepartamentoRegraCashback(const strCodCsh,
      strCodVen: String): Boolean;

    function fValidaRegrasProcessamentoCashback: Boolean;

  public
    constructor Create;
    destructor Destroy; override;

    procedure pProcessarCashback;

    property lstVendaCashback    : TList<TVendaCashback> read FlstVendaCashback;
    property blnSilenciarAvisos  : Boolean                                      write SetblnSilenciarAvisos;
    property blnPermiteGravar    : Boolean               read FblnPermiteGravar;
    property blnOcorreuErro      : Boolean               read FblnOcorreuErro;
    property blnSimulacaoPedido  : Boolean                                      write SetSimulacaoPedido;
    property strNumDoc           : String                                       write SetNumDoc;
    property strEspDoc           : String                                       write SetEspDoc;
    property strCodEmp           : String                                       write SetCodEmp;
    property strCodCli           : String                                       write SetCodCli;
    property strCodCnd           : String                                       write SetCodCnd;
    property strCodVen           : String                                       write SetCodVen;
    property strCodOpe           : String                                       write SetCodOpe;
    property strOrigem           : String                                       write SetOrigem;
    property fltQtdEmb           : Double                                       write SetQtdEmb;
    property strFonCli           : String                                       write SetFonCli;
    property strCgcCpf           : String                                       write SetCgcCpf;
    property strCpfCli           : String                                       write SetCpfCli;
    property cdsItens            : TUniClientDataSet                            write SetCdsItens;
    property blnUtilizouCashback : Boolean                                      write SetUtilizouCashback;
  end;

implementation

const
  BASE_TEXTO_RESUMO = '[VIGENCIA: %s]'+#13#10
                    + '[GERAÇÃO: %s]'+#13#10
                    + '[UTILIZAÇÃO: %s]'+#13#10
                    + '[VALIDADE: %s]';

{ TProcesssaRegraCashback }

constructor TProcesssaRegraCashback.Create;
begin
  FcdsCashback           := TUniClientDataSet.Create(Nil);
  FcdsItensVendaCashback := TUniClientDataSet.Create(Nil);
  FlstVendaCashback      := TList<TVendaCashback>.Create;
  FblnPermiteGravar      := False;
  FblnSilenciarAvisos    := False;
  FblnOcorreuErro        := False;
  FSimulacaoPedido       := False;
end;

destructor TProcesssaRegraCashback.Destroy;
begin
  FreeAndNil(FcdsCashback);
  FreeAndNil(FcdsItensVendaCashback);
  FreeAndNil(FlstVendaCashback);
  inherited;
end;

procedure TProcesssaRegraCashback.pProcessarCashback;
var
  objCalculoCashback : TRegraCalculoCashback;
  blnEhRegraItens    : Boolean;
begin
  FblnPermiteGravar  := False;
  FblnOcorreuErro    := False;
  blnEhRegraItens    := False;
  objCalculoCashback := nil;

  If FSimulacaoPedido Then
  Begin
    If (Not Assigned(FcdsItens)) Or
       (fEmptyStr(FstrCodCli)) Then
    Begin
      raise Exception.Create('Não foi possível executar o cálculo do cashback. Contate a Citel.');
      Exit;
    End
    Else
      pCarregaSimulacaoVenda;
  End
  Else
    pCarregaVenda;

  If Not fValidaRegrasProcessamentoCashback Then
    Exit;

  FcdsCashback.First;
  While Not FcdsCashback.Eof Do
  Begin
    Try
      If FcdsCashback.FieldByName('CSH_TIPCSH').AsString = 'VF' Then
        objCalculoCashback := TRegraCalculoCashbackValorFixoVenda.Create
      Else
      If FcdsCashback.FieldByName('CSH_TIPCSH').AsString = 'PD' Then
        objCalculoCashback := TRegraCalculoCashbackPercentualVenda.Create
      Else
      If FcdsCashback.FieldByName('CSH_TIPCSH').AsString = 'VC' Then
        objCalculoCashback := TRegraCalculoCashbackAcumuloVenda.Create
      Else
      If FcdsCashback.FieldByName('CSH_TIPCSH').AsString = 'DE' Then
        objCalculoCashback := TRegraCalculoCashbackDevolucaoEmbalagem.Create
      Else
      If FcdsCashback.FieldByName('CSH_TIPCSH').AsString = 'PI' Then
      Begin
        objCalculoCashback := TRegraCalculoCashbackPercentualItem.Create;
        blnEhRegraItens    := True;
      End
      Else
      If FcdsCashback.FieldByName('CSH_TIPCSH').AsString = 'VI' Then
      Begin
        objCalculoCashback := TRegraCalculoCashbackValorFixoItem.Create;
        blnEhRegraItens    := True;
      End
      Else
      Begin
        fEhRegraValidaParaVenda(False);
        Exit;
      End;

      objCalculoCashback.blnSimulacaoPedido := FSimulacaoPedido;
      objCalculoCashback.strOrigem          := FstrOrigem;

      If FSimulacaoPedido Then
        pCarregaSimulacaoItensVenda(blnEhRegraItens, FcdsCashback.FieldByName('CSH_CODIGO').AsString)
      Else
      Begin
        If blnEhRegraItens Then
          pCarregaItensVenda(FcdsCashback.FieldByName('CSH_CODIGO').AsString)
        Else
          pCarregaItensVenda;
      End;

      FlstVendaCashback.Add(TVendaCashback.Create);
      objCalculoCashback.objVendaCashback      := FlstVendaCashback.Items[Pred(FlstVendaCashback.Count)];
      objCalculoCashback.cdsCashback           := FcdsCashback;
      objCalculoCashback.cdsItensVendaCashback := FcdsItensVendaCashback;

      If (blnEhRegraItens) And
         (FcdsItensVendaCashback.RecordCount = 0) Then
        Exit;

      If (Not fExecutaRegraCashback(objCalculoCashback)) Then
        Exit;
    Finally
      If Assigned(objCalculoCashback) Then
        FreeAndNil(objCalculoCashback);
    End;

    FcdsCashback.Next;
  End;

  If Not FSimulacaoPedido Then
    FblnPermiteGravar := True;
end;

procedure TProcesssaRegraCashback.pAdicionaCamposDataSetVenda(
  const qryConsulta: TUniQuery);

  procedure pAdicionarCampo(const strNomeCampo: String;
    const typTipoCampo: TFieldType; const intTamanho: Integer=0);
  begin
    With FcdsCashback.FieldDefs.AddFieldDef Do
    Begin
      Name     := strNomeCampo;
      DataType := typTipoCampo;
      Size     := intTamanho;
      Required := False;
    End;
  end;
begin
  FcdsCashback.FieldDefs.Assign(qryConsulta.FieldDefs);

  pAdicionarCampo('EXISTE_CASHBACK_UTILIZADO', ftString, 1);
  pAdicionarCampo('EXISTE_CRITERIO_ITEM',      ftString, 1);
  pAdicionarCampo('CODCND',                    ftString, 3);
  pAdicionarCampo('CODVEN',                    ftString, 3);
  pAdicionarCampo('CODCLI',                    ftString, 8);
  pAdicionarCampo('AUTINC',                    ftString, 20);
  pAdicionarCampo('NUMDOC',                    ftString, 12);
  pAdicionarCampo('ESPDOC',                    ftString, 2);
  pAdicionarCampo('CODEMP',                    ftString, 3);
  pAdicionarCampo('VLRCON',                    ftFloat);
  pAdicionarCampo('ITE_VLRCON_TOTAL',          ftFloat);
  pAdicionarCampo('DTAENT',                    ftDateTime);
end;

procedure TProcesssaRegraCashback.pCarregaItensVenda(const strCodCsh: String);
var
  qryConsulta : TUniQuery;
begin
  If FstrOrigem = 'E' Then
    Exit;

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Text := 'SELECT '
                          + '       D.AUTOINCREM AS AUTINC '
                          + '     , D.DET_QTDITE AS QTDITE '
                          + '     , D.DET_VLRCON AS VLRCON '
                          + '  FROM MOVDET D '
                          + ' INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER '
                          + ' WHERE G.GER_NUMDOC = :NUMDOC '
                          + '   AND G.GER_ESPDOC = :ESPDOC '
                          + '   AND G.GER_CODEMP = :CODEMP '
                          + '   AND EXISTS(SELECT I.AUTOINCREM FROM ITECSH I '
                          + '               INNER JOIN CADCSH B ON B.AUTOINCREM = I.CSH_SEQCSH '
                          + '               WHERE I.CSH_CODITE = D.DET_CODITE '
                          + '                 AND B.CSH_CODIGO = :CODCSH) ';

    qryConsulta.ParamByName('NUMDOC').AsString := FstrNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := FstrEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := FstrCodEmp;
    qryConsulta.ParamByName('CODCSH').AsString := strCodCsh;
    qryConsulta.Open;

    FcdsItensVendaCashback.FieldDefs.Assign(qryConsulta.FieldDefs);
    If Not FcdsItensVendaCashback.Active Then
      FcdsItensVendaCashback.CreateDataSet;

    FcdsItensVendaCashback.EmptyDataSet;

    qryConsulta.First;
    While Not qryConsulta.Eof Do
    Begin
      pCopiaRegistroDataSet(qryConsulta, FcdsItensVendaCashback, False, False, True);
      qryConsulta.Next;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TProcesssaRegraCashback.pCarregaSimulacaoItensVenda(
  const blnEhRegraItens: Boolean; const strCodCsh: String);
var
  qryItensCashback : TUniQuery;
begin
  If FstrOrigem = 'E' Then
    Exit;

  qryItensCashback := fCriaQuery;
  Try
    qryItensCashback.Close;
    qryItensCashback.SQL.Text := 'SELECT '
                               + '       AUTOINCREM AS AUTINC '
                               + '     , FDO_QTDITE AS QTDITE '
                               + '     , FDO_VLRCON AS VLRCON '
                               + '  FROM FATDOR '
                               + ' WHERE FALSE ';
    qryItensCashback.Open;

    FcdsItensVendaCashback.FieldDefs.Assign(qryItensCashback.FieldDefs);
    If Not FcdsItensVendaCashback.Active Then
      FcdsItensVendaCashback.CreateDataSet;

    FcdsItensVendaCashback.EmptyDataSet;

    If blnEhRegraItens Then
    Begin
      qryItensCashback.Close;
      qryItensCashback.SQL.Text := 'SELECT CSH_CODITE FROM ITECSH '
                                 + ' INNER JOIN CADCSH ON CADCSH.AUTOINCREM = ITECSH.CSH_SEQCSH '
                                 + ' WHERE CADCSH.CSH_CODIGO = :CODCSH ';

      qryItensCashback.ParamByName('CODCSH').AsString := strCodCsh;
      qryItensCashback.Open;
    End;

    FcdsItens.First;
    While Not FcdsItens.Eof Do
    Begin
      If blnEhRegraItens Then
      Begin
        If Not qryItensCashback.Locate('CSH_CODITE', FcdsItens.FieldByName('ITE_CODITE').AsString, []) Then
        Begin
          FcdsItens.Next;
          Continue;
        End;
      End;

      FcdsItensVendaCashback.Append;
      FcdsItensVendaCashback.FieldByName('QTDITE').AsFloat := FcdsItens.FieldByName('ITE_QTDITE').AsFloat;
      FcdsItensVendaCashback.FieldByName('VLRCON').AsFloat := FcdsItens.FieldByName('ITE_VLRCON').AsFloat;
      FcdsItensVendaCashback.Post;

      FcdsItens.Next;
    End;
  Finally
    FreeAndNil(qryItensCashback);
  End;
end;

procedure TProcesssaRegraCashback.pCarregaSimulacaoVenda;
var
  fltValorBaseCashback,
  fltValorTotalItensCashBack : Double;
  qryConsulta                : TUniQuery;

  procedure somaItensVendaCashBack;
  var
    qryItensCashback: TUniQuery;
  begin
    qryItensCashback := fCriaQuery;
    Try
      qryItensCashback.Close;
      qryItensCashback.SQL.Text := 'SELECT * FROM ITECSH '
                                 + ' WHERE CSH_SEQCSH = :AUTINC ';
      qryItensCashback.ParamByName('AUTINC').AsString := FcdsCashback.FieldByName('AUTOINCREM').AsString;
      qryItensCashback.Open;

      FcdsItens.First;
      While Not FcdsItens.Eof Do
      Begin
        If (FcdsItens.FieldByName('ITE_PROMOC').AsString = 'N') Or
           (FcdsCashback.FieldByName('CSH_ITEPRO').AsString = 'S') Then
        Begin
          fltValorBaseCashback := fltValorBaseCashback
                                + FcdsItens.FieldByName('ITE_VLRCON').AsFloat;
        End;

        If qryItensCashback.Locate('CSH_CODITE', FcdsItens.FieldByName('ITE_CODITE').AsString, []) Then
        Begin
          fltValorTotalItensCashBack := fltValorTotalItensCashBack
                                      + FcdsItens.FieldByName('ITE_VLRCON').AsFloat;
        End;

        FcdsItens.Next;
      End;
    Finally
      FreeAndNil(qryItensCashback);
    End;
  end;

  procedure pAdcionarRegistrosCdsCashbackVendas;
  begin
    qryConsulta := fCriaQuery;
    Try
      qryConsulta.Close;
      qryConsulta.SQL.Text := 'SELECT '
                            + '       B.* '
                            + '     , C.CLI_CODCAC AS CODCAC '
                            + '  FROM CADCSH B '
                            + '     , CADCLI C  '
                            + ' WHERE CURRENT_DATE BETWEEN B.CSH_INIVIG AND B.CSH_FINVIG '
                            + '   AND C.CLI_CODCLI = :CODCLI ';

      If FstrOrigem = 'V' Then
      Begin
        qryConsulta.SQL.Text := qryConsulta.SQL.Text
                              + '   AND ((B.CSH_TIPPES = "M" '
                              + '   AND   EXISTS(SELECT L.AUTOINCREM FROM CLICSH L '
                              + '                 WHERE L.CSH_SEQCSH = B.AUTOINCREM '
                              + '                   AND L.CSH_CODCLI = C.CLI_CODCLI)) '
                              + '    OR  (CASE '
                              + '           WHEN (C.CLI_CGCCPF = "1") AND (B.CSH_TIPPES IN ("J","A")) THEN '
                              + '             TRUE '
                              + '           WHEN (C.CLI_CGCCPF = "2") AND (B.CSH_TIPPES IN ("F","A")) THEN '
                              + '             TRUE '
                              + '         ELSE '
                              + '           FALSE '
                              + '         END)) '
                              + '   AND B.CSH_TIPCSH <> "DE" ';
      End
      Else
      Begin
        qryConsulta.SQL.Text := qryConsulta.SQL.Text
                              + '   AND B.CSH_TIPCSH = "DE" ';
      End;

      qryConsulta.SQL.Text := qryConsulta.SQL.Text
                            + ' ORDER BY '
                            + '       B.CSH_INIVIG ';

      qryConsulta.ParamByName('CODCLI').AsString := FstrCodCli;
      qryConsulta.Open;

      pAdicionaCamposDataSetVenda(qryConsulta);

      If Not FcdsCashback.Active Then
        FcdsCashback.CreateDataSet;

      FcdsCashback.EmptyDataSet;
      qryConsulta.First;

      While Not qryConsulta.Eof Do
      Begin
        pCopiaRegistroDataSet(qryConsulta, FcdsCashback, False, False, True);
        qryConsulta.Next;
      End;
    Finally
      FreeAndNil(qryConsulta);
    End;
  end;
begin
  pAdcionarRegistrosCdsCashbackVendas;

  If FcdsCashback.IsEmpty Then
    Exit;

  FcdsCashback.First;
  While Not FcdsCashback.Eof Do
  Begin
    If FstrOrigem = 'V' Then
    Begin
      fltValorBaseCashback       := 0;
      fltValorTotalItensCashBack := 0;

      somaItensVendaCashBack;

      If (MatchStr(FcdsCashback.FieldByName('CSH_TIPCSH').AsString, ['PI','VI'])) And
         (fltValorTotalItensCashBack = 0) Then
      Begin
        FcdsCashback.Next;
        Continue;
      End;

      If fltValorBaseCashback = 0 Then
      Begin
        FcdsCashback.Next;
        Continue;
      End;
    End
    Else
    Begin
      fltValorBaseCashback       := FcdsCashback.FieldByName('CSH_VALDVE').AsFloat;
      fltValorTotalItensCashBack := FcdsCashback.FieldByName('CSH_VALDVE').AsFloat;
    End;

    Try
      FcdsCashback.Edit;
      FcdsCashback.FieldByName('EXISTE_CASHBACK_UTILIZADO').AsString := IIF(FblnUtilizouCashback, 'S', 'N');
      FcdsCashback.FieldByName('EXISTE_CRITERIO_ITEM').AsString      := IIF(MatchStr(FcdsCashback.FieldByName('CSH_TIPCSH').AsString,['PI','VI']) And
                                                                            (fltValorTotalItensCashBack > 0), 'S', 'N');
      FcdsCashback.FieldByName('VLRCON').AsFloat                     := fltValorBaseCashback;
      FcdsCashback.FieldByName('ITE_VLRCON_TOTAL').AsFloat           := fltValorTotalItensCashBack;
      FcdsCashback.FieldByName('CODCND').AsString                    := FstrCodCnd;
      FcdsCashback.FieldByName('CODVEN').AsString                    := FstrCodVen;
      FcdsCashback.FieldByName('CODCLI').AsString                    := FstrCodCli;
      FcdsCashback.FieldByName('DTAENT').AsDateTime                  := VS_Date;
      FcdsCashback.Post;
    Except
      FcdsCashback.Cancel;
    End;

    FcdsCashback.Next;
  End;
end;

procedure TProcesssaRegraCashback.pCarregaItensVenda;
var
  qryConsulta : TUniQuery;
begin
  If FstrOrigem = 'E' Then
    Exit;

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Text := 'SELECT '
                          + '       D.AUTOINCREM AS AUTINC '
                          + '     , D.DET_QTDITE AS QTDITE '
                          + '     , D.DET_VLRCON AS VLRCON '
                          + '  FROM MOVDET D '
                          + ' INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER '
                          + ' WHERE G.GER_NUMDOC = :NUMDOC '
                          + '   AND G.GER_ESPDOC = :ESPDOC '
                          + '   AND G.GER_CODEMP = :CODEMP ';

    qryConsulta.ParamByName('NUMDOC').AsString := FstrNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := FstrEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := FstrCodEmp;
    qryConsulta.Open;

    FcdsItensVendaCashback.FieldDefs.Assign(qryConsulta.FieldDefs);
    If Not FcdsItensVendaCashback.Active Then
      FcdsItensVendaCashback.CreateDataSet;

    FcdsItensVendaCashback.EmptyDataSet;

    qryConsulta.First;
    While Not qryConsulta.Eof Do
    Begin
      pCopiaRegistroDataSet(qryConsulta, FcdsItensVendaCashback, False, False, True);
      qryConsulta.Next;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TProcesssaRegraCashback.pCarregaVenda;
var
  qryConsulta : TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Text := 'SELECT '
                          + '       B.* '
                          + '     , C.CLI_CODCAC as CODCAC '
                          + '     , G.AUTOINCREM AS AUTINC '
                          + '     , G.GER_NUMDOC AS NUMDOC '
                          + '     , G.GER_ESPDOC AS ESPDOC '
                          + '     , G.GER_CODEMP AS CODEMP '
                          + '     , G.GER_CODCLI AS CODCLI '
                          + '     , G.GER_DTAENT AS DTAENT '
                          + '     , G.GER_CODCND AS CODCND '
                          + '     , G.GER_CODVEN AS CODVEN '
                          + '     , G.GER_VLRCON - (CASE '
                          + '                         WHEN B.CSH_ITEPRO = "N" THEN '
                          + '                           IFNULL((SELECT SUM(D.DET_VLRCON) FROM MOVDET D '
                          + '                                    WHERE D.DET_NUMDOC = G.GER_NUMDOC '
                          + '                                      AND D.DET_ESPDOC = G.GER_ESPDOC '
                          + '                                      AND D.DET_CODEMP = G.GER_CODEMP '
                          + '                                      AND D.DET_PROMOC = "S"), 0) '
                          + '                       ELSE '
                          + '                         0 '
                          + '                       END) AS VLRCON '
                          + '     , (CASE '
                          + '          WHEN B.CSH_TIPCSH IN ("PI","VI") THEN '
                          + '            (CASE '
                          + '               WHEN EXISTS(SELECT I.AUTOINCREM FROM ITECSH I '
                          + '                            WHERE I.CSH_SEQCSH = B.AUTOINCREM '
                          + '                              AND EXISTS(SELECT D.AUTOINCREM FROM MOVDET D '
                          + '                                          WHERE D.DET_SEQGER = G.AUTOINCREM '
                          + '                                            AND D.DET_CODITE = I.CSH_CODITE)) THEN '
                          + '                 "S" '
                          + '             ELSE '
                          + '               "N" '
                          + '             END) '
                          + '        ELSE '
                          + '          "N" '
                          + '        END) AS EXISTE_CRITERIO_ITEM '
                          + '     , (CASE '
                          + '          WHEN EXISTS(SELECT U.AUTOINCREM FROM FATGOR F '
                          + '                       INNER JOIN UTICSH U ON U.UCB_NUMPED = F.FGO_NUMDOC '
                          + '                                          AND U.UCB_ESPPED = F.FGO_ESPDOC '
                          + '                                          AND U.UCB_EMPPED = F.FGO_CODEMP '
                          + '                      WHERE F.FGO_NUMFAT = G.GER_NUMDOC '
                          + '                        AND F.FGO_TIPFAT = G.GER_ESPDOC '
                          + '                        AND F.FGO_CODEMP = G.GER_CODEMP) THEN '
                          + '            "S" '
                          + '          WHEN EXISTS(SELECT U.AUTOINCREM FROM UTICSH U  '
                          + '                      WHERE U.UCB_NUMPED = G.GER_NUMDOC '
                          + '                        AND U.UCB_ESPPED = G.GER_ESPDOC '
                          + '                        AND U.UCB_EMPPED = G.GER_CODEMP) THEN '
                          + '            "S" '
                          + '        ELSE '
                          + '          "N" '
                          + '        END) AS EXISTE_CASHBACK_UTILIZADO '
                          + '     , (SELECT SUM(D.DET_VLRCON) FROM ITECSH I '
                          + '         INNER JOIN MOVDET D ON D.DET_CODITE = I.CSH_CODITE '
                          + '         WHERE I.CSH_SEQCSH = B.AUTOINCREM '
                          + '           AND D.DET_SEQGER = G.AUTOINCREM) AS ITE_VLRCON_TOTAL '
                          + '  FROM CADCSH B ';

    If FstrOrigem = 'V' Then
    Begin
      qryConsulta.SQL.Text := qryConsulta.SQL.Text
                            + '     , MOVGER G '
                            + ' INNER JOIN AUXMOV X ON X.AUX_SEQGER = G.AUTOINCREM '
                            + ' INNER JOIN CADCLI C ON C.CLI_CODCLI = G.GER_CODCLI '
                            + ' WHERE G.GER_DTAENT BETWEEN B.CSH_INIVIG AND B.CSH_FINVIG '
                            + '   AND G.GER_NUMDOC = :NUMDOC '
                            + '   AND G.GER_ESPDOC = :ESPDOC '
                            + '   AND G.GER_CODEMP = :CODEMP '
                            + '   AND X.AUX_OPCDOC IN ('+fArrayToString(fGetStringArray(ARR_DOCUMENTOS_OPCDOC_GERACAO_CASHBACK), ', ', True)+') '
                            + '   AND ((B.CSH_TIPPES = "M" '
                            + '   AND   EXISTS(SELECT L.AUTOINCREM FROM CLICSH L '
                            + '                 WHERE L.CSH_SEQCSH = B.AUTOINCREM '
                            + '                   AND L.CSH_CODCLI = C.CLI_CODCLI)) '
                            + '    OR  (CASE '
                            + '           WHEN (C.CLI_CGCCPF = "1") AND (B.CSH_TIPPES IN ("J","A")) THEN '
                            + '             TRUE '
                            + '           WHEN (C.CLI_CGCCPF = "2") AND (B.CSH_TIPPES IN ("F","A")) THEN '
                            + '             TRUE '
                            + '         ELSE '
                            + '           FALSE '
                            + '         END)) '
                            + '   AND (CASE '
                            + '          WHEN B.CSH_TIPCSH IN ("PI","VI") THEN '
                            + '            EXISTS(SELECT I.AUTOINCREM FROM ITECSH I '
                            + '                    WHERE I.CSH_SEQCSH = B.AUTOINCREM '
                            + '                      AND EXISTS(SELECT D.AUTOINCREM FROM MOVDET D '
                            + '                                  WHERE D.DET_SEQGER = G.AUTOINCREM '
                            + '                                    AND D.DET_CODITE = I.CSH_CODITE)) '
                            + '        ELSE '
                            + '          TRUE '
                            + '        END) '
                            + '   AND B.CSH_TIPCSH <> "DE" ';
    End
    Else
    Begin
      qryConsulta.SQL.Text := qryConsulta.SQL.Text
                            + '     , CADCLI C '
                            + '  LEFT JOIN MOVGER G ON G.GER_CODCLI = C.CLI_CODCLI '
                            + '                    AND FALSE '
                            + '  LEFT JOIN AUXMOV X ON X.AUX_SEQGER = G.AUTOINCREM '
                            + ' WHERE CURRENT_DATE BETWEEN B.CSH_INIVIG AND B.CSH_FINVIG '
                            + '   AND C.CLI_CODCLI = :CODCLI '
                            + '   AND B.CSH_TIPCSH = "DE" '
                            + '   AND IFNULL(G.AUTOINCREM,"") = "" ';
    End;

    qryConsulta.SQL.Text := qryConsulta.SQL.Text
                          + ' ORDER BY '
                          + '       B.CSH_INIVIG ';


    If FstrOrigem = 'V' Then
    Begin
      qryConsulta.ParamByName('NUMDOC').AsString := FstrNumDoc;
      qryConsulta.ParamByName('ESPDOC').AsString := FstrEspDoc;
      qryConsulta.ParamByName('CODEMP').AsString := FstrCodEmp;
    End
    Else
      qryConsulta.ParamByName('CODCLI').AsString := FstrCodCli;

    qryConsulta.Open;

    FcdsCashback.FieldDefs.Assign(qryConsulta.FieldDefs);
    If Not FcdsCashback.Active Then
      FcdsCashback.CreateDataSet;

    FcdsCashback.EmptyDataSet;
    qryConsulta.First;
    While Not qryConsulta.Eof Do
    Begin
      pCopiaRegistroDataSet(qryConsulta, FcdsCashback, False, False, True);
      qryConsulta.Next;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TProcesssaRegraCashback.fEhRegraValidaParaVenda(
  const blnRegra: Boolean): Boolean;
begin
  Result := blnRegra;

  If (Not Result) Then
  Begin
    FblnOcorreuErro := True;
    If (Not FblnSilenciarAvisos) Then
      raise Exception.Create('Não é possível gerar cashback, pois não existe regra '
                           + 'de cálculo válida no cashback '+FcdsCashback.FieldByName('CSH_DESCRI').AsString+'.');

  End;
end;

function TProcesssaRegraCashback.fExecutaRegraCashback(
  const objCalculoCashback: TRegraCalculoCashback): Boolean;
begin
  objCalculoCashback.objVendaCashback.strSeqGer := FcdsCashback.FieldByName('AUTINC').AsString;
  objCalculoCashback.objVendaCashback.strNumDoc := FcdsCashback.FieldByName('NUMDOC').AsString;
  objCalculoCashback.objVendaCashback.strEspDoc := FcdsCashback.FieldByName('ESPDOC').AsString;

  If FstrOrigem = 'V' Then
  Begin
    objCalculoCashback.objVendaCashback.strCodEmp := FcdsCashback.FieldByName('CODEMP').AsString;
    objCalculoCashback.objVendaCashback.strCodCli := FcdsCashback.FieldByName('CODCLI').AsString;
    objCalculoCashback.objVendaCashback.dtaDtaEnt := FcdsCashback.FieldByName('DTAENT').AsDateTime;
  End
  Else
  Begin
    objCalculoCashback.objVendaCashback.strCodEmp := FstrCodEmp;
    objCalculoCashback.objVendaCashback.strCodCli := FstrCodCli;
    objCalculoCashback.objVendaCashback.dtaDtaEnt := fNow;
  End;

  objCalculoCashback.objVendaCashback.strCodCsh := FcdsCashback.FieldByName('CSH_CODIGO').AsString;
  objCalculoCashback.objVendaCashback.fltVlrDoc := FcdsCashback.FieldByName('VLRCON').AsFloat;
  objCalculoCashback.objVendaCashback.fltMinPrx := FcdsCashback.FieldByName('CSH_MINVEN').AsFloat;
  objCalculoCashback.objVendaCashback.fltPerMax := FcdsCashback.FieldByName('CSH_PERMAX').AsFloat;
  objCalculoCashback.objVendaCashback.strResCal := objCalculoCashback.fRetornaResumoCalculo;
  objCalculoCashback.objVendaCashback.intDiaUti := FcdsCashback.FieldByName('CSH_DIAUTI').AsInteger;
  objCalculoCashback.objVendaCashback.strCodOpe := FstrCodOpe;
  objCalculoCashback.objVendaCashback.strOrigem := FstrOrigem;
  objCalculoCashback.objVendaCashback.strCgcCpf := FstrCgcCpf;
  objCalculoCashback.objVendaCashback.strCgcCon := FstrCpfCli;
  objCalculoCashback.objVendaCashback.strTelCon := FstrFonCli;
  objCalculoCashback.objVendaCashback.fltQtdEmb := FfltQtdEmb;
  objCalculoCashback.objVendaCashback.strStatus := 'A';
  objCalculoCashback.objVendaCashback.dtaIniVal := 0;
  objCalculoCashback.objVendaCashback.dtaDtaVal := 0;

  If (FcdsCashback.FieldByName('CSH_INIVAL').AsDateTime > 0) Then
  Begin
    objCalculoCashback.objVendaCashback.dtaIniVal := FcdsCashback.FieldByName('CSH_INIVAL').AsDateTime;
    objCalculoCashback.objVendaCashback.dtaDtaVal := FcdsCashback.FieldByName('CSH_FINVAL').AsDateTime;
  End
  Else If FcdsCashback.FieldByName('CSH_DIAEXP').AsInteger = 0 Then
  Begin
    objCalculoCashback.objVendaCashback.dtaIniVal := objCalculoCashback.objVendaCashback.dtaDtaEnt;
    objCalculoCashback.objVendaCashback.dtaDtaVal := StrToDate('31/12/9999')
  End
  Else If FcdsCashback.FieldByName('CSH_DIAEXP').AsInteger > 0 Then
  Begin
    objCalculoCashback.objVendaCashback.dtaIniVal := objCalculoCashback.objVendaCashback.dtaDtaEnt;
    objCalculoCashback.objVendaCashback.dtaDtaVal := VS_Date
                                                   + FcdsCashback.FieldByName('CSH_DIAEXP').AsInteger;
  End;

  If (FcdsCashback.FieldByName('CSH_DIAUTI').AsInteger > 0) Then
  Begin
    If (FcdsCashback.FieldByName('CSH_INIVAL').AsDateTime = 0) Or
       (FcdsCashback.FieldByName('CSH_INIVAL').AsDateTime <
        (objCalculoCashback.objVendaCashback.dtaDtaEnt + FcdsCashback.FieldByName('CSH_DIAUTI').AsInteger)) Then
      objCalculoCashback.objVendaCashback.dtaIniVal := objCalculoCashback.objVendaCashback.dtaDtaEnt
                                                     + FcdsCashback.FieldByName('CSH_DIAUTI').AsInteger;
  End;

  objCalculoCashback.pCalcularCashback;
  objCalculoCashback.objVendaCashback.fltVlrDsp := objCalculoCashback.objVendaCashback.fltVlrCsh;

  If (objCalculoCashback.objVendaCashback.fltVlrCsh <= 0) Then
    Exit(False);

  Result := True;
end;

function TProcesssaRegraCashback.fExisteCanalAcessoRegraCashback(
  const strCodCsh, strCodCac: String): Boolean;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Text := 'SELECT C.AUTOINCREM FROM CACCSH C '
                          + ' INNER JOIN CADCSH B ON B.AUTOINCREM = C.CSH_SEQCSH '
                          + ' WHERE B.CSH_CODIGO = :CODCSH '
                          + '   AND C.CSH_CODCAC = :CODCAC ';

    qryConsulta.ParamByName('CODCSH').AsString := strCodCsh;
    qryConsulta.ParamByName('CODCAC').AsString := strCodCac;
    qryConsulta.Open;

    Result := (Not qryConsulta.IsEmpty);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TProcesssaRegraCashback.fExisteCondicaoPagamentoRegraCashback(
  const strCodCsh, strCodCnd: String): Boolean;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Text := 'SELECT P.AUTOINCREM FROM CPGCSH P '
                          + ' INNER JOIN CADCSH B ON B.AUTOINCREM = P.CSH_SEQCSH '
                          + ' WHERE B.CSH_CODIGO = :CODCSH '
                          + '   AND P.CSH_CODCND = :CODCND ';

    qryConsulta.ParamByName('CODCSH').AsString := strCodCsh;
    qryConsulta.ParamByName('CODCND').AsString := strCodCnd;
    qryConsulta.Open;

    Result := (Not qryConsulta.IsEmpty);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TProcesssaRegraCashback.fExisteDepartamentoRegraCashback(
  const strCodCsh, strCodVen: String): Boolean;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Text := 'SELECT D.AUTOINCREM FROM DEPCSH D '
                          + ' INNER JOIN CADCSH B ON B.AUTOINCREM = D.CSH_SEQCSH '
                          + ' INNER JOIN CADOPE O ON O.OPE_CODDEP = D.CSH_CODDEP '
                          + ' WHERE B.CSH_CODIGO = :CODCSH '
                          + '   AND O.OPE_CODOPE = :CODVEN ';

    qryConsulta.ParamByName('CODCSH').AsString := strCodCsh;
    qryConsulta.ParamByName('CODVEN').AsString := strCodVen;
    qryConsulta.Open;

    Result := (Not qryConsulta.IsEmpty);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TProcesssaRegraCashback.fValidaRegrasProcessamentoCashback: Boolean;
begin
  Result := False;

  If (FcdsCashback.IsEmpty) Then
    Exit;

  FcdsCashback.First;
  While Not FcdsCashback.Eof Do
  Begin
    If FstrOrigem = 'V' Then
    Begin
      If (FcdsCashback.FieldByName('VLRCON').AsFloat = 0) Then
        Exit;

      If MatchStr(FcdsCashback.FieldByName('CSH_TIPCSH').AsString, ['VI','PI']) Then
      Begin
        If (FcdsCashback.FieldByName('ITE_VLRCON_TOTAL').AsFloat < FcdsCashback.FieldByName('CSH_GERCSH').AsFloat) Then
          Exit;
      End
      Else
      Begin
        If (FcdsCashback.FieldByName('VLRCON').AsFloat < FcdsCashback.FieldByName('CSH_GERCSH').AsFloat) Then
          Exit;
      End;
    End;

    If (FcdsCashback.FieldByName('CSH_CHSBCH').AsString = 'N') And
       (FcdsCashback.FieldByName('EXISTE_CASHBACK_UTILIZADO').AsString = 'S') Then
      Exit;

    If (FcdsCashback.FieldByName('CSH_CLICON').AsString = 'S') And
       (fClienteConsumidor(fRetNomCliente(FcdsCashback.FieldByName('CODCLI').AsString), True, True)) Then
      Exit;

    If (FcdsCashback.FieldByName('CSH_CONPAG').AsString = 'D') And
       (Not fExisteCondicaoPagamentoRegraCashback(FcdsCashback.FieldByName('CSH_CODIGO').AsString,
                                                  FcdsCashback.FieldByName('CODCND').AsString)) Then
      Exit;

    If (FcdsCashback.FieldByName('CSH_CNLACE').AsString = 'D') And
       (Not fExisteCanalAcessoRegraCashback(FcdsCashback.FieldByName('CSH_CODIGO').AsString,
                                            FcdsCashback.FieldByName('CODCAC').AsString)) Then
      Exit;

    If (FcdsCashback.FieldByName('CSH_DEPART').AsString = 'D') And
       (Not fExisteDepartamentoRegraCashback(FcdsCashback.FieldByName('CSH_CODIGO').AsString,
                                             FcdsCashback.FieldByName('CODVEN').AsString)) Then
      Exit;

    FcdsCashback.Next;
  End;

  Result := True;
end;

procedure TProcesssaRegraCashback.SetblnSilenciarAvisos(const Value: Boolean);
begin
  FblnSilenciarAvisos := Value;
end;

procedure TProcesssaRegraCashback.SetCdsItens(const Value: TUniClientDataSet);
begin
  FcdsItens := Value;
end;

procedure TProcesssaRegraCashback.SetCgcCpf(const Value: String);
begin
  FstrCgcCpf := Value;
end;

procedure TProcesssaRegraCashback.SetCodCli(const Value: String);
begin
  FstrCodCli := Value;
end;

procedure TProcesssaRegraCashback.SetCodCnd(const Value: String);
begin
  FstrCodCnd := Value;
end;

procedure TProcesssaRegraCashback.SetCodEmp(const Value: String);
begin
  FstrCodEmp := Value;
end;

procedure TProcesssaRegraCashback.SetCodOpe(const Value: String);
begin
  FstrCodOpe := Value;
end;

procedure TProcesssaRegraCashback.SetCodVen(const Value: String);
begin
  FstrCodVen := Value;
end;

procedure TProcesssaRegraCashback.SetCpfCli(const Value: String);
begin
  FstrCpfCli := Value;
end;

procedure TProcesssaRegraCashback.SetEspDoc(const Value: String);
begin
  FstrEspDoc := Value;
end;

procedure TProcesssaRegraCashback.SetFonCli(const Value: String);
begin
  FstrFonCli := Value;
end;

procedure TProcesssaRegraCashback.SetNumDoc(const Value: String);
begin
  FstrNumDoc := Value;
end;

procedure TProcesssaRegraCashback.SetOrigem(const Value: String);
begin
  FstrOrigem := Value;
end;

procedure TProcesssaRegraCashback.SetQtdEmb(const Value: Double);
begin
  FfltQtdEmb := Value;
end;

procedure TProcesssaRegraCashback.SetSimulacaoPedido(const Value: Boolean);
begin
  FSimulacaoPedido := Value;
end;

procedure TProcesssaRegraCashback.SetUtilizouCashback(const Value: Boolean);
begin
  FblnUtilizouCashback := Value;
end;

{ TRegraCalculoCashback }

constructor TRegraCalculoCashback.Create;
begin
  FTiposCashback := TTipoCashback.Create;
  FSimulacaoPedido := False;
end;

destructor TRegraCalculoCashback.Destroy;
begin
  FreeAndNil(FTiposCashback);
  inherited;
end;

function TRegraCalculoCashback.fRetornaResumoCalculo: String;
var
  strVigencia,
  strUtilizacao,
  strValidade   : String;
begin
  strVigencia := FormatDateTime('dd/mm/yyyy', FcdsCashback.FieldByName('CSH_INIVIG').AsDateTime)
               + ' a '
               + FormatDateTime('dd/mm/yyyy', FcdsCashback.FieldByName('CSH_FINVIG').AsDateTime);

  strUtilizacao := EmptyStr;

  If FcdsCashback.FieldByName('CSH_MINVEN').AsFloat > 0 Then
  Begin
    strUtilizacao := strUtilizacao
                   + 'VENDAS A PARTIR DE '+FormatFloat(',0.00', FcdsCashback.FieldByName('CSH_MINVEN').AsFloat);
  End;

  If FcdsCashback.FieldByName('CSH_PERMAX').AsFloat > 0 Then
  Begin
    If Not fEmptyStr(strUtilizacao) Then
      strUtilizacao := strUtilizacao
                     + ' E ';

    strUtilizacao := strUtilizacao
                   + 'APLICAR NO MÁXIMO EM '+FormatFloat(',0.00', FcdsCashback.FieldByName('CSH_PERMAX').AsFloat)
                   + '% DO VALOR DA COMPRA';
  End;

  strValidade := EmptyStr;

  If FcdsCashback.FieldByName('CSH_DIAEXP').AsInteger > 0 Then
  Begin
    strValidade := strValidade
                 + 'EXPIRA EM '+FcdsCashback.FieldByName('CSH_DIAEXP').AsString+' DIA(S)';
  End;

  If FcdsCashback.FieldByName('CSH_INIVAL').AsDateTime > 0 Then
  Begin
    If Not fEmptyStr(strUtilizacao) Then
      strValidade := strValidade
                   + ' E ';

    strValidade := strValidade
                 + 'PERIODO DE UTILIZAÇÃO ENTRE '+FormatDateTime('dd/mm/yyyy', FcdsCashback.FieldByName('CSH_INIVAL').AsDateTime)
                 + ' E '+FormatDateTime('dd/mm/yyyy', FcdsCashback.FieldByName('CSH_FINVAL').AsDateTime);
  End;

  Result := Format(BASE_TEXTO_RESUMO, [strVigencia,
                                       fRetornaGeracaoResumoCalculo,
                                       strUtilizacao,
                                       strValidade]);
end;

procedure TRegraCalculoCashback.pDistruibuirProporcaoCashbackItens;
var
  objItem          : TItemCashbackVenda;
  fltDesCsh,
  fltTotalCashback : Double;
begin
  If (strOrigem = 'E') Then
    Exit;

  fltTotalCashback := 0;

  cdsItensVendaCashback.First;
  While Not cdsItensVendaCashback.Eof Do
  Begin
    fltDesCsh := fFormataFloat(cdsItensVendaCashback.FieldByName('VLRCON').AsFloat
                             / cdsCashback.FieldByName('VLRCON').AsFloat,2)
               * objVendaCashback.fltVlrCsh;

    fltDesCsh := fFormataFloat(fltDesCsh,2);

    If (cdsItensVendaCashback.Recno =
        cdsItensVendaCashback.RecordCount) Then
    Begin
      fltDesCsh := objVendaCashback.fltVlrCsh
                 - fltTotalCashback;
    End;

    fltTotalCashback := fltTotalCashback
                      + fltDesCsh;

    If Not blnSimulacaoPedido Then
    Begin
      objItem := TItemCashbackVenda.Create;
      objItem.strIncDet := cdsItensVendaCashback.FieldByName('AUTINC').AsString;
      objItem.fltDesCsh := fltDesCsh;
      objVendaCashback.ListaItemCashbackVenda.Add(objItem);
    End;

    cdsItensVendaCashback.Next;
  End;
end;

procedure TRegraCalculoCashback.SetObjVendaCashback(
  const Value: TVendaCashback);
begin
  FObjVendaCashback := Value;
end;

procedure TRegraCalculoCashback.SetcdsCashback(const Value: TUniClientDataSet);
begin
  FcdsCashback := Value;
end;

procedure TRegraCalculoCashback.SetcdsItensVendaCashback(
  const Value: TUniClientDataSet);
begin
  FcdsItensVendaCashback := Value;
end;

procedure TRegraCalculoCashback.SetSimulacaoPedido(const Value: Boolean);
begin
  FSimulacaoPedido := Value;
end;

procedure TRegraCalculoCashback.SetstrOrigem(const Value: String);
begin
  FstrOrigem := Value;
end;

{ TRegraCalculoCashbackValorFixoVenda }

function TRegraCalculoCashbackValorFixoVenda.fRetornaGeracaoResumoCalculo: String;
begin
  Result := Format(TiposCashback.ListaTipos.Items[cdsCashback.FieldByName('CSH_TIPCSH').AsString],
                   [FormatFloat(',0.00', cdsCashback.FieldByName('CSH_VALFIX').AsFloat)]);
end;

procedure TRegraCalculoCashbackValorFixoVenda.pCalcularCashback;
begin
  inherited;
  objVendaCashback.fltVlrCsh := cdsCashback.FieldByName('CSH_VALFIX').AsFloat;
  pDistruibuirProporcaoCashbackItens;
end;

{ TRegraCalculoCashbackPercentualVenda }

function TRegraCalculoCashbackPercentualVenda.fRetornaGeracaoResumoCalculo: String;
begin
  Result := Format(TiposCashback.ListaTipos.Items[cdsCashback.FieldByName('CSH_TIPCSH').AsString],
                   [FormatFloat(',0.00', cdsCashback.FieldByName('CSH_PERDES').AsFloat)]);
end;

procedure TRegraCalculoCashbackPercentualVenda.pCalcularCashback;
begin
  inherited;
  objVendaCashback.fltVlrCsh := cdsCashback.FieldByName('VLRCON').AsFloat
                              * (cdsCashback.FieldByName('CSH_PERDES').AsFloat/100);

  pDistruibuirProporcaoCashbackItens;
end;

{ TRegraCalculoCashbackAcumuloVenda }

function TRegraCalculoCashbackAcumuloVenda.fRetornaGeracaoResumoCalculo: String;
begin
  Result := Format(TiposCashback.ListaTipos.Items[cdsCashback.FieldByName('CSH_TIPCSH').AsString],
                   [FormatFloat(',0.00', cdsCashback.FieldByName('CSH_VALCOM').AsFloat),
                    FormatFloat(',0.00', cdsCashback.FieldByName('CSH_VALACU').AsFloat)]);
end;

procedure TRegraCalculoCashbackAcumuloVenda.pCalcularCashback;
var
  intMultiplicador : Integer;
begin
  inherited;
  intMultiplicador := Trunc(cdsCashback.FieldByName('VLRCON').AsFloat
                    /       cdsCashback.FieldByName('CSH_VALCOM').AsFloat);

  objVendaCashback.fltVlrCsh := cdsCashback.FieldByName('CSH_VALACU').AsFloat
                              * intMultiplicador;

  pDistruibuirProporcaoCashbackItens;
end;

{ TRegraCalculoCashbackPercentualItem }

function TRegraCalculoCashbackPercentualItem.fRetornaGeracaoResumoCalculo: String;
begin
  Result := Format(TiposCashback.ListaTipos.Items[cdsCashback.FieldByName('CSH_TIPCSH').AsString],
                   [FormatFloat(',0.00', cdsCashback.FieldByName('CSH_PERITE').AsFloat)]);
end;

procedure TRegraCalculoCashbackPercentualItem.pCalcularCashback;
var
  objItem   : TItemCashbackVenda;
  fltDesCsh : Double;
begin
  inherited;
  objVendaCashback.fltVlrCsh := 0;

  cdsItensVendaCashback.First;
  While Not cdsItensVendaCashback.Eof Do
  Begin
    fltDesCsh := cdsItensVendaCashback.FieldByName('VLRCON').AsFloat
               * (cdsCashback.FieldByName('CSH_PERITE').AsFloat/100);

    If Not blnSimulacaoPedido Then
    Begin
      objItem := TItemCashbackVenda.Create;
      objItem.strIncDet := cdsItensVendaCashback.FieldByName('AUTINC').AsString;
      objItem.fltDesCsh := fltDesCsh;
      objVendaCashback.ListaItemCashbackVenda.Add(objItem);
    End;

    objVendaCashback.fltVlrCsh := objVendaCashback.fltVlrCsh
                                + fltDesCsh;
    cdsItensVendaCashback.Next;
  End;
end;

{ TRegraCalculoCashbackValorFixoItem }

function TRegraCalculoCashbackValorFixoItem.fRetornaGeracaoResumoCalculo: String;
begin
  Result := Format(TiposCashback.ListaTipos.Items[cdsCashback.FieldByName('CSH_TIPCSH').AsString],
                   [FormatFloat(',0.00', cdsCashback.FieldByName('CSH_VALITE').AsFloat)]);
end;

procedure TRegraCalculoCashbackValorFixoItem.pCalcularCashback;
var
  objItem   : TItemCashbackVenda;
  fltDesCsh : Double;
begin
  inherited;
  objVendaCashback.fltVlrCsh := 0;

  cdsItensVendaCashback.First;
  While Not cdsItensVendaCashback.Eof Do
  Begin
    fltDesCsh := cdsItensVendaCashback.FieldByName('QTDITE').AsFloat
               * (cdsCashback.FieldByName('CSH_VALITE').AsFloat);

    If Not blnSimulacaoPedido Then
    Begin
      objItem := TItemCashbackVenda.Create;
      objItem.strIncDet := cdsItensVendaCashback.FieldByName('AUTINC').AsString;
      objItem.fltDesCsh := fltDesCsh;
      objVendaCashback.ListaItemCashbackVenda.Add(objItem);
    End;

    objVendaCashback.fltVlrCsh := objVendaCashback.fltVlrCsh
                                + fltDesCsh;
    cdsItensVendaCashback.Next;
  End;
end;

{ TRegraCalculoCashbackDevolucaoEmbalagem }

function TRegraCalculoCashbackDevolucaoEmbalagem.fRetornaGeracaoResumoCalculo: String;
begin
  Result := Format(TiposCashback.ListaTipos.Items[cdsCashback.FieldByName('CSH_TIPCSH').AsString],
                   [FormatFloat(',0.00', cdsCashback.FieldByName('CSH_VALDVE').AsFloat)]);
end;

procedure TRegraCalculoCashbackDevolucaoEmbalagem.pCalcularCashback;
begin
  If cdsCashback.FieldByName('CSH_VALDVE').AsFloat <= 0 Then
    Exit;

  objVendaCashback.fltVlrCsh := cdsCashback.FieldByName('CSH_VALDVE').AsFloat
                              * objVendaCashback.fltQtdEmb;

  pDistruibuirProporcaoCashbackItens;
end;

end.
