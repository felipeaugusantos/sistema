unit untTBoleto1Via_Comprovante;

interface

uses
  Windows, Classes, Forms, Buttons, Menus, frxClass, frxBarcode, Uni, Data.DB,
  untFuncAutban, System.Generics.Collections, System.SysUtils, System.StrUtils,
  untQckBancos;

Type

  TBoleto1Via_Comprovante = class
  private
    FAceite,
    FAgenciaCedente,
    FBeneficiario,
    FCarteira,
    FCarteira2,
    FCedente,
    FCidadeSacador,
    FCodigoBanco,
    FCodigoDeBarras,
    FDataDocumento,
    FDataProcessamento,
    FDataVencimento,
    FEnderecoAvalista,
    FEnderecoCedente,
    FEnderecoSacador,
    FEspecieDocumento,
    FEspecieMoeda,
    FINSSAC,
    FInstrucao1,
    FInstrucao2,
    FInstrucao3,
    FInstrucao4,
    FInstrucao5,
    FInstrucao6,
    FInstrucao7,
    FInstrucao8,
    FLinhaDigitavel,
    FLocalExtensao,
    FLocalPagamento,
    FNomeCedente,
    FNomeSacador,
    FNossoNumero,
    FNumeroDaParcela,
    FNumeroDocumento,
    FNumeroDocumentoSemParcela,
    FOutrosAcrescimos,
    FPagador,
    FSacadorAvalista,
    FTotalDeParcelas,
    FUsoDoBanco,
    FValorDaMoeda,
    FValorDocumento,
    FCodCliente,
    FCodEmpresa,
    FEspecieDup : String;
  public
    property Aceite                    : String read FAceite                    write FAceite;
    property AgenciaCedente            : String read FAgenciaCedente            write FAgenciaCedente;
    property Beneficiario              : String read FBeneficiario              write FBeneficiario;
    property Carteira                  : String read FCarteira                  write FCarteira;
    property Carteira2                 : String read FCarteira2                 write FCarteira2;
    property Cedente                   : String read FCedente                   write FCedente;
    property CidadeSacador             : String read FCidadeSacador             write FCidadeSacador;
    property CodigoBanco               : String read FCodigoBanco               write FCodigoBanco;
    property CodigoDeBarras            : String read FCodigoDeBarras            write FCodigoDeBarras;
    property DataDocumento             : String read FDataDocumento             write FDataDocumento;
    property DataProcessamento         : String read FDataProcessamento         write FDataProcessamento;
    property DataVencimento            : String read FDataVencimento            write FDataVencimento;
    property EnderecoAvalista          : String read FEnderecoAvalista          write FEnderecoAvalista;
    property EnderecoCedente           : String read FEnderecoCedente           write FEnderecoCedente;
    property EnderecoSacador           : String read FEnderecoSacador           write FEnderecoSacador;
    property EspecieDocumento          : String read FEspecieDocumento          write FEspecieDocumento;
    property EspecieMoeda              : String read FEspecieMoeda              write FEspecieMoeda;
    property INSSAC                    : String read FINSSAC                    write FINSSAC;
    property Instrucao1                : String read FInstrucao1                write FInstrucao1;
    property Instrucao2                : String read FInstrucao2                write FInstrucao2;
    property Instrucao3                : String read FInstrucao3                write FInstrucao3;
    property Instrucao4                : String read FInstrucao4                write FInstrucao4;
    property Instrucao5                : String read FInstrucao5                write FInstrucao5;
    property Instrucao6                : String read FInstrucao6                write FInstrucao6;
    property Instrucao7                : String read FInstrucao7                write FInstrucao7;
    property Instrucao8                : String read FInstrucao8                write FInstrucao8;
    property LinhaDigitavel            : String read FLinhaDigitavel            write FLinhaDigitavel;
    property LocalExtensao             : String read FLocalExtensao             write FLocalExtensao;
    property LocalPagamento            : String read FLocalPagamento            write FLocalPagamento;
    property NomeCedente               : String read FNomeCedente               write FNomeCedente;
    property NomeSacador               : String read FNomeSacador               write FNomeSacador;
    property NossoNumero               : String read FNossoNumero               write FNossoNumero;
    property NumeroDaParcela           : String read FNumeroDaParcela           write FNumeroDaParcela;
    property NumeroDocumento           : String read FNumeroDocumento           write FNumeroDocumento;
    property NumeroDocumentoSemParcela : String read FNumeroDocumentoSemParcela write FNumeroDocumentoSemParcela;
    property OutrosAcrescimos          : String read FOutrosAcrescimos          write FOutrosAcrescimos;
    property Pagador                   : String read FPagador                   write FPagador;
    property SacadorAvalista           : String read FSacadorAvalista           write FSacadorAvalista;
    property TotalDeParcelas           : String read FTotalDeParcelas           write FTotalDeParcelas;
    property UsoDoBanco                : String read FUsoDoBanco                write FUsoDoBanco;
    property ValorDaMoeda              : String read FValorDaMoeda              write FValorDaMoeda;
    property ValorDocumento            : String read FValorDocumento            write FValorDocumento;
    property CodCliente                : String read FCodCliente                write FCodCliente;
    property CodEmpresa                : String read FCodEmpresa                write FCodEmpresa;
    property EspecieDup                : String read FEspecieDup                write FEspecieDup;
  end;

  TBoleto1Via_ComprovanteBuilder = Class(TComponent)
  private
    FBancoSelecionado : String;
    FBoleto1ViaList : TList<TBoleto1Via_Comprovante>;
    FListaArquivosGerados : TStringList;
    function fSetAceite : String;
    function fSetAgenciaCedente : String;
    function fSetBeneficiario : String;
    function fSetCarteira : String;
    function fSetCarteira2 : String;
    function fSetCedente : String;
    function fSetCidadeSacador : String;
    function fSetCodigoBanco : String;
    function fSetCodigoDeBarras : String;
    function fSetDataDocumento : String;
    function fSetDataProcessamento : String;
    function fSetDataVencimento : String;
    function fSetEnderecoAvalista : String;
    function fSetEnderecoCedente : String;
    function fSetEnderecoSacador : String;
    function fSetEspecieDocumento : String;
    function fSetEspecieMoeda : String;
    function fSetINSSAC : String;
    function fSetInstrucao1 : String;
    function fSetInstrucao2 : String;
    function fSetInstrucao3 : String;
    function fSetInstrucao4 : String;
    function fSetInstrucao5 : String;
    function fSetInstrucao6 : String;
    function fSetInstrucao7 : String;
    function fSetInstrucao8 : String;
    function fSetLinhaDigitavel : String;
    function fSetLocalExtensao : String;
    function fSetLocalPagamento : String;
    function fSetNomeCedente : String;
    function fSetNomeSacador : String;
    function fSetNossoNumero : String;
    function fSetNumeroDaParcela : String;
    function fSetNumeroDocumento : String;
    function fSetOutrosAcrescimos : String;
    function fSetPagador : String;
    function fSetSacadorAvalista : String;
    function fSetTotalDeParcelas : String;
    function fSetUsoDoBanco : String;
    function fSetValorDaMoeda : String;
    function fSetValorDocumento : String;
    function fSetCodCliente: String;
    function fSetCodEmpresa: String;
    function fSetEspecieDup: String;

    function  fGetNumeroDuplicatasDistintas : TStringList;
    function  fGetListaBoleto1Via(ANumeroDocumentoSemParcela : String) : TList<TBoleto1Via_Comprovante>;
    procedure pSetObjetosPreImpressao(var frmQckBancos: TfrmQckBancos);

  public
    constructor Create; reintroduce;
    Destructor Destroy; Override;

    function fAdicionarBoleto1Via(ABancoSelecionado : String) : Boolean;
    function fImprimiBoleto1Via(AForcarImpressao : Boolean;
                               ANomeForm, ANomeFilaImpresso : String;
                               blnPreview: Boolean = False; blnEnvioAutmaticoEmail: Boolean = False;
                               blnBolEnvEmail: Boolean = False;
                               blnEnvioFaturamento: Boolean = False): Boolean;

    function fGetListaArquivosGerados(ALimparListaAposRetorno : Boolean = True) : String;
    function fQryAgrupamento(strNumDup, strCodEmp, strCodCli: String): TUniQuery;
  End;

implementation

uses untFuncoesBoleto, untBancos, Aurelius.Bind.Dataset,
     untFuncoesSimples, untCfgRel, frxExportPDF, Vcl.Graphics;

{ TBoleto1Via_ComprovanteBuilder }

constructor TBoleto1Via_ComprovanteBuilder.Create;
begin
  FBoleto1ViaList      := TList<TBoleto1Via_Comprovante>.Create;
  FListaArquivosGerados := TStringList.Create;
end;

destructor TBoleto1Via_ComprovanteBuilder.Destroy;
begin
  FreeAndNil(FBoleto1ViaList);
  FreeAndNil(FListaArquivosGerados);
  inherited;
end;

function TBoleto1Via_ComprovanteBuilder.fAdicionarBoleto1Via(ABancoSelecionado : String) : Boolean;
var SBoleto1Via : TBoleto1Via_Comprovante;
begin
  Try
    Result := False;

    FBancoSelecionado := ABancoSelecionado;

    SBoleto1Via := TBoleto1Via_Comprovante.Create;

    If FBancoSelecionado = '001' Then
    Begin
      If Assigned(TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi)) Then Result := RetornaLinhaDigitavelBancoDoBrasilApi
      Else Result := fGeLiDi001;
    End
    else
    if Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0 then
      Result := fGeLiDi237
    else
    If (FBancoSelecionado = '341') Or (FBancoSelecionado = '995')  Or (FBancoSelecionado = '981') Then
      Result := fGeLiDi341
    else
    If FBancoSelecionado = '104' then
      Result := fGeLiDi104
    else
    If FBancoSelecionado = '033' then
    begin
      pProArq033B;
      Result := Not fEmptyStr(strCodBar);
    end
    else
    If FBancoSelecionado = '748' then
      Result := fGeLiDi748
    else
    If FBancoSelecionado = '090' then
      Result := fGeLiDi090
    else
    If FBancoSelecionado = '756' then
      Result := fGeLiDi756
    else
    If FBancoSelecionado = '133' then
      Result := fGeLiDi133
    else
    If FBancoSelecionado = '041' then
      Result := fGeLiDi041;

    if Result then
    begin
      SBoleto1Via.Aceite                    := fSetAceite;
      SBoleto1Via.AgenciaCedente            := fSetAgenciaCedente;
      SBoleto1Via.Beneficiario              := fSetBeneficiario;
      SBoleto1Via.Carteira                  := fSetCarteira;
      SBoleto1Via.Carteira2                 := fSetCarteira2;
      SBoleto1Via.Cedente                   := fSetCedente;
      SBoleto1Via.CidadeSacador             := fSetCidadeSacador;
      SBoleto1Via.CodigoBanco               := fSetCodigoBanco;
      SBoleto1Via.CodigoDeBarras            := fSetCodigoDeBarras;
      SBoleto1Via.DataDocumento             := fSetDataDocumento;
      SBoleto1Via.DataProcessamento         := fSetDataProcessamento;
      SBoleto1Via.DataVencimento            := fSetDataVencimento;
      SBoleto1Via.EnderecoAvalista          := fSetEnderecoAvalista;
      SBoleto1Via.EnderecoCedente           := fSetEnderecoCedente;
      SBoleto1Via.EnderecoSacador           := fSetEnderecoSacador;
      SBoleto1Via.EspecieDocumento          := fSetEspecieDocumento;
      SBoleto1Via.EspecieMoeda              := fSetEspecieMoeda;
      SBoleto1Via.INSSAC                    := fSetINSSAC;
      SBoleto1Via.Instrucao1                := fSetInstrucao1;
      SBoleto1Via.Instrucao2                := fSetInstrucao2;
      SBoleto1Via.Instrucao3                := fSetInstrucao3;
      SBoleto1Via.Instrucao4                := fSetInstrucao4;
      SBoleto1Via.Instrucao5                := fSetInstrucao5;
      SBoleto1Via.Instrucao6                := fSetInstrucao6;
      SBoleto1Via.Instrucao7                := fSetInstrucao7;
      SBoleto1Via.Instrucao8                := fSetInstrucao8;
      SBoleto1Via.LinhaDigitavel            := fSetLinhaDigitavel;
      SBoleto1Via.LocalExtensao             := fSetLocalExtensao;
      SBoleto1Via.LocalPagamento            := fSetLocalPagamento;
      SBoleto1Via.NomeCedente               := fSetNomeCedente;
      SBoleto1Via.NomeSacador               := fSetNomeSacador;
      SBoleto1Via.NossoNumero               := fSetNossoNumero;
      SBoleto1Via.NumeroDaParcela           := fSetNumeroDaParcela;
      SBoleto1Via.NumeroDocumento           := fSetNumeroDocumento;
      SBoleto1Via.NumeroDocumentoSemParcela := strNumDocumentoSemParcela;
      SBoleto1Via.OutrosAcrescimos          := fSetOutrosAcrescimos;
      SBoleto1Via.Pagador                   := fSetPagador;
      SBoleto1Via.SacadorAvalista           := fSetSacadorAvalista;
      SBoleto1Via.TotalDeParcelas           := fSetTotalDeParcelas;
      SBoleto1Via.UsoDoBanco                := fSetUsoDoBanco;
      SBoleto1Via.ValorDaMoeda              := fSetValorDaMoeda;
      SBoleto1Via.ValorDocumento            := fSetValorDocumento;
      SBoleto1Via.CodCliente                := fSetCodCliente;
      SBoleto1Via.CodEmpresa                := fSetCodEmpresa;
      SBoleto1Via.EspecieDup                := fSetEspecieDup;

      FBoleto1ViaList.Add(SBoleto1Via);

      Result := True;
    end;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TBoleto.fAdicionarBoleto1Via]');
      Result := False;
    End;
  End;
end;

function TBoleto1Via_ComprovanteBuilder.fGetListaArquivosGerados(ALimparListaAposRetorno : Boolean): String;
begin
  Result := FListaArquivosGerados.CommaText;
  if ALimparListaAposRetorno then
    FListaArquivosGerados.Clear;
end;

function TBoleto1Via_ComprovanteBuilder.fGetListaBoleto1Via(ANumeroDocumentoSemParcela: String): TList<TBoleto1Via_Comprovante>;
var SBoleto1Via : TBoleto1Via_Comprovante;
begin
  Result := nil;

  for SBoleto1Via in FBoleto1ViaList do
    if SBoleto1Via.NumeroDocumentoSemParcela = ANumeroDocumentoSemParcela then
    begin
      if not Assigned(Result) then
        Result := TList<TBoleto1Via_Comprovante>.Create;

      Result.Add(SBoleto1Via);
    end;
end;

function TBoleto1Via_ComprovanteBuilder.fGetNumeroDuplicatasDistintas: TStringList;
var SBoleto1Via : TBoleto1Via_Comprovante;
begin
  Result := TStringList.Create;

  for SBoleto1Via in FBoleto1ViaList do
  begin
    if Result.IndexOf(SBoleto1Via.NumeroDocumentoSemParcela) = -1 then
      Result.Add(SBoleto1Via.NumeroDocumentoSemParcela);
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fQryAgrupamento(strNumDup, strCodEmp, strCodCli: String): TUniQuery;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                     ';
  strSQL := strSQL + '  CTR_NUMDUP,              ';
  strSQL := strSQL + '  CTR_PARCEL,              ';
  strSQL := strSQL + '  CTR_ESPDOC,              ';
  strSQL := strSQL + '  CTR_CODEMP,              ';
  strSQL := strSQL + '  CTR_DTAVEN,              ';
  strSQL := strSQL + '  CTR_VALORI,              ';
  strSQL := strSQL + '  CTR_VALDUP + CTR_VALJUR AS CTR_VALCOR ';
  strSQL := strSQL + 'FROM                       ';
  strSQL := strSQL + '  DUPAGR                   ';
  strSQL := strSQL + 'WHERE CTR_NUMAGR = :NUMDUP ';
  strSQL := strSQL + '  AND CTR_EMPAGR = :CODEMP ';
  strSQL := strSQL + '  AND CTR_CODCLI = :CODCLI ';

  Result := fCriaQuery();
  With Result Do
  Begin
    SQL.Text := strSQL;
    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;
    Open;
  End;
end;

function TBoleto1Via_ComprovanteBuilder.fImprimiBoleto1Via(AForcarImpressao : Boolean;
                                                 ANomeForm, ANomeFilaImpresso : String;
                                                 blnPreview: Boolean = False; blnEnvioAutmaticoEmail: Boolean = False;
                                                 blnBolEnvEmail: Boolean = False;
                                                 blnEnvioFaturamento: Boolean = False): Boolean;
var SCdsBoleto1Via  : TAureliusDataset;
    SDataSouce       : TDataSource;
    SqryCfgRel       : TUniQuery;
    strTipImp        : String;
    SListaDuplicatas : TStringList;
    SIdx             : Integer;
    SBoleto1ViaList  : TList<TBoleto1Via_Comprovante>;
    frmQckBancos     : TfrmQckBancos;
    CpfCnpj : String;
begin
  Result := True;
  blnPegImp := blnPreview;
  try

    {**************************************************************}
    {*PEGANDO AS DUPLICATAS DISTINTAS, SEM CONSIDERAR AS PARCELAS,*}
    {*ASSIM SERÁ GERADO UM ARQUIVO PARA CADA DUPLICATA COMPOSTO   *}
    {*COM TODAS AS PARCELAS DA DUPLICATA                          *}
    {***********************************************************GD*}
    SListaDuplicatas := fGetNumeroDuplicatasDistintas;

    for SIdx := 0 to SListaDuplicatas.Count - 1 do
    begin
      {*************************************}
      {*LISTA COM AS PARCELAS DA DUPLICATA *}
      {**********************************GD*}
      SBoleto1ViaList := fGetListaBoleto1Via(SListaDuplicatas.Strings[SIdx]);

      if not Assigned(SBoleto1ViaList) then
        continue;

      SCdsBoleto1Via := TAureliusDataset.Create(Self);
      SDataSouce      := TDataSource.Create(Self);
      SqryCfgRel      := fCriaQuery;
      pCriarFormularios(TfrmQckBancos, frmQckBancos);

      try
        frmQckBancos.frxPDFExport.ShowDialog                 := True;
        frmQckBancos.frxPDFExport.ShowProgress               := True;
        frmQckBancos.frxBoleto1Via_Comprovante.ShowProgress             := True;
        frmQckBancos.frxBoleto1Via_Comprovante.EngineOptions.SilentMode := True;

        SCdsBoleto1Via.SetSourceList(SBoleto1ViaList);
        SCdsBoleto1Via.Open;
        SDataSouce.DataSet                 := SCdsBoleto1Via;
        frmQckBancos.dsBoleto1Via_Comprovante.DataSet := SDataSouce.DataSet;

        pSetObjetosPreImpressao(frmQckBancos);

        If ( blnBolEnvEmail And (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S') ) Or
           ( blnEnvioAutmaticoEmail and (fCampoTabela('CLI_BOLSEN', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False) = 'S')) then
        begin
          CpfCnpj := fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
          CpfCnpj := Copy(CpfCnpj, 1, 5);

          if not fEmptyStr(CpfCnpj) then
          begin
            frmQckBancos.frxPDFExport.PdfA := False;
            frmQckBancos.frxPDFExport.UserPassword := AnsiString(CpfCnpj);
            frmQckBancos.frxPDFExport.OwnerPassword := AnsiString(CpfCnpj);
            frmQckBancos.frxPDFExport.ProtectionFlags := [ePrint];
          end;
        end;

        TfrxBand(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('chdFichaComImagem')).visible    := False;
        TfrxBand(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('chdFichaComImagemCut')).visible := False;
        TfrxBand(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('chdEspacoEntreBoleto')).visible := True;

        If (Not fEmptyStr(fCfgSis('IMGBOL'))) and FileExists(fCfgSis('IMGBOL')) Then
        begin
          frmQckBancos.frxBoleto1Via_Comprovante.FindObject('chdEspacoEntreBoleto').visible := False;
          frmQckBancos.frxBoleto1Via_Comprovante.FindObject('chdFichaComImagem').visible    := True;
          frmQckBancos.frxBoleto1Via_Comprovante.FindObject('chdFichaComImagemCut').visible := True;
          frmQckBancos.frxBoleto1Via_Comprovante.FindObject('chdFichaSemImagem').visible    := False;
          frmQckBancos.frxBoleto1Via_Comprovante.FindObject('chdFichaSemImagemCut').visible := False;
          TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLogoEmpresa')).Picture.LoadFromFile(fCfgSis('IMGBOL'));
        end;

        frmQckBancos.frxPDFExport.ShowDialog  := False;
        if blnEnvioAutmaticoEmail then
        begin
          frmQckBancos.frxPDFExport.ShowProgress   := False;
          frmQckBancos.frxBoleto1Via_Comprovante.ShowProgress := False;
          frmQckBancos.frxBoleto1Via_Comprovante.EngineOptions.SilentMode := True;
        end;

        frmQckBancos.frxBoleto1Via_Comprovante.PrepareReport;

        //frmQckBancos.frxBoleto1Via_Comprovante.DesignReport();


        frmQckBancos.frxPDFExport.FileName    := SListaDuplicatas.Strings[SIdx] + '.pdf';
        frmQckBancos.frxPDFExport.DefaultPath := ExtractFilePath(Application.ExeName) + '\Boletos';
        frmQckBancos.frxBoleto1Via_Comprovante.Export(frmQckBancos.frxPDFExport);

        FListaArquivosGerados.Add(ExtractFilePath(Application.ExeName) + 'Boletos\' + SListaDuplicatas.Strings[SIdx] + '.pdf');

        If ((Not blnBolPdf) Or AForcarImpressao) Then
        Begin
          If fEmptyStr(ANomeFilaImpresso) And (Not blnPreview) Then
          Begin
            pCarregaConfImpr(SqryCfgRel, 'frmImpBoletoIndiv');
            fPreImpressao(SqryCfgRel, ANomeFilaImpresso, strTipImp, False);
            ANomeForm := 'frmImpBoletoIndiv';
          End;

          frmQckBancos.frxBoleto1Via_Comprovante.PrintOptions.Printer := AnsiReplaceStr(ANomeFilaImpresso,'\\' + fRetNomeRede + '\','');

          If Not fEmptyStr(ANomeFilaImpresso) Then
            frmQckBancos.frxBoleto1Via_Comprovante.PrintOptions.ShowDialog := False;

          If Not( blnPegImp ) Then
          Begin
            If frmQckBancos.frxBoleto1Via_Comprovante.PrepareReport Then
              pPrintReport(ANomeForm, 'Impressão boleto 1 Via com comprovante', ANomeFilaImpresso, frmQckBancos.frxBoleto1Via_Comprovante);
          End
          Else
            pPreviewReport(ANomeForm, 'Impressão boleto 1 Via com comprovante', frmQckBancos.frxBoleto1Via_Comprovante);

        End;

      finally
        FreeAndNil(frmQckBancos);
        FreeAndNil(SCdsBoleto1Via);
        FreeAndNil(SDataSouce);
        FreeAndNil(SqryCfgRel);
      end;
    end;

    FBoleto1ViaList.Clear;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TBoleto.fImprimiBoleto1Via]');
      Result := False;
    End;
  end;
end;

{ TBoleto1Via_Comprovante }

function TBoleto1Via_ComprovanteBuilder.fSetAceite: String;
begin
  if (FBancoSelecionado = '001') Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '981') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') then
  begin
    Result := IIF(strIdeAce = 'S', 'Sim', 'Não');
  end
  else
  if Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0 then
  begin
    If (strBraCrr = 'S') and (strBcoIni = '090') and (strEstCed = 'SP') Then
      Result := IIF(strIdeAce = 'S', 'S', 'N')
    else
      Result := IIF(strIdeAce = 'S', 'Sim', 'Não');
  end
  else
  If (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '041') then
  begin
    Result := IIF(strIdeAce = 'S', 'A', 'N');
  end
  else
  If FBancoSelecionado = '748' then
  begin
    Result := IIF(strIdeAce = 'S', 'S', 'N');
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetAgenciaCedente: String;
var SAgenciaCedente : String;
begin
  if FBancoSelecionado = '001' then
  begin
    If Assigned(TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi)) Then
    Begin
      SAgenciaCedente := TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).BeneficiarioAgencia;
      SAgenciaCedente := SAgenciaCedente + fStrZero(TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).BeneficiarioContaCorrente, 7);
      Insert('/', SAgenciaCedente, 5);
    End
    Else If fEmptyStr(strDigAge) Then
    Begin
      SAgenciaCedente := strNumAge + fStrZero(strCodCed, 7);
      Insert('/', SAgenciaCedente, 5);
    End
    Else
    Begin
      SAgenciaCedente := strNumAge + strDigAge + fStrZero(strCodCed, 7);
      Insert('-', SAgenciaCedente, 5);
      Insert('/', SAgenciaCedente, 7);
      Insert(' ', SAgenciaCedente, 8);
      Insert('-', SAgenciaCedente, 17);
    End;

    Result := SAgenciaCedente;
  end
  else
  if Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0 then
  begin
    If (FBancoSelecionado <> '993') And (FBancoSelecionado <> '992') then
      Result := strNumAge + strDigAge + strCodCed + IIF(strBraCrr = 'S', Trim(strDigCed), '')
    else
      Result := strNumAge + strDigAge + strCodCed;

    Insert('-', Result, 5);
    Insert('/', Result, 7);
    Insert('-', Result, 15);
  end
  else
  If (FBancoSelecionado = '341') Or (FBancoSelecionado = '995') Or (FBancoSelecionado = '981') Then
  begin
    Result := strNumAge + strCodCed;
    Insert('/', Result, 5);
    Insert('-', Result, 11);
  end
  else
  If FBancoSelecionado = '104' then
  begin
    Result := strNumAge + strDigAge + strCodCed;

    //* SISTEMA DE COBRANÇA SICOB *//
    If (Pos(strCodCar, '_11_12_14_41') >= 1)                 And
       (fEmptyStr(Trim(strSisCob)) Or (strSisCob = 'SICOB')) Then
    Begin
      Result := strNumAge + LeftStr(strCodCed, 12);
      Insert('.',Result, 5);
      Insert('.',Result, 9);
      Insert('-',Result, 18);
    End

    // SISTEMA DE COBRANÇA SIGCB
    Else If (Pos(strCodCar, '_14_24') > 0)                        And
            (fEmptyStr(Trim(strSisCob)) Or (strSisCob = 'SIGCB')) Then
    Begin
      Result := strNumAge + LeftStr(strCodCed, 6);
      Insert('.',Result, 5);
      Result := Result + '-' + strDigCed;
    End

    //* SISTEMA DE COBRANÇA SINCO nn16p *//
    Else If (Pos(strCodCar, '_08') >= 1)                            And
            ((fEmptyStr(Trim(strSisCob))) Or (strSisCob = 'SINCO')) Then
    Begin

      Result := strNumAge + LeftStr(strCodCed, 12);
      Insert('.',Result, 5);
      Insert('.',Result, 9);
      Insert('-',Result, 18);

    End

    //* SISTEMA DE COBRANÇA SINCO *//
    Else If (StrToInt(Trim(strCodCar)) = 01)                        And
            ((fEmptyStr(Trim(strSisCob))) Or (strSisCob = 'SINCO')) Then
    Begin
      Result := strNumAge + LeftStr(strCodCed, 6);
      Insert('.',Result, 5);
    End;
  end
  else
  If (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '090') then
  begin
    If fEmptyStr(strDigAge) Then
    Begin
      Result := strNumAge + fStrZero(strCodCed, 7);
      Insert('/', Result, 5);
    End
    Else
    Begin
      Result := strNumAge + strDigAge + fStrZero(strCodCed, 7);
      Insert('-', Result, 5);
      Insert('/', Result, 7);
      Insert(' ', Result, 8);
      Insert('-', Result, 15);
    End;
  end
  else
  If FBancoSelecionado = '748' then
  begin
    Result := strNumAge + fStrZero(strCodCed, 7);
    Insert('.', Result, 5);
    Insert('.', Result, 8);
  end
  else
  If FBancoSelecionado = '756' then
  begin
    Result := strNumAge + strCodCed;
    Insert('/', Result, 5);
  end
  else
  If FBancoSelecionado = '041' then
  begin
    Result := strNumAge + strDigAge + strCodCed;
    Insert('.', Result, 05);
    Insert(' ', Result, 08);
    Insert('.', Result, 15);
    Insert('.', Result, 17);
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetBeneficiario: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := 'Beneficiário';
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetCarteira: String;
begin
  if FBancoSelecionado = '001' then
  begin
    If Assigned(TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi)) Then Result := strCodCar
    Else Result := strCodCar + IIF(strBB_Crr <> 'S','/' + strVariac, '');
  end
  else
  if (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := strCodCar;
  end
  else
  If FBancoSelecionado = '104' then
  begin
    If (fEmptyStr(Trim(strSisCob))) Or
       (strSisCob = 'SICOB')        Or
       (strSisCob = 'SINCO')        Then
    Begin
      If strCodCar = '11' Then
        Result := 'CS'
      Else If strCodCar = '12' Then
        Result := 'CR'
      Else If (strCodCar = '14') Or (strCodCar = '24') Then
        Result := 'SR'
      Else If strCodCar = '41' Then
        Result := 'DE'
      Else
      If ((strCodCar = '1') Or (strCodCar = '01')) Then
        Result := 'RG'
      Else
        Result := strCodCar;
    End
    Else If strSisCob = 'SIGCB' Then
      Result := IIF(strCodCar = '14', 'RG', 'SR')
    Else
      Result := strCodCar;
  end
  else
  If FBancoSelecionado = '033' then
  begin
    Result := '';
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetCarteira2: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := '';
  end
  else
  if FBancoSelecionado = '033' then
  begin
    If strCodCar = '4' Then
      Result := 'CSR'
    Else
      Result := 'RCR';

    Result := 'COBRANCA SIMPLES - ' + Result;
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetCedente: String;
begin
  if FBancoSelecionado = '001' then
  begin
    Result := 'Código do Beneficiário';
  end
  else
  if (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := 'Cód. Beneficiário';
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetCidadeSacador: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac;
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetCodigoBanco: String;
begin
  if FBancoSelecionado = '001' then
  begin
    Result := '001-9';
  end
  else
  if Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0 then
  begin
    Result:= '237-2';
  end
  else
  If (FBancoSelecionado = '341') Or (FBancoSelecionado = '995') Or (FBancoSelecionado = '981') Then
  begin
    Result := '341-7';
  end
  else
  If FBancoSelecionado = '104' then
  begin
    Result := '104-0';
  end
  else
  If FBancoSelecionado = '033' then
  begin
    Result := '033-7';
  end
  else
  If FBancoSelecionado = '748' then
  begin
    Result := '748-X';
  end
  else
  If FBancoSelecionado = '090' then
  begin
    Result := '090-6';
  end
  else
  If FBancoSelecionado = '756' then
  begin
    Result := '756-0';
  end
  else
  If FBancoSelecionado = '041' then
  begin
    Result := '041-8';
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetCodigoDeBarras: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := strCodBar;
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetDataDocumento: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetDataProcessamento: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetDataVencimento: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetEnderecoAvalista: String;
begin
  if (FBancoSelecionado = '001') Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '981') Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := '';
  end
  else
  if (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0) Or
     (FBancoSelecionado = '748') then
  begin
    Result:= IIF(fEmptyStr(strBenefi), '', strEndere);

    if (FBancoSelecionado = '099') Or (FBancoSelecionado = '084') then
      Result := strEndere
    else
    If (FBancoSelecionado <> '993') And (FBancoSelecionado <> '992') then
    Begin
      If strBraCrr = 'S' Then
      Begin
        Result := IIF(fEmptyStr(strBenefi), '', strEndere);

        if fEmptyStr(strBenefi) then
        begin
          Result := IfThen(Not fEmptyStr(strEndCed), strEndCed + ' ' + strCompCed + ' - ' + strBaiCed + ' ' +
                          strCidCed + ' - ' + strEstCed + ' - ' + fFormataCEP(strCepCed), '');
        end;
      End;
    End
    Else
    Begin
      Result := strEndere;
    end;
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetEnderecoCedente: String;
begin
  if FBancoSelecionado = '001' then
  begin
    If strBB_Crr <> 'S' Then
      Result := strEndere
    Else
      Result := '';
  end
  else
  if Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0 then
  begin
    If strBcoIni = '993' Then
      Result := 'AV. CIDADE JARDIM 400 -14º AND. SÃO PAULO/SP'
    Else If strBcoIni = '992' Then
      Result := 'AV. DOUTOR CHUCRI ZAIDAN, 1170–TORRE CRISTAL 9ºANDAR–MORUMBI–SÃO PAULO–SP'
    Else If (strBcoIni = '099') Or (strBcoIni = '084') Then
      Result := strEnderecoCoopetativa + ' - ' + strBairroCooperativa + ' ' + strCidadeCooperativa + ' - ' +
                strEstadoCooperativa + ' - ' + fFormataCEP(strCEPCooperativa)
    Else
      Result := IIF(fEmptyStr(strBenefi), strEndere, strEndBen);

    If (FBancoSelecionado <> '993') And (FBancoSelecionado <> '992') then
    Begin
      If strBraCrr = 'S' Then
      Begin
        if fEmptyStr(strBenefi) then
        begin
          Result := IfThen(Not fEmptyStr(strEndCed), strEndCed + ' ' + strCompCed + ' - ' + strBaiCed + ' ' +
                                                 strCidCed + ' - ' + strEstCed + ' - ' + fFormataCEP(strCepCed), '');
        end;
      End;
    End;

  end
  else
  If ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
      (FBancoSelecionado = '981') Or
      (FBancoSelecionado = '104') Or
      (FBancoSelecionado = '033') Or
      (FBancoSelecionado = '090') Or
      (FBancoSelecionado = '756') Or
      (FBancoSelecionado = '041') Then
  begin
    Result := strEndere;
  end
  else
  If FBancoSelecionado = '748' then
  begin
    Result := IIF(fEmptyStr(strBenefi), strEndere, strEndBen);
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetEnderecoSacador: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result :=  strEndSac + ' - ' + strBaiSac;
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetEspecieDocumento: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '090') then
  begin
    Result := 'DM';
  end
  else
  if FBancoSelecionado = '748' then
  begin
    Result := 'A';
  end
  else
  if FBancoSelecionado = '756' then
  begin
    if strEspeci <> '' then
    begin
      if ((Copy(strEspDoc, 1, 2) <> '25') and (Copy(strEspDoc, 1, 2) <> '99')) then
        Result := Trim(Copy(strEspDoc, 6, 3))
      else
        Result := 'DM';
    end
    else
      Result := 'DM';
  end
  else
  If FBancoSelecionado = '041' then
  begin
    Result := strEspDoc;
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetEspecieMoeda: String;
begin
  if FBancoSelecionado = '001' then
  begin
    Result := 'Espécie';
  end
  else
  if (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := 'Esp. Moeda';
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetINSSAC: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    If Length(Trim(strNuInSa)) > 11 Then
      Result := fMaskCNPJ(strNuInSa)
    Else
      Result := fMaskCPF(strNuInSa);
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetInstrucao1: String;
begin
  if (FBancoSelecionado = '001') Or
     (FBancoSelecionado = '033') then
  begin
    Result := IIF(fltVlrMor > 0, 'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '         ', '') +
              IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');
  end
  else
  if Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0 then
  begin
    If (strBraCrr = 'S') and (strbcoIni <> '090') Then
    Begin
      Result := 'ESTE BOLETO REPRESENTA DUPLICATA CEDIDA FIDUCIARIAMENTE AO BANCO SAFRA S/A,'
                                             +'FICANDO VEDADO O PAGAMENTO DE QUALQUER OUTRA FORMA QUE NÃO ATRAVÉS DO PRESENTE BOLETO.';
    End
    Else
    Begin
      Result := IIF(fltVlrMor > 0,'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor),'') +
                IIF(fltVlrMul > 0,'        APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul),'');
    End;
  end
  else
  If (FBancoSelecionado = '341') Or (FBancoSelecionado = '995') Or (FBancoSelecionado = '981') Then
  begin
    Result :=  IIF(fltVlrMor > 0, 'Após o vencimento cobrar ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' por dia de atraso.','') +
               IIF(fltVlrMul > 0,'        Após o vencimento cobrar multa de ' + FormatFloat('R$ #,##0.00', fltVlrMul),'');
  end
  else
  If FBancoSelecionado = '104' then
  begin
    Result := IIF(fltVlrMor > 0,'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '. ','') +
              IIF(fltVlrMor > 0,' NAO RECEBER O PRINCIPAL SEM JUROS DE MORA. ','') +
              IIF(fltVlrMul > 0,' APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul),'');
  end
  else
  If FBancoSelecionado = '748' then
  begin
    Result := IIF(fltVlrMor > 0, 'APÓS O VENCIMENTO COBRAR ' + FormatFloat('R$ #,##0.00', fltVlrMor) + ' POR DIA DE ATRASO ', '') +
              IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');
  end
  else
  If (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := IIF(fltVlrMor > 0, 'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '         ', '') +
              IIF(fltVlrMul > 0, 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul), '');
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetInstrucao2: String;
begin
  if (FBancoSelecionado = '001') Or
     (FBancoSelecionado = '033') then
  begin
    If StrToIntDef(strPraPro,0) >= 1 Then
    Begin
      If Assigned(TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi)) Then
        Result := 'PROTESTAR NO ' + strPraPro + '° DIA ' + IIF((StrToIntDef(strPraPro,0) <= 5), 'ÚTIL', 'CORRIDO') + ' APÓS O VENCIMENTO'
      Else
        Result := 'PROTESTAR NO ' + strPraPro + '° DIA ' + IIF(strTipDia = '1', 'ÚTIL', 'CORRIDO') + ' APÓS O VENCIMENTO';
    End
    Else
      Result  := '';
  end
  else
  if Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0 then
  begin
    If (strBraCrr = 'S') and (strbcoIni <> '090') Then
    Begin
      Result :=  IIF(fltVlrMor > 0,'MORA DIÁRIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor),'')
                                             +IIF(fltVlrMul > 0,' APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul),'')
                                             +IIF(fltVlrMor > 0,', NÃO RECEBER O PRINCIPAL SEM JUROS DE MORA.','');
    End
    Else
    Begin
      Result := IIF(fltVlrMor > 0,'NAO RECEBER O PRINCIPAL SEM JUROS DE MORA','');
    End;
  end
  else
  If (FBancoSelecionado = '341') Or (FBancoSelecionado = '995') Or (FBancoSelecionado = '981') Then
  begin
    If StrToIntDef(strPraPro,0) >= 1 Then
    Begin
      If (strCdIns1 = '66') Or (strCdIns2 = '66') Then
      Begin
        If StrToIntDef(strPraPro,0) = 1 Then
          Result := 'SUJEITO A NEGATIVAÇÃO APÓS ' + strPraPro + ' DIA DO VENCIMENTO'
        Else
          Result := 'SUJEITO A NEGATIVAÇÃO APÓS ' + strPraPro + ' DIAS DO VENCIMENTO';
      End
      Else If (strCdIns1 = '9') Or (strCdIns1 = '09') Or (strCdIns1 = '34') Or (strCdIns1 = '35') Or (strCdIns1 = '42') Or (strCdIns1 = '81') Or (strCdIns1 = '82') Or
              (strCdIns2 = '9') Or (strCdIns2 = '09') Or (strCdIns2 = '34') Or (strCdIns2 = '35') Or (strCdIns2 = '42') Or (strCdIns2 = '81') Or (strCdIns2 = '82') Then
      Begin
        If StrToIntDef(strPraPro,0) = 1 Then
          Result := 'PROTESTAR APÓS ' + strPraPro + ' DIA ' + IIF(strTipDia = '1', 'ÚTIL', 'CORRIDO') + ' DO VENCIMENTO'
        Else
          Result := 'PROTESTAR APÓS ' + strPraPro + ' DIAS ' + IIF(strTipDia = '1', 'ÚTEIS', 'CORRIDOS') + ' DO VENCIMENTO';
      End
      Else If (strCdIns1 = '91') Or (strCdIns2 = '91') Then
      Begin
        If StrToIntDef(strPraPro,0) = 1 Then
          Result := 'NÃO RECEBER APÓS ' + strPraPro + ' DIA DO VENCIMENTO'
        Else
          Result := 'NÃO RECEBER APÓS ' + strPraPro + ' DIAS DO VENCIMENTO';
      End
      Else
        Result := '';
    End
    Else
      Result := '';
  end
  else
  If FBancoSelecionado = '104' then
  begin
    If StrToIntDef(strPraPro,0) >= 1 Then
      Result := 'PROTESTAR APOS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO'
    Else Result := '';
  end
  else
  If FBancoSelecionado = '748' then
  begin
    If StrToIntDef(strPraPro,0) >= 1 Then
      Result := 'PROTESTAR APÓS ' + strPraPro + ' DIAS ' + IIF(StrToInt(strPraPro) > 4, 'CORRIDOS', 'ÚTEIS') + ' DO VENCIMENTO'
    Else
      Result := '';
  end
  else
  If FBancoSelecionado = '090' then
  begin
    Result := '';
  end
  else
  If (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := IIF(fltVlrMor > 0,'NÃO RECEBER O PRINCIPAL SEM JUROS DE MORA','');
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetInstrucao3: String;
begin
  if (FBancoSelecionado = '001') Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '981') Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') then
  begin
    Result := strInstr1;
  end
  else
  if Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0 then
  begin
    If (strBraCrr = 'S') and (strbcoIni <> '090') Then
    Begin
      If (StrToIntDef(strPraPro,0) >= 1) And (LeftStr(strCdIns1, 2) <> '07') Then
        Result := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO'
      Else If (StrToIntDef(strPraPro,0) >= 1) And (LeftStr(strCdIns1, 2) = '07') Then
        Result := 'SUJEITO A NEGATIVAÇÃO APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + ' DO VENCIMENTO'
      Else
        Result := '';
    End
    Else
    Begin
      If (StrToIntDef(strPraPro,0) >= 1) And (LeftStr(strCdIns1, 2) <> '07') Then
        Result := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO'
      Else If (StrToIntDef(strPraPro,0) >= 1) And (LeftStr(strCdIns1, 2) = '07') Then
        Result := 'SUJEITO A NEGATIVAÇÃO APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,' DIA ', ' DIAS ') + ' DO VENCIMENTO'
      Else
        Result := '';
    End;
  end
  else
  If FBancoSelecionado = '756' then
  begin
    Result := '';
    If (Not fEmptyStr(strCodProt)) Then
    Begin
      strPraPro := IIF(strCodProt = '3', '0', strPraPro);
      If (StrToIntDef(strPraPro,0) >= 1) Then
      Begin
        If strCodProt = '1' Then
          Result := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,
                    ' DIA CORRIDO ',
                    ' DIAS CORRIDOS ') + 'DO VENCIMENTO'
        Else
          Result := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,
                    ' DIA ÚTIL ',
                    ' DIAS ÚTEIS ') + 'DO VENCIMENTO';
      End;
    End
    Else If (StrToIntDef(strPraPro,0) >= 1) Then
      Result := 'PROTESTAR APÓS ' + strPraPro + IIF(StrToInt(strPraPro) = 1,
                ' DIA ',
                ' DIAS ') + 'DO VENCIMENTO';
  end
  else
  If FBancoSelecionado = '041' then
  begin
    If StrToIntDef(strPraPro,0) >= 1 Then
    Begin
      If StrToIntDef(strPraPro,0) = 1 Then
        Result := 'PROTESTAR APOS ' + strPraPro + ' DIA DO VENCIMENTO'
      Else
        Result := 'PROTESTAR APOS ' + strPraPro + ' DIAS DO VENCIMENTO';
    End
    Else
      Result := '';
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetInstrucao4: String;
begin
  if (FBancoSelecionado = '001') Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '981') Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') then
  begin
    Result := strInstr2;
  end
  else
  if (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0) Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := strInstr1;
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetInstrucao5: String;
begin
  if (FBancoSelecionado = '001') Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '981') Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') then
  begin
    Result := strInstr3;
  end
  else
  if (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0) Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := strInstr2;
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetInstrucao6: String;
begin
  if (FBancoSelecionado = '001') Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '981') Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') then
  begin
    Result := strInstr4;
  end
  else
  if (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0) Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := strInstr3;
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetInstrucao7: String;
begin
  if (FBancoSelecionado = '001') Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '981') Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') then
  begin
    Result := strInstr5;
  end
  else
  if (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0) Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := strInstr4;
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetInstrucao8: String;
begin
  if (FBancoSelecionado = '001') Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '981') Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') then
  begin
    Result := '';
  end
  else
  if (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0) Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    If (strBraCrr = 'S') and (strbcoIni <> '090') Then
    Begin
      Result := ''
    End
    Else
    Begin
      Result := strInstr5;
    End;
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetLinhaDigitavel: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := strLinDig;
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetLocalExtensao: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := '';
  end
  else
  if (FBancoSelecionado = '341') Or (FBancoSelecionado = '995') Or (FBancoSelecionado = '981') then
  begin
    Result := 'ATÉ O VENCIMENTO EM QUALQUER BANCO OU CORRESPONDENTE NÃO BANCÁRIO. APÓS O';
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetLocalPagamento: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0) Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := 'PAGÁVEL EM QUALQUER BANCO.';

    If (strBraCrr <> 'S')  and
       (strBcoIni = '237') Then
      Result := 'PAGÁVEL PREFERENCIALMENTE NA REDE BRADESCO OU BRADESCO EXPRESSO.';
  end
  else
  if (FBancoSelecionado = '341') Or (FBancoSelecionado = '995') Or (FBancoSelecionado = '981') then
  begin
    Result := 'VENCIMENTO, ACESSE ITAU.COM.BR/BOLETOS E PAGUE EM QUALQUER BANCO OU CORRESPONDENTE NÃO BANCÁRIO.';
  end
  else
  If FBancoSelecionado = '104' then
  begin
    Result := 'PREFERENCIALMENTE NAS CASAS LOTÉRICAS ATÉ O VALOR LIMITE.';
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetNomeCedente: String;
begin
  if (FBancoSelecionado = '001') Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '981') Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    If strBB_Crr <> 'S' Then
    Begin
      If Trim(strNumIns) <> '' Then
      Begin
        If strTipIns = '01' Then
          Result := strNomCed + '   ' + fMaskCNPJ(strNumIns)
        Else
          Result := strNomCed + '   ' + fMaskCPF(strNumIns);
      End
      Else
        Result := strNomCed;
    End
    Else
      Result := 'VIDE CAMPO SACADOR/AVALISTA ABAIXO';
  end
  else
  if Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0 then
  begin
    If strBcoIni = '993' Then
    Begin
      Result := 'RED S.A – CNPJ 67.915.785/0001-01 ';
    End
    Else If strBcoIni = '992' Then
    Begin
      Result := 'CREDIT BRASIL FOMENTO MERCANTIL S.A. – CNPJ 08.839.442/0001-38';
    End
    Else If (strBcoIni = '099') Or (strBcoIni = '084') Then
    Begin
      Result := strRazaoSocialCooperativa + '   ' + fMaskCNPJ(strIncrisaoCooperativa);
    End
    Else
    Begin
      If Trim(strNumIns) <> '' Then
      Begin
        If strTipIns = '01' Then
          Result := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCNPJ(strNumIns), strBenefi)
        Else
          Result := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCPF(strNumIns), strBenefi);
      End
      Else
        Result := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);
    End;

    If (FBancoSelecionado <> '993') And (FBancoSelecionado <> '992') then
    Begin
      If strBraCrr = 'S' Then
      Begin
        if fEmptyStr(strBenefi) then
        begin
          Result := strDesCed + IfThen(Not fEmptyStr(strCgcCed),' - ' + fMaskCNPJ(strCgcCed),'');
        end;
      End;
    End;
  end
  else
  If FBancoSelecionado = '748' then
  begin
    If Trim(strNumIns) <> '' Then
    Begin
      If strTipIns = '01' Then
        Result := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCNPJ(strNumIns), strBenefi)
      Else
        Result := IIF(fEmptyStr(strBenefi), strNomCed + '   ' + fMaskCPF(strNumIns), strBenefi);
    End
    Else
      Result := IIF(fEmptyStr(strBenefi), strNomCed, strBenefi);
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetNomeSacador: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := strNomSac;
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetNossoNumero: String;
begin
  if FBancoSelecionado = '001' then
  begin
    If Assigned(TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi)) Then
    Begin
      Result := TRetornoBoletoBancoDoBrasil(LRetornoRegistroBoletoApi).nossoNumero;
    End
    Else If strBB_Crr <> 'S' Then
    Begin
      If ((RightStr(Trim(strCodCar), 2) = '16') Or (RightStr(Trim(strCodCar), 2) = '18')) And (Length(strNumCon) <= 6) Then
      Begin
        If (RightStr(Trim(strCodCar), 2) = '18') Then
        Begin
          Result := fStrZero(Copy(strNosNum, 1, Length(strNosNum)-1),17);
        End
        Else
        Begin
          Result := strNumCon + strNosNum;
        End;
      End
      Else If ((RightStr(Trim(strCodCar), 2) = '18')) And (Length(strNumCon) >= 7) Then
      Begin
        Result := strNumCon + RightStr(Trim(strNosNum), 10);
      End
      Else If (RightStr(Trim(strCodCar), 2) = '17') And (Length(strNumCon) >= 7) Then
      Begin
        Result := strNumCon + strNosNum;
      End
      Else If (RightStr(Trim(strCodCar), 2) = '17') And (Length(strNumCon) = 6) Then
      Begin
        Result := strNumCon + RightStr(strNosNum,6);
        Insert('-', Result, 12);
      End
      Else If ((RightStr(Trim(strCodCar), 2) = '12')) Then
      Begin
        Result := strNumCon + strNosNum;
        Insert('.', Result , 12);
      End
      Else
      Begin
        Result := strNumCon + strNosNum;
      End;
    End
    Else
      Result := strNosNum;
  end
  else
  if Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0 then
  begin
    Result := strCodCar + strNosNum;
    If strBraCrr <> 'S' Then
    Begin
      If (FBancoSelecionado = '237') And Not(Length(Trim(strCodCar)) > 2)  Then
      Begin
        Insert('/', Result , 3);
        Insert('-', Result , 15);
      End
      Else
      Begin
        Insert('/', Result , 4);
        Insert('-', Result , 16);
      End;
    End
    Else
    Begin
      if (strBcoIni = '090') and (strEstCed = 'SP') then
      begin
        Insert('/', Result , 3);
      end
      else
      begin
        Insert('/', Result , 3);
        Insert(' ', Result , 4);
        Insert(' ', Result , 7);
        Insert(' ', Result , 17);
      end;
    End;
  end
  else
  If (FBancoSelecionado = '341') Or (FBancoSelecionado = '995') Or (FBancoSelecionado = '981') Then
  begin
    Result := strCodCar + strNosNum;
    Insert('/', Result, 4);
    Insert('-', Result, 13);
  end
  else
  If FBancoSelecionado = '104' then
  begin
   Result := strNosNum;

    If (fEmptyStr(Trim(strSisCob))) Or
       (strSisCob = 'SICOB')        Or
       (strSisCob = 'SINCO')        Then
    Begin
      If Pos(strCodCar, '_11_12_14_41') > 0 Then
      Begin
        Insert('-',Result, 11);
      End

      // SISTEMA DE COBRANÇA SIGCB
      Else If Pos(strCodCar, '_24') > 0 Then
      Begin
        Result := '24' + Result;
        Insert('-',Result, 18);
      End

      //* SISTEMA DE COBRANÇA SINCO nn16p*//
      Else If Pos(strCodCar, '_08') > 0 Then
      Begin
        Result := '8' + fStrZero(Result,15);
        Insert('-',Result, 16);
      End

      //* SISTEMA DE COBRANÇA SINCO *//
      Else If StrToInt(Trim(strCodCar)) = 01 Then
      Begin
        Result := '9000000' + Result;
        Insert('.',Result, 19);
      End;
    End
    Else
    Begin
      // SISTEMA DE COBRANÇA SIGCB COBRANÇA SIMPLES

      // SISTEMA DE COBRANÇA SIGCB
      If Pos(strCodCar, '_24') > 0 Then
      Begin
        Result := '24' + Result;
        Insert('-',Result, 18);
      End
      Else
      Begin
        Result := '14/' + Result;
        Insert('-',Result, 19);
      End;
    End;
  end
  else
  If FBancoSelecionado = '033' then
  begin
    If ((RightStr(Trim(strCodCar), 2) = '16') Or (RightStr(Trim(strCodCar), 2) = '18')) And (Length(strNumCon) <= 6) Then
    Begin
      If (RightStr(Trim(strCodCar), 2) = '18') Then
      Begin
        Result := fStrZero(Copy(strNosNum, 1, Length(strNosNum)-1),17);
      End
      Else
      Begin
        Result := strNumCon + strNosNum;
        Insert('.', Result, 04);
        Insert('.', Result, 08);
        Insert('.', Result, 12);
        Insert('.', Result, 16);
        Insert('.', Result, 20);
      End;
    End
    Else If ((RightStr(Trim(strCodCar), 2) = '18')) And (Length(strNumCon) >= 7) Then
    Begin
      Result := strNumCon + RightStr(Trim(strNosNum), 10);
      Insert('.', Result, 3);
      Insert('.', Result, 7);
      Insert('.', Result, 11);
      Insert('.', Result, 15);
      Insert('.', Result, 19);
    End
    Else If (RightStr(Trim(strCodCar), 2) = '17') And (Length(strNumCon) >= 7) Then
    Begin
      Result := strNumCon + strNosNum;
    End
    Else If (RightStr(Trim(strCodCar), 2) = '17') And (Length(strNumCon) = 6) Then
    Begin
      Result := strNosNum;
      Insert('-', Result, 12);
    End
    Else If ((RightStr(Trim(strCodCar), 2) = '12')) Then
    Begin
      Result := strNumCon + strNosNum;
      Insert('.', Result, 12);
    End
    Else
    Begin
      Result := strNumCon + strNosNum;
      Insert(' ', Result, 13);
    End;
  end
  else
  If FBancoSelecionado = '748' then
  begin
    Result := strNosNum;
    Insert('/', Result, 3);
    Insert('-', Result, 10);
  end
  else
  If FBancoSelecionado = '090' then
  begin
    Result := strNosNum;
    Insert('-', Result, 11);
    Result := strCodCar + '/' + Result;
  end
  else
  If FBancoSelecionado = '756' then
  begin
    Result := strNosNum;
    Insert('-', Result, 08);
  end
  else
  If FBancoSelecionado = '041' then
  begin
    Result := strNosNum;
    Insert('.', Result, 09);
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetNumeroDaParcela: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    if IsCharAlpha(strParcelaDoDocumento[1]) then
      Result := fRetNumParcela(RightStr(strNumDoc, 1))
    else
      Result := strParcelaDoDocumento;
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetNumeroDocumento: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) then
  begin
    Result := RightStr(IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1)), 10);

    If FApresentarEspDocumento = 'S' Then
      Result := RightStr(Result, Result.Length - 2) + strEspDoc;
  end
  else
  if ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
      (FBancoSelecionado = '981') Or
      (FBancoSelecionado = '033') Or
      (FBancoSelecionado = '748') Or
      (FBancoSelecionado = '090') Or
      (FBancoSelecionado = '756') Or
      (FBancoSelecionado = '041') then
  begin
    Result := IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1));
  end
  else
  If FBancoSelecionado = '104' then
  begin
    Result := RightStr(IfThen(strImprimirParcela = 'S', strNumDoc, LeftStr(strNumDoc, Length(strNumDoc) - 1)), 11)
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetOutrosAcrescimos: String;
begin
  if (FBancoSelecionado = '001') Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '981') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '041') then
  begin
    Result := '';
  end
  else
  if (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '756') then
  begin
    Result := IIF(fltOutAcr > 0, 'R$ ' + FloatToStrF(fltOutAcr, ffNumber, 12, 2), '');
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetPagador: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := 'Pagador';
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetSacadorAvalista: String;
begin
  if FBancoSelecionado = '001' then
  begin
    If strBB_Crr <> 'S' Then
      Result := strObsSac
    Else
    Begin
      If Trim(strNumIns) <> '' Then
      Begin
        If strTipIns = '01' Then
          Result := fMaskCNPJ(strNumIns) + '   ' + strNomCed
        Else
          Result := fMaskCPF(strNumIns) + '   ' + strNomCed;
      End
      Else
        Result := strNomCed;
    End;
  end
  else
  if Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0 then
  begin
    Result := IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));

    if (FBancoSelecionado = '099') Or (FBancoSelecionado = '084') then
      Result := strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), '')
    else
    If (FBancoSelecionado <> '993') And (FBancoSelecionado <> '992') then
    Begin
      If strBraCrr = 'S' Then
      Begin
        Result := strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), '');
      End;
    End
    Else
    Begin
      If strTipIns = '01' Then
        Result := strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + fMaskCNPJ(strNumIns), '')
      Else
        Result := strNomCed + IfThen(Not fEmptyStr(strNumIns),' - ' + fMaskCPF(strNumIns),'');
    end;
  end
  else
  If ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
      (FBancoSelecionado = '981') Or
      (FBancoSelecionado = '104') Or
      (FBancoSelecionado = '033') Or
      (FBancoSelecionado = '090') Or
      (FBancoSelecionado = '756') Or
      (FBancoSelecionado = '041') Then
  begin
    Result := '';
  end
  else
  If FBancoSelecionado = '748' then
  begin
    Result := IIF(fEmptyStr(strBenefi), '', strNomCed + IfThen(Not fEmptyStr(strNumIns),
              ' - ' + IIF(strTipIns = '01', fMaskCNPJ(strNumIns), fMaskCPF(strNumIns)), ''));
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetTotalDeParcelas: String;
var STotalDeparcelas : Integer;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    STotalDeparcelas := fQtdParcelas(strNumDocumentoSemParcela, strCodEmp, strEspDocOriginal, strCodCli);
    Result := IIF(STotalDeparcelas = 0, '1', IntToStr(STotalDeparcelas));
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetUsoDoBanco: String;
begin
  if (FBancoSelecionado = '001') Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '981') Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := '';
  end
  else
  if Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0 then
  begin
    Result := '';

    If (FBancoSelecionado <> '993') And (FBancoSelecionado <> '992') then
    Begin
      If strBraCrr = 'S' Then
      Begin
        if fEmptyStr(strBenefi) then
        begin
          Result := strUsoBco;
        end;
      End;
    End;
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetValorDaMoeda: String;
begin
  if FBancoSelecionado = '001' then
  begin
    Result := '(x) Valor';
  end
  else
  if (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := 'Valor da Moeda';
  end
  else
  If FBancoSelecionado = '104' then
  begin
    Result := 'Valor';
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetValorDocumento: String;
begin
  if (FBancoSelecionado = '001') Or
     (Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_981_906_978_') > 0) Or
    ((FBancoSelecionado = '341') Or (FBancoSelecionado = '995')) Or
     (FBancoSelecionado = '104') Or
     (FBancoSelecionado = '033') Or
     (FBancoSelecionado = '748') Or
     (FBancoSelecionado = '090') Or
     (FBancoSelecionado = '756') Or
     (FBancoSelecionado = '041') then
  begin
    Result := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
  end;
end;

procedure TBoleto1Via_ComprovanteBuilder.pSetObjetosPreImpressao(var frmQckBancos: TfrmQckBancos);
begin
  if FBancoSelecionado = '001' then
  begin
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBrasil.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBrasil.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog3')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBrasil.bmp');
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('memo374')).Text := 'Nosso Número';
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('rllNN3')).Text  := 'Nosso Número';
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('memo11')).Text  := 'Nosso Número';
  end
  else
  if Pos(FBancoSelecionado, '237_099_993_994_992_996_991_989_084_983_990_970_906_978_') > 0 then
  begin
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBradesco.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBradesco.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog3')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBradesco.bmp');
  end
  else
  If (FBancoSelecionado = '341') Or (FBancoSelecionado = '995') Or (FBancoSelecionado = '981') Then
  begin
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoItau.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoItau.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog3')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoItau.bmp');
  end
  else
  If FBancoSelecionado = '104' then
  begin
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoCaixa.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoCaixa.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog3')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoCaixa.bmp');
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('memo374')).Text := 'Nosso Número';
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('rllNN3')).Text  := 'Nosso Número';
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('memo11')).Text  := 'Nosso Número';
  end
  else
  If (FBancoSelecionado = '033') Then
  begin
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSantander.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSantander.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog3')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSantander.bmp');
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('memo374')).Text := 'Nosso Número';
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('rllNN3')).Text  := 'Nosso Número';
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('memo11')).Text  := 'Nosso Número';
  end
  else
  If (FBancoSelecionado = '748') Then
  begin
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSicredi.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSicredi.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog3')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoSicredi.bmp');
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('memo374')).Text := 'Nosso Número';
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('rllNN3')).Text  := 'Nosso Número';
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('memo11')).Text  := 'Nosso Número';
  end
  else
  If (FBancoSelecionado = '090') Then
  begin
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoUnicred.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoUnicred.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog3')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoUnicred.bmp');
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('memo374')).Text := 'Nosso Número';
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('rllNN3')).Text  := 'Nosso Número';
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('memo11')).Text  := 'Nosso Número';
  end
  else
  If (FBancoSelecionado = '756') Then
  begin
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBancoob.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBancoob.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog3')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBancoob.bmp');
  end
  else
  If (FBancoSelecionado = '041') Then
  begin
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBanrisul.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBanrisul.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog3')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoBanrisul.bmp');
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('memo374')).Text := 'Nosso Número';
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('rllNN3')).Text  := 'Nosso Número';
    TfrxMemoView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('memo11')).Text  := 'Nosso Número';
  end
  else
  If (FBancoSelecionado = '133') Then
  begin
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoCresol.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog2')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoCresol.bmp');
    TfrxPictureView(frmQckBancos.frxBoleto1Via_Comprovante.FindObject('imgLog3')).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\LogoBoletos\LogoCresol.bmp');
  end;
end;

function TBoleto1Via_ComprovanteBuilder.fSetCodCliente: String;
begin
  Result := strCodCli;
end;

function TBoleto1Via_ComprovanteBuilder.fSetCodEmpresa: String;
begin
  Result := strCodEmp;
end;

function TBoleto1Via_ComprovanteBuilder.fSetEspecieDup: String;
begin
  Result := strEspeci;
end;

end.
