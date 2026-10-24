unit ImportacaoDados.Controller.ImportarCadastroProspecto;

interface

uses
  Classes, SysUtils, untTValidaExcel, cxProgressBar, System.Generics.Collections, DB, Uni, Variants,
  ImportacaoDados.Interfaces,  ImportacaoDados.Controller.Prospecto,
  ImportacaoDados.Model.ImportacaoArquivo, untTypesSistema;

Type

  TValidacaoDadosImportacaoProspecto = class;

  TImportaPlanilhaProspecto = class(TImportaPlanilha)
  private
    function fInserir: Boolean;
    function fRetornaSQLInsertProspecto: String;
  public
    constructor Create(Const aModelo: IModeloArquivoImportacao; const ACancelouOperacao : TReferenceBooleanFunction); override;
    destructor Destroy; override;
    function fInserirCadastros: Boolean; override;
  End;

  TValidacaoDadosImportacaoProspecto =  Class(TValidacaoDadosImportacao)
  private
    FListaCPFCNPJ: TStringList;
    FSQLSelect: String;
    FQuery: TUniQuery;
    FProspecto:  TProspectoController;

    FIndiceCodCid,
    FIndiceNomCid: Integer;
    FIndiceCodAti,
    FIndiceDesAti,
    FIndiceCodVen,
    FIndiceNomVen,
    FIndiceCodRed,
    FIndiceDesRed,
    FIndiceCrmFre,
    FIndiceDesFre,
    FIndiceCrmCat,
    FIndiceDesCat,
    FIndiceCrmFai,
    FIndiceDesFai,
    FIndiceCrmPor,
    FIndiceDesPor,
    FIndiceEmail1,
    FIndiceEmail2,
    FIndiceEmail3,
    FIndiceStatus,
    FIndiceProCep,
    FIndiceCpfCgc,
    FIndiceTipoCpfCNPJ,
    FIndiceCorreio,
    FIndiceBairro,
    FIndiceEndereco,
    FIndiceUFExpRg,
    FIndiceInscEst,
    FIndiceDatNas: Integer;
    FIndiceCrmFor,
    FIndiceDesFor,
    FIndiceFone01,
    FIndiceFone02,
    FIndiceNumFax,
    FIndiceExpRg,
    FIndiceCelular,
    FIndiceCodRep,
    FIndiceNomRep,
    FIndiceCodReg,
    FIndiceDesReg: Integer;

    function fValidarRegistoDuplicadoArquivo(Const aConteudo: String): Boolean;
    function fValidarRegistoDuplicadoDB(Const aConteudo: String): Boolean;
    function fValidarClienteCadastrado(Const aConteudo: String): Boolean;
    procedure pSetarDados(Const aLinha: ILinha);
    procedure pSetarLinhaPadraoModelo;
    procedure pAdicionaInconsistencia(Const aLinha: ILinha; Const Coluna, Campo, Mensagem: String);
    procedure pAnalisaInconsistenciaCPFCNPJ(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaCidade(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaAtividade(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaVendedor(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaEmail(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaStatus(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaRedeLojas(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaCrmFrequencia(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaCrmCategoria(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaCrmPorte(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaCrmFaixa(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaCep(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaInscricaoEstadual(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaDataNasc(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaCrmFornecedor(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaTelefone(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaRgExp(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaRepresentante(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaRegiao(Const aLinha: ILinha);

  public
    constructor Create(aArquivoImportacao: IImportaPlanilha); override;
    destructor Destroy; override;
    function fValidarLinha(Const aLinha: ILinha): Boolean; override;
    procedure pLimpar; override;
    procedure pAtualizarParametrosValidacao; override;
  End;

implementation

uses
  untFuncoesSimples, untCadCid, untFuncoesGenerica, StrUtils;

{ TImportaPlanilhaProspecto }

constructor TImportaPlanilhaProspecto.Create(Const aModelo: IModeloArquivoImportacao; const ACancelouOperacao : TReferenceBooleanFunction);
begin
  inherited;

  Valida := TValidacaoDadosImportacaoProspecto.Create(Self);

end;

destructor TImportaPlanilhaProspecto.Destroy;
begin

  inherited;
end;

function TImportaPlanilhaProspecto.fInserirCadastros: Boolean;
begin
  Try
    Result := fInserir;
  Except
    Result := False;
  End;
end;

function TImportaPlanilhaProspecto.fRetornaSQLInsertProspecto: String;
var
  intCnt: Integer;
  strCampos, strVlues: String;
begin
  For intCnt := 0 to Modelo.Campos.Count-1 do
  Begin
     If (Pos('PRO_', Modelo.Campos[intCnt].NomeCampo) > 0) Then
     Begin
       strCampos := strCampos + Modelo.Campos[intCnt].NomeCampo + ', ';
       strVlues := strVlues + ':' + Modelo.Campos[intCnt].NomeCampo + ', ';
     End;
  End;

  Result := 'INSERT INTO PROSPE(AUTOINCREM, PRO_CODPRO, ' + strCampos + ' PRO_DTACAD) '+
            'VALUES(:AUTOINCREM, :PRO_CODPRO, ' + strVlues + ' :PRO_DTACAD)';
end;

function TImportaPlanilhaProspecto.fInserir: Boolean;
var
  FQry,
  FQryFor: TUniQuery;
  intCnt,
  intCont: Integer;
  xLinha: ILinha;
  xAutInt: String;
  FSQLInsertFornecedor: String;
begin
  FSQLInsertFornecedor := 'INSERT INTO PROFOR (PRF_CODPRO, PRF_CRMFOR) ' +
                          'VALUES(:PRF_CODPRO, :PRF_CRMFOR)';
  FQry := fCriaQuery(nil);
  FQryFor := fCriaQuery(nil);
  FQry.DisableControls;
  FQryFor.DisableControls;
  Try
    fStartTransaction;
    Try
      FQryFor.Close;
      FQryFor.SQL.Clear;
      FQryFor.SQL.Add(FSQLInsertFornecedor);
      FQryFor.Prepare;
      FQry.Close;
      FQry.SQL.Clear;
      FQry.SQL.Add(fRetornaSQLInsertProspecto);
      FQry.Prepare;

      For intCnt := 0 to LinhasImportadas.Count-1 do
      Begin
        xLinha :=  LinhasImportadas[intCnt];
        For intCont := 0 To xLinha.Campos.Count -1 Do
        Begin
          If Pos('PRO_', xLinha.Campos[intCont].Propriedades.NomeCampo) > 0 Then
          Begin
            If fEmptyStr(xLinha.Campos[intCont].Propriedades.Conteudo) Then
              FQry.ParamByName(xLinha.Campos[intCont].Propriedades.NomeCampo).Value := null
            Else
              FQry.ParamByName(xLinha.Campos[intCont].Propriedades.NomeCampo).AsString := xLinha.Campos[intCont].Propriedades.Conteudo;
          End;

          If (Pos('PRF_CRMFOR', xLinha.Campos[intCont].Propriedades.NomeCampo) > 0) And
             (Not fEmptyStr(xLinha.Campos[intCont].Propriedades.Conteudo)) Then
          Begin
            FQryFor.ParamByName('PRF_CRMFOR').AsString := xLinha.Campos[intCont].Propriedades.Conteudo;
          End;

          If (xLinha.Campos[intCont].Propriedades.NomeCampo = cstDatNsc ) And
             (Not fEmptyStr(xLinha.Campos[intCont].Propriedades.Conteudo)) Then
          Begin
            FQry.ParamByName(xLinha.Campos[intCont].Propriedades.NomeCampo).AsDateTime := StrToDateTime(xLinha.Campos[intCont].Propriedades.Conteudo);
          End;

          If Pos('PRO_CRMCAT', xLinha.Campos[intCont].Propriedades.NomeCampo) > 0 Then
          Begin
            FQry.ParamByName('PRO_CRMCAT').AsString := IIF(fEmptyStr(xLinha.Campos[intCont].Propriedades.Conteudo),
                                                             fCfgSis('CATPRO', varString),
                                                             xLinha.Campos[intCont].Propriedades.Conteudo);
          End;
        End;
        xAutInt := fRetAutoIncrem('PROSPE', VS_strCodEmp);
        FQry.ParamByName('AUTOINCREM').AsString := xAutInt;
        FQry.ParamByName('PRO_DTACAD').AsDateTime := VS_Date;
        FQry.ParamByName('PRO_CODPRO').AsString := fAtualizaProCod('PROSPE', 'PRO_CODPRO');
        FQry.ExecSQL;

        If Not FQryFor.ParamByName('PRF_CRMFOR').IsNull Then
        Begin
          FQryFor.ParamByName('PRF_CODPRO').AsString := FQry.ParamByName('PRO_CODPRO').AsString;
          FQryFor.ExecSQL;
        End;

      End;

      fCommit;
      Result := True;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message,'[TImportaPlanilhaProspecto.Inserir]');
      End;
    End;

  Finally
    FreeAndNil(FQry);
    FreeAndNil(FQryFor);
  End;
end;

{ TValidacaoDadosImportacaoProspecto }

constructor TValidacaoDadosImportacaoProspecto.Create(aArquivoImportacao: IImportaPlanilha);
begin
  inherited;

  FSQLSelect := 'SELECT COUNT(AUTOINCREM) AS QTD ' +
                ' FROM CADCLI ' +
                'WHERE CLI_CGCCPF = :CPFCGC OR CLI_C_G_C_ = :CPFCGC';
  FListaCPFCNPJ := TStringList.Create;
  FQuery := fCriaQuery;
  FQuery.DisableControls;
  FQuery.SQL.Add(FSQLSelect);
  FQuery.Prepare;
  FProspecto := TProspectoController.Create;
end;

destructor TValidacaoDadosImportacaoProspecto.Destroy;
begin
  FreeAndNil(FProspecto);
  FreeAndNil(FListaCPFCNPJ);
  FreeAndNil(FQuery);
end;

function TValidacaoDadosImportacaoProspecto.fValidarClienteCadastrado(Const aConteudo: String): Boolean;
var
  strCodCliC: String;
begin
  Result := True;

  If fEmptyStr(aConteudo) Then
    Exit;

  strCodCliC := fCampoTabela('CLI_CODCLI', 'CADCLI', ['CLI_C_G_C_'], [aConteudo] );
  If (Not fEmptyStr(strCodCliC)) Then
  Begin
    Result := False;
  End;

end;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaCPFCNPJ(Const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
  If fEmptyStr(FProspecto.Prospecto.CPFCGC) Then
    Exit;

  If Not FProspecto.Validacao.fValidarCPFCNPJ then
  Begin
    pAdicionaInconsistencia(aLinha, aLinha.Campos[FIndiceCPFCGC].Propriedades.Coluna, aLinha.Campos[FIndiceCPFCGC].Propriedades.DescricaoCampo, cstValidacaoCPFCCGInvalido);
  End
  Else
  Begin
    If Not(fValidarRegistoDuplicadoArquivo(FProspecto.Prospecto.CPFCGC))  Then
    Begin
      pAdicionaInconsistencia(aLinha, aLinha.Campos[FIndiceCPFCGC].Propriedades.Coluna, aLinha.Campos[FIndiceCPFCGC].Propriedades.DescricaoCampo, cstValidacaoRegistroDuplicadoArquivo);
    End;

    If Not(fValidarRegistoDuplicadoDB(FProspecto.Prospecto.CPFCGC))  Then
    Begin
      pAdicionaInconsistencia(aLinha,
                              aLinha.Campos[FIndiceCPFCGC].Propriedades.Coluna,
                              aLinha.Campos[FIndiceCPFCGC].Propriedades.DescricaoCampo,
                              cstValidacaoRegistroDuplicadoDB);
    End;

    If Not(fValidarClienteCadastrado(FProspecto.Prospecto.CPFCGC))  Then
    Begin
       pAdicionaInconsistencia(aLinha,
                               aLinha.Campos[FIndiceCPFCGC].Propriedades.Coluna,
                               aLinha.Campos[FIndiceCPFCGC].Propriedades.DescricaoCampo,
                               cstValidacaoRegistroClienteCadastrado);
    End;

    xCampoLinhaAux := aLinha.Campos[FIndiceCpfCgc].Propriedades;
    xCampoLinhaAux.Conteudo := FProspecto.Prospecto.CPFCGC;
    aLinha.Campos[FIndiceCpfCgc].Propriedades := xCampoLinhaAux;

    xCampoLinhaAux := aLinha.Campos[FIndiceTipoCpfCNPJ].Propriedades;
    xCampoLinhaAux.Conteudo := FProspecto.Prospecto.TipPro;
    aLinha.Campos[FIndiceTipoCpfCNPJ].Propriedades := xCampoLinhaAux;
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaCidade(Const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
  If Not FProspecto.Validacao.fValidarCidade Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceCodCid].Propriedades.Coluna,
                            aLinha.Campos[FIndiceCodCid].Propriedades.DescricaoCampo,
                            cstValidacaoCodigoInexistente);
  End
  Else
  Begin
    If fEmptyStr(aLinha.Campos[FIndiceNomCid].Propriedades.Conteudo) Then
    Begin
      FProspecto.Prospecto.NomCid := fRetNomCidade(FProspecto.Prospecto.CodCid);
      xCampoLinhaAux := aLinha.Campos[FIndiceNomCid].Propriedades;
      xCampoLinhaAux.Conteudo :=  FProspecto.Prospecto.NomCid;
      aLinha.Campos[FIndiceNomCid].Propriedades := xCampoLinhaAux;
    End;

    If fEmptyStr(aLinha.Campos[FIndiceCodCid].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceCodCid].Propriedades;
      xCampoLinhaAux.Conteudo :=  FProspecto.Prospecto.CodCid;
      aLinha.Campos[FIndiceCodCid].Propriedades := xCampoLinhaAux;
    End;
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaAtividade(Const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
  If Not FProspecto.Validacao.fValidarAtividade Then
  Begin
   pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceCodAti].Propriedades.Coluna,
                            aLinha.Campos[FIndiceCodAti].Propriedades.DescricaoCampo,
                            cstValidacaoCodigoInexistente);
  End
  Else
  Begin
    If fEmptyStr(aLinha.Campos[FIndiceDesAti].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceDesAti].Propriedades;
      xCampoLinhaAux.Conteudo := FProspecto.Prospecto.DesAti;
      aLinha.Campos[FIndiceDesAti].Propriedades := xCampoLinhaAux;
    End;
    If fEmptyStr(aLinha.Campos[FIndiceCodAti].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceCodAti].Propriedades;
      xCampoLinhaAux.Conteudo :=  FProspecto.Prospecto.CodAti;
      aLinha.Campos[FIndiceCodAti].Propriedades := xCampoLinhaAux;
    End;
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaVendedor(Const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
  If Not FProspecto.Validacao.fValidarVendedor Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceCodVen].Propriedades.Coluna,
                            aLinha.Campos[FIndiceCodVen].Propriedades.DescricaoCampo,
                            cstValidacaoCodigoInexistente);
  End
  Else
  Begin
    If fEmptyStr(aLinha.Campos[FIndiceNomVen].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceNomVen].Propriedades;
      xCampoLinhaAux.Conteudo := FProspecto.Prospecto.NomVen;
      aLinha.Campos[FIndiceNomVen].Propriedades := xCampoLinhaAux;
    End;
    If fEmptyStr(aLinha.Campos[FIndiceCodVen].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceCodVen].Propriedades;
      xCampoLinhaAux.Conteudo :=  FProspecto.Prospecto.CodVen;
      aLinha.Campos[FIndiceCodVen].Propriedades := xCampoLinhaAux;
    End;
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaEmail(Const aLinha: ILinha);
Begin
  If Not fEmptyStr(FProspecto.Prospecto.Email1) Then
    If Not fEmailValido( FProspecto.Prospecto.Email1, False, 'E-Mail', False, False) Then
    Begin
      pAdicionaInconsistencia(aLinha,
                              aLinha.Campos[FIndiceEmail1].Propriedades.Coluna,
                              aLinha.Campos[FIndiceEmail1].Propriedades.DescricaoCampo,
                              cstValidacaoEmail);
    End;

  If Not fEmptyStr(FProspecto.Prospecto.Email2) Then
    If Not fEmailValido( FProspecto.Prospecto.Email2, False, 'E-Mail', False, False) Then
    Begin
      pAdicionaInconsistencia(aLinha,
                              aLinha.Campos[FIndiceEmail2].Propriedades.Coluna,
                              aLinha.Campos[FIndiceEmail2].Propriedades.DescricaoCampo,
                              cstValidacaoEmail);
    End;

  If Not fEmptyStr(FProspecto.Prospecto.Email3) Then
    If Not fEmailValido( FProspecto.Prospecto.Email3, False, 'E-Mail', False, False) Then
    Begin
      pAdicionaInconsistencia(aLinha,
                              aLinha.Campos[FIndiceEmail3].Propriedades.Coluna,
                              aLinha.Campos[FIndiceEmail3].Propriedades.DescricaoCampo,
                              cstValidacaoEmail);
    End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaStatus(Const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin

  If fEmptyStr(FProspecto.Prospecto.Status) Then
  Begin
    FProspecto.Prospecto.Status := 'A';
    xCampoLinhaAux := aLinha.Campos[FIndiceStatus].Propriedades;
    xCampoLinhaAux.Conteudo := FProspecto.Prospecto.Status;
    aLinha.Campos[FIndiceStatus].Propriedades := xCampoLinhaAux;
  End;

  If Not (StrUtils.MatchStr(FProspecto.Prospecto.Status,['A', 'I']))  Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceStatus].Propriedades.Coluna,
                            aLinha.Campos[FIndiceStatus].Propriedades.DescricaoCampo,
                            cstValidacaoStatus);
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaRedeLojas(Const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
  If Not FProspecto.Validacao.fValidarRedeLojas Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceCodRed].Propriedades.Coluna,
                            aLinha.Campos[FIndiceCodRed].Propriedades.DescricaoCampo,
                            cstValidacaoCodigoInexistente);
  End
  Else
  Begin
    If fEmptyStr(aLinha.Campos[FIndiceDesRed].Propriedades.Conteudo)Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceDesRed].Propriedades;
      xCampoLinhaAux.Conteudo := FProspecto.Prospecto.DesRed;
      aLinha.Campos[FIndiceDesRed].Propriedades := xCampoLinhaAux;
    End;
    If fEmptyStr(aLinha.Campos[FIndiceCodRed].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceCodRed].Propriedades;
      xCampoLinhaAux.Conteudo :=  FProspecto.Prospecto.DesRed;
      aLinha.Campos[FIndiceCodRed].Propriedades := xCampoLinhaAux;
    End;
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaRegiao(
  const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
  If Not FProspecto.Validacao.fValidarCodReg Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceCodReg].Propriedades.Coluna,
                            aLinha.Campos[FIndiceCodReg].Propriedades.DescricaoCampo,
                            cstValidacaoCodigoInexistente);
  End
  Else
  Begin
    If fEmptyStr(aLinha.Campos[FIndiceDesReg].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceDesReg].Propriedades;
      xCampoLinhaAux.Conteudo := FProspecto.Prospecto.DesReg;
      aLinha.Campos[FIndiceDesReg].Propriedades := xCampoLinhaAux;
    End;
    If fEmptyStr(aLinha.Campos[FIndiceCodReg].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceCodReg].Propriedades;
      xCampoLinhaAux.Conteudo :=  FProspecto.Prospecto.CodReg;
      aLinha.Campos[FIndiceCodReg].Propriedades := xCampoLinhaAux;
    End;
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaRepresentante(
  const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
  If Not FProspecto.Validacao.fValidarCodRep Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceCodRep].Propriedades.Coluna,
                            aLinha.Campos[FIndiceCodRep].Propriedades.DescricaoCampo,
                            cstValidacaoCodigoInexistente);
  End
  Else
  Begin
    If fEmptyStr(aLinha.Campos[FIndiceNomRep].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceNomRep].Propriedades;
      xCampoLinhaAux.Conteudo := FProspecto.Prospecto.NomRep;
      aLinha.Campos[FIndiceNomRep].Propriedades := xCampoLinhaAux;
    End;
    If fEmptyStr(aLinha.Campos[FIndiceCodRep].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceCodRep].Propriedades;
      xCampoLinhaAux.Conteudo :=  FProspecto.Prospecto.CodRep;
      aLinha.Campos[FIndiceCodRep].Propriedades := xCampoLinhaAux;
    End;
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaRgExp(
  const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
  Begin
    If Not fEmptyStr(aLinha.Campos[FIndiceUFExpRg].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceExpRg].Propriedades;
      xCampoLinhaAux.Conteudo := FProspecto.Prospecto.NRgExp + '-' + FProspecto.Prospecto.UFExRg ;
      xCampoLinhaAux.blnValidarTamanho := False;
      aLinha.Campos[FIndiceExpRg].Propriedades := xCampoLinhaAux;
    End;
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaCrmFrequencia(Const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
 If Not FProspecto.Validacao.fValidarCrmFre Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceCrmFre].Propriedades.Coluna,
                            aLinha.Campos[FIndiceCrmFre].Propriedades.DescricaoCampo,
                            cstValidacaoCodigoInexistente);
  End
  Else
  Begin
    If fEmptyStr(aLinha.Campos[FIndiceDesFre].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceDesFre].Propriedades;
      xCampoLinhaAux.Conteudo := FProspecto.Prospecto.DesFre;
      aLinha.Campos[FIndiceDesFre].Propriedades := xCampoLinhaAux;
    End;
    If fEmptyStr(aLinha.Campos[FIndiceCrmFre].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceCrmFre].Propriedades;
      xCampoLinhaAux.Conteudo :=  FProspecto.Prospecto.CrmFre;
      aLinha.Campos[FIndiceCrmFre].Propriedades := xCampoLinhaAux;
    End;
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaCrmCategoria(Const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
  If Not FProspecto.Validacao.fValidarCrmCat Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceCrmFre].Propriedades.Coluna,
                            aLinha.Campos[FIndiceCrmFre].Propriedades.DescricaoCampo,
                            cstValidacaoCodigoInexistente);
  End
  Else
  Begin
    If fEmptyStr(aLinha.Campos[FIndiceDesCat].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceDesCat].Propriedades;
      xCampoLinhaAux.Conteudo := FProspecto.Prospecto.DesCat;
      aLinha.Campos[FIndiceDesCat].Propriedades := xCampoLinhaAux;
    End;
    If fEmptyStr(aLinha.Campos[FIndiceCrmCat].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceCrmCat].Propriedades;
      xCampoLinhaAux.Conteudo :=  FProspecto.Prospecto.CrmCat;
      aLinha.Campos[FIndiceCrmCat].Propriedades := xCampoLinhaAux;
    End;
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaCrmPorte(Const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
  If Not FProspecto.Validacao.fValidarCrmPor Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceCrmPor].Propriedades.Coluna,
                            aLinha.Campos[FIndiceCrmPor].Propriedades.DescricaoCampo,
                            cstValidacaoCodigoInexistente);
  End
  Else
  Begin
    If fEmptyStr(aLinha.Campos[FIndiceDesPor].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceDesPor].Propriedades;
      xCampoLinhaAux.Conteudo := FProspecto.Prospecto.DesPor;
      aLinha.Campos[FIndiceDesPor].Propriedades := xCampoLinhaAux;
    End;
    If fEmptyStr(aLinha.Campos[FIndiceCrmPor].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceCrmPor].Propriedades;
      xCampoLinhaAux.Conteudo :=  FProspecto.Prospecto.CrmPor;
      aLinha.Campos[FIndiceCrmPor].Propriedades := xCampoLinhaAux;
    End;
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaCrmFaixa(Const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
  If Not FProspecto.Validacao.fValidarCrmFai Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceCrmFai].Propriedades.Coluna,
                            aLinha.Campos[FIndiceCrmFai].Propriedades.DescricaoCampo,
                            cstValidacaoCodigoInexistente);
  End
  Else
  Begin
    If fEmptyStr(aLinha.Campos[FIndiceDesFai].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceDesFai].Propriedades;
      xCampoLinhaAux.Conteudo := FProspecto.Prospecto.DesFai;
      aLinha.Campos[FIndiceDesFai].Propriedades := xCampoLinhaAux;
    End;
    If fEmptyStr(aLinha.Campos[FIndiceCrmFai].Propriedades.Conteudo) Then
    Begin
      xCampoLinhaAux := aLinha.Campos[FIndiceCrmFai].Propriedades;
      xCampoLinhaAux.Conteudo := FProspecto.Prospecto.CrmFai;
      aLinha.Campos[FIndiceCrmFai].Propriedades := xCampoLinhaAux;
    End;
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaCep(Const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
 If Not FProspecto.Validacao.fValidarCep(False, True) Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceProCep].Propriedades.Coluna,
                            aLinha.Campos[FIndiceProCep].Propriedades.DescricaoCampo,
                            FProspecto.Validacao.MensagemValidacaoCep);
  End
  Else If FProspecto.Validacao.AtualizarEndereco then
  Begin
    xCampoLinhaAux := aLinha.Campos[FIndiceCodCid].Propriedades;
    xCampoLinhaAux.Conteudo :=  FProspecto.Prospecto.CodCid;
    aLinha.Campos[FIndiceCodCid].Propriedades := xCampoLinhaAux;

    xCampoLinhaAux := aLinha.Campos[FIndiceNomCid].Propriedades;
    xCampoLinhaAux.Conteudo :=  FProspecto.Prospecto.NomCid;
    aLinha.Campos[FIndiceNomCid].Propriedades := xCampoLinhaAux;

    xCampoLinhaAux := aLinha.Campos[FIndiceEndereco].Propriedades;
    xCampoLinhaAux.Conteudo :=  FProspecto.Prospecto.Endere;
    aLinha.Campos[FIndiceEndereco].Propriedades := xCampoLinhaAux;

    xCampoLinhaAux := aLinha.Campos[FIndiceBairro].Propriedades;
    xCampoLinhaAux.Conteudo :=  FProspecto.Prospecto.Bairro;
    aLinha.Campos[FIndiceBairro].Propriedades := xCampoLinhaAux;

    xCampoLinhaAux := aLinha.Campos[FIndiceCorreio].Propriedades;
    xCampoLinhaAux.Conteudo :=  FProspecto.Prospecto.CodCorreio;
    aLinha.Campos[FIndiceCorreio].Propriedades := xCampoLinhaAux;
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaInscricaoEstadual(Const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
  If Not FProspecto.Validacao.fValidarInscricaoEstadual Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceInscEst].Propriedades.Coluna,
                            aLinha.Campos[FIndiceInscEst].Propriedades.DescricaoCampo,
                            cstValidacaoInscricaoEstadual);
  End
  Else
  Begin
    xCampoLinhaAux := aLinha.Campos[FIndiceInscEst].Propriedades;
    xCampoLinhaAux.Conteudo := FProspecto.Prospecto.InsEst;
    aLinha.Campos[FIndiceInscEst].Propriedades := xCampoLinhaAux;
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaDataNasc(Const aLinha: ILinha);
Begin
  If Not FProspecto.Validacao.fValidarDataNasc Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceDatNas].Propriedades.Coluna,
                            aLinha.Campos[FIndiceDatNas].Propriedades.DescricaoCampo,
                            cstValidacaoDataNasc);
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaCrmFornecedor(Const aLinha: ILinha);
var
  xCampoLinhaAux: TCampoPlanilha;
Begin
  If Not FProspecto.Validacao.fValidarCrmFor Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceCrmFor].Propriedades.Coluna,
                            aLinha.Campos[FIndiceCrmFor].Propriedades.DescricaoCampo,
                            cstValidacaoCodigoInexistente);
  End
  Else
  Begin
    xCampoLinhaAux := aLinha.Campos[FIndiceCrmFor].Propriedades;
    xCampoLinhaAux.Conteudo := FProspecto.Prospecto.CrmFor;
    aLinha.Campos[FIndiceCrmFor].Propriedades := xCampoLinhaAux;

    xCampoLinhaAux := aLinha.Campos[FIndiceDesFor].Propriedades;
    xCampoLinhaAux.Conteudo := FProspecto.Prospecto.DesFor;
    aLinha.Campos[FIndiceDesFor].Propriedades := xCampoLinhaAux;
  End;
End;

procedure TValidacaoDadosImportacaoProspecto.pAnalisaInconsistenciaTelefone(Const aLinha: ILinha);
Begin
  If Not fEmptyStr(FProspecto.Prospecto.Fone01) Then
    If Not fValidaTelefone( FProspecto.Prospecto.Fone01 ) Then
    Begin
      pAdicionaInconsistencia(aLinha,
                              aLinha.Campos[FIndiceFone01].Propriedades.Coluna,
                              aLinha.Campos[FIndiceFone01].Propriedades.DescricaoCampo,
                              cstValidacaoTelefone);
    End;

  If Not fEmptyStr(FProspecto.Prospecto.Fone02) Then
    If Not fValidaTelefone( FProspecto.Prospecto.Fone02 ) Then
    Begin
      pAdicionaInconsistencia(aLinha,
                              aLinha.Campos[FIndiceFone02].Propriedades.Coluna,
                              aLinha.Campos[FIndiceFone02].Propriedades.DescricaoCampo,
                              cstValidacaoTelefone);
    End;

  If Not fEmptyStr(FProspecto.Prospecto.NumFax) Then
    If Not fValidaTelefone( FProspecto.Prospecto.NumFax ) Then
    Begin
      pAdicionaInconsistencia(aLinha,
                              aLinha.Campos[FIndiceNumFax].Propriedades.Coluna,
                              aLinha.Campos[FIndiceNumFax].Propriedades.DescricaoCampo,
                              cstValidacaoTelefone);
    End;

  If Not fEmptyStr(FProspecto.Prospecto.Celular) Then
    If Not fValidaCelular( FProspecto.Prospecto.Celular ) Then
    Begin
      pAdicionaInconsistencia(aLinha,
                              aLinha.Campos[FIndiceCelular].Propriedades.Coluna,
                              aLinha.Campos[FIndiceCelular].Propriedades.DescricaoCampo,
                              cstValidacaoTelefone);
    End;

End;

function TValidacaoDadosImportacaoProspecto.fValidarLinha(
  Const aLinha: ILinha): Boolean;
begin

  Result := True;

  Try
    pSetarDados(aLinha);

    pAnalisaInconsistenciaCPFCNPJ(aLinha);
    pAnalisaInconsistenciaCidade(aLinha);
    pAnalisaInconsistenciaAtividade(aLinha);
    pAnalisaInconsistenciaVendedor(aLinha);
    pAnalisaInconsistenciaEmail(aLinha);
    pAnalisaInconsistenciaStatus(aLinha);
    pAnalisaInconsistenciaRedeLojas(aLinha);
    pAnalisaInconsistenciaCrmFrequencia(aLinha);
    pAnalisaInconsistenciaCrmCategoria(aLinha);
    pAnalisaInconsistenciaCrmPorte(aLinha);
    pAnalisaInconsistenciaCrmFaixa(aLinha);
    pAnalisaInconsistenciaCep(aLinha);
    pAnalisaInconsistenciaInscricaoEstadual(aLinha);
    pAnalisaInconsistenciaDataNasc(aLinha);
    pAnalisaInconsistenciaCrmFornecedor(aLinha);
    pAnalisaInconsistenciaTelefone(aLinha);
    pAnalisaInconsistenciaRgExp(aLinha);
    pAnalisaInconsistenciaRepresentante(aLinha);
    pAnalisaInconsistenciaRegiao(aLinha);

    inherited;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TValidacaoDadosImportacaoProspecto.fValidarLinha]');
    End;
  End;

end;

procedure TValidacaoDadosImportacaoProspecto.pAdicionaInconsistencia(Const aLinha: ILinha; Const Coluna, Campo, Mensagem: String);
var
  xInconsistencia : TRegInconsistencia;
Begin
  xInconsistencia.NumeroLinha := aLinha.NumeroLinha;
  xInconsistencia.Coluna := Coluna;
  xInconsistencia.Campo := Campo;
  xInconsistencia.Descricao := Mensagem;
  FInconsistencias.Inconsistencias.Add(xInconsistencia);
End;

function TValidacaoDadosImportacaoProspecto.fValidarRegistoDuplicadoArquivo(
  Const aConteudo: String): Boolean;
var
  intCnt: Integer;
begin
  Result := True;

  For intCnt := 0 to FListaCPFCNPJ.Count-1 Do
  Begin
    If FListaCPFCNPJ[intCnt].Equals(aConteudo) Then
    Begin
      Result := False;
      Break;
    End;
  End;

  If Result Then
    FListaCPFCNPJ.Add(aConteudo);
end;

function TValidacaoDadosImportacaoProspecto.fValidarRegistoDuplicadoDB(Const aConteudo: String): Boolean;
var
  strCodCliC: String;
begin
  Result := True;

  If fEmptyStr(aConteudo) Then
  Begin
    Exit;
  End;

  strCodCliC := fCampoTabela('PRO_CODPRO', 'PROSPE', ['PRO_C_G_C_'], [aConteudo] );
  If (Not fEmptyStr(strCodCliC)) Then
  Begin
    Result := False;
  End;

end;

procedure TValidacaoDadosImportacaoProspecto.pAtualizarParametrosValidacao;
begin
  pSetarLinhaPadraoModelo;
end;

procedure TValidacaoDadosImportacaoProspecto.pLimpar;
begin
  inherited;

  FListaCPFCNPJ.Clear;
end;

procedure TValidacaoDadosImportacaoProspecto.pSetarLinhaPadraoModelo;
var
  xLinha: ILinha;
  intCnt: Integer;
  xCampo: ICampoLinha;
  xPropriedade: TCampoPlanilha;
begin

  xLinha := TLinha.New;
  For intCnt := 0 to Self.Arquivo.Modelo.Campos.Count-1  Do
  Begin
    xCampo := xLinha.AddCampo;
    xPropriedade.NomeCampo  := Self.Arquivo.Modelo.Campos[intCnt].NomeCampo;
    xCampo.Propriedades := xPropriedade;
  End;
end;

procedure TValidacaoDadosImportacaoProspecto.pSetarDados(const aLinha: ILinha);
var
  intCnt: Integer;
begin
  For intCnt := aLinha.Campos.Count-1 DownTo 0 Do
  Begin

    Case AnsiIndexStr(aLinha.Campos[intCnt].Propriedades.NomeCampo, arrCamposProspecto)  Of
      1 : Begin
            FIndiceCpfCgc := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.CPFCGC := fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo);
          End;

      2 : Begin
            FIndiceCodCid := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.CodCid := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      3 : Begin
            FIndiceNomCid := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.NomCid := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      4 : Begin
            FIndiceFone01 := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.Fone01 := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      5 : Begin
            FIndiceEmail1 := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.Email1 := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      6 : Begin
            FIndiceEmail2 := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.Email2 := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      7 : Begin
            FIndiceCodAti := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.CodAti := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      8 : Begin
            FIndiceDesAti := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.DesAti := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      9 : Begin
            FIndiceCodVen := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.CodVen := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      10: Begin
            FIndiceNomVen := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.NomVen := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      11: Begin
            FIndiceStatus := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.Status := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      13: Begin
            FIndiceTipoCPFCNPJ := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.TipPro := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      15: Begin
            FIndiceProCep := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.NumCep := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      16: Begin
            FIndiceEmail3 := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.Email3 := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      18: Begin
            FIndiceEndereco := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.Endere := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      21: Begin
            FIndiceFone02 := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.Fone02 := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      22: Begin
            FIndiceNumFax := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.NumFax := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      24: Begin
            FIndiceInscEst := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.InsEst := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      25: Begin
            FIndiceDatNas := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.StrDatNas := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      29: Begin
            FIndiceExpRg := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.NRgExp  := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      30: Begin
            FIndiceCodRed := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.CodRed := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      31: Begin
            FIndiceDesRed := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.DesRed := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      32: Begin
            FIndiceCrmFai := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.CrmFai := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      33: Begin
            FIndiceDesFai := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.DesFai := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      34: Begin
            FIndiceCrmFre := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.CrmFre := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      35: Begin
            FIndiceDesFre := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.DesFre := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      36: Begin
            FIndiceCrmPor := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.CrmPor := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      37: Begin
            FIndiceDesPor := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.DesPor := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      38: Begin
            FIndiceCrmCat := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.CrmCat := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      39: Begin
            FIndiceDesCat := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.DesCat := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      41: Begin
            FIndiceUFExpRg := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.UFExRg := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      42: Begin
            FIndiceCrmFor := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.CrmFor := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      43: Begin
            FIndiceDesFor := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.DesFor := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      44: Begin
            FIndiceCelular := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.Celular := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      45: Begin
            FIndiceCodRep := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.CodRep := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      46: Begin
            FIndiceNomRep := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.NomRep := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;
      47: Begin
            FIndiceCodReg := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.CodReg := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      48: Begin
            FIndiceDesReg := aLinha.Campos[intCnt].Propriedades.Posicao;
            FProspecto.Prospecto.DesReg := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;


    End;
  End;
end;

end.
