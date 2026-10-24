{**************************************************************************}
{* Classe responsável pela geração do cadastro de Personalizadas da tinta General *}
{***********************************************************************AC*}
unit untGravandoExecucaoGeneralPersonalizadas;

interface

uses
  untAbstractGravandoExecucaoGeneral, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, untStrUtils;

type
  TGravandoExecucaoGeneralPersonalizadas = class(TAbstractGravandoExecucaoGeneral)
  private
    procedure CarregandoPerso210(const gravando: IGravando);
    procedure CarregandoPerso211(const gravando: IGravando);
    procedure CarregandoQuantidadeFormulacao(const gravando: IGravando);
    procedure GravandoFormulasEspeciais(const gravando: IGravando);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untIConfTinta, untGravandoExecucaoGeneralNovasFormulas,
  untGravandoVazio, untIGravandoExecucaoNome, untFuncoesGenerica;

{ TGravandoExecucaoGeneralPersonalizadas }

procedure TGravandoExecucaoGeneralPersonalizadas.CarregandoPerso210(const gravando: IGravando);
var
  strLinha: String;
  stlLinhas: TStringList;
begin
  Try
    AssignFile(arqTxt, strPat210);
    Reset(arqTxt);
    intLinha := 0;

    stlLinhas := TStringList.Create;
    stlLinhas.LoadFromFile(strPat210);

    While Not Eof(arqTxt) Do
    Begin
      If gravando.Status <> sgGravando Then
      Begin
        CloseFile(arqTxt);
        FreeAndNil(stlLinhas);
        Exit;
      End;

      intLinha := intLinha + 1;
      Readln(arqTxt, strLinha);
      If (intLinha = 1) Then
      Begin
        cds210.Append;
      End;

      cds210.Fields[intLinha - 1].AsString := Trim(strLinha);

      If (intLinha = 6) Then
      Begin
        cds210.Post;
        intLinha := 0;
      End;
      gravando.RegistrarProgresso(0, intLinha, stlLinhas.Count);
    End;
  Finally
    CloseFile(arqTxt);
    FreeAndNil(stlLinhas);
  End;
end;

procedure TGravandoExecucaoGeneralPersonalizadas.CarregandoPerso211(const gravando: IGravando);
var
  strLinha: String;
  stlLinhas: TStringList;
begin
  Try
    AssignFile(arqTxt, strPat211);
    Reset(arqTxt);
    intLinha := 0;

    stlLinhas := TStringList.Create;
    stlLinhas.LoadFromFile(strPat211);

    While Not Eof(arqTxt) Do
    Begin
      If gravando.Status <> sgGravando Then
      Begin
        CloseFile(arqTxt);
        FreeAndNil(stlLinhas);
        Exit;
      End;

      intLinha := intLinha + 1;
      Readln(arqTxt, strLinha);
      If (intLinha = 1) Then
      Begin
        cds211.Append;
      End;

      cds211.Fields[intLinha - 1].AsString := Trim(strLinha);

      If (intLinha = conf.fGetInteger('LINPER')) Then
      Begin
        cds211.Post;
        intLinha := 0;
      End;
      gravando.RegistrarProgresso(0, intLinha, stlLinhas.Count);
    End;
  Finally
    CloseFile(arqTxt);
    FreeAndNil(stlLinhas);
  End;

end;

procedure TGravandoExecucaoGeneralPersonalizadas.CarregandoQuantidadeFormulacao(const gravando: IGravando);
var
  qryCadBas: IDataSet;
begin
  qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadBas.SQL := 'SELECT DISTINCT BAS_CODBAS, BAS_PESESP FROM MZA_CADBAS';
  qryCadBas.Open;

  cds211.IndexFieldNames := 'CODIGO';
  cds211.MasterFields := 'CODIGO';
  cds211.MasterSource := dts210;

  cds210.First;
  cds211.First;

  If gravando.Status <> sgGravando Then
    Exit;

  While Not cds210.Eof Do
  Begin
    cds210.Edit;
    cds210.FieldByName('TOTAL_GRAMAS').AsFloat :=  0;
    cds210.FieldByName('TOTAL_ML').AsFloat :=  0;
    While Not cds211.Eof Do
    Begin
      If gravando.Status <> sgGravando Then
        Exit;

      If qryCadBas.Locate('BAS_CODBAS', varArrayOf([cds211.FieldByName('CODIGO_BASE').AsString]), []) Then
      Begin
        cds211.Edit;
        cds211.FieldByName('PESO_ESPECIFICO').AsFloat :=  qryCadBas.FieldByName('BAS_PESESP').AsFloat;

        cds211.FieldByName('QUANTIDADE_ML').AsFloat :=
          (cds211.FieldByName('QUANTIDADE').AsFloat / cds211.FieldByName('PESO_ESPECIFICO').AsFloat);

        cds211.Post;

        cds210.FieldByName('TOTAL_GRAMAS').AsFloat :=
          cds210.FieldByName('TOTAL_GRAMAS').AsFloat + cds211.FieldByName('QUANTIDADE').AsFloat;

        cds210.FieldByName('TOTAL_ML').AsFloat :=
          cds210.FieldByName('TOTAL_ML').AsFloat + cds211.FieldByName('QUANTIDADE_ML').AsFloat;
      End;
      cds211.Next;
    End;
    cds210.Post;

    gravando.RegistrarProgresso(0, cds210.RecNo, cds210.RecordCount);
    cds210.Next;
  End;

  cds210.First;
  cds211.First;

  While Not cds210.Eof Do
  Begin
    If gravando.Status <> sgGravando Then
      Exit;

    While Not cds211.Eof Do
    Begin
      If gravando.Status <> sgGravando Then
        Exit;

      If qryCadBas.Locate('BAS_CODBAS', varArrayOf([cds211.FieldByName('CODIGO_BASE').AsString]), []) Then
      Begin
        cds211.Edit;
        cds211.FieldByName('QUANTIDADE_ML_900').AsFloat :=
          cds211.FieldByName('QUANTIDADE_ML').AsFloat * 900 / cds210.FieldByName('TOTAL_ML').AsFloat;

        cds211.FieldByName('QUANTIDADE_900').AsFloat :=
          cds211.FieldByName('QUANTIDADE_ML_900').AsFloat * cds211.FieldByName('PESO_ESPECIFICO').AsFloat;

        cds211.Post;

      End;
      cds211.Next;
    End;
    gravando.RegistrarProgresso(0, cds210.RecNo, cds210.RecordCount);
    cds210.Next;
  End;
end;

procedure TGravandoExecucaoGeneralPersonalizadas.Executar(const gravando: IGravando);
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos Personalizadas Perso 2010 ...';
      If (Not fValidaPath) Then
      Begin
        gravando.Texto  := 'Path para o geração do arquivo de Personalizadas Perso 2010 não é válido...';
        gravando.Cancelar;
        Exit;
      End;
      gravando.Texto := 'Path de Arquivos Personalizadas Perso 2010 validado com sucesso ...';


      gravando.Texto := 'Validando Path de Arquivos Personalizadas Perso 2011...';
      If (Not fValidaPath) Then
      Begin
        gravando.Texto  := 'Path para o geração do arquivo de Personalizadas Perso 2011 não é válido...';
        gravando.Cancelar;
        Exit;
      End;
      gravando.Texto := 'Path de Arquivos Personalizadas Perso 2011 validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';
      CarregarDadosPersonalizadas;

      If gravando.Status <> sgGravando Then
        Exit;

      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('MZA_CADNFM');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Carregando arquivos Perso210...';
      CarregandoPerso210(gravando);

      If gravando.Status <> sgGravando Then
        Exit;

      gravando.Texto := 'Arquivos Perso210 carregados com sucesso...';

      gravando.Texto := 'Carregando arquivos Perso211...';
      CarregandoPerso211(gravando);

      If gravando.Status <> sgGravando Then
        Exit;

      gravando.Texto := 'Arquivos Perso210 carregados com sucesso...';

      gravando.Texto := 'Processando Quantidades das Fórmulas Personalizadas ...';
      CarregandoQuantidadeFormulacao(gravando);

      If gravando.Status <> sgGravando Then
        Exit;

      gravando.Texto := 'Quantidades das Fórmulas Personalizadas processadas com sucesso...';

      gravando.Texto := 'Processando as Fórmulas Personalizadas...';
      GravandoFormulasEspeciais(gravando);

      If gravando.Status <> sgGravando Then
        Exit;

      gravando.Texto := 'Fórmulas Personalizadas processadas com sucesso...';

    Except
      on E: Exception do
      begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoGeneralPersonalizadas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Fórmulas Personalizadas';
end;

procedure TGravandoExecucaoGeneralPersonalizadas.GravandoFormulasEspeciais(
  const gravando: IGravando);
var
  intProCod: Integer;
  qryCadNfm: IDataSet;
  intCont  : Integer;
begin
  intProCod := conf.fGetInteger('PRONFM') + 1;

  qryCadNfm.SQL := TAutcomTintaFactory.Get.GetInsert('MZA_CADNFM');

  cds210.First;
  while Not cds210.Eof do
  Begin
    If gravando.Status <> sgGravando Then
      Exit;

    qryCadNfm.FieldByName('NFM_CODNFM').AsString := 'ESP ' + TStrUtils.fStrZero(intProCod, 6);
    qryCadNfm.FieldByName('NFM_DESCRI').AsString := cds210.FieldByName('DESCRICAO').AsString;
    qryCadNfm.FieldByName('NFM_DTACAD').AsDate   := fNow();
    qryCadNfm.FieldByName('NFM_VOLCON').AsFloat  := 900;
    qryCadNfm.FieldByName('NFM_VOLDIL').AsFloat  := 900;
    qryCadNfm.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('MZA_CADNFM', TAutcomTintaFactory.Get.GetCodEmp);
    qryCadNfm.FieldByName('NFM_REFERE').AsString := '';
    qryCadNfm.FieldByName('NFM_MONTAD').AsString := cds210.FieldByName('MONTADORA').AsString;
    qryCadNfm.FieldByName('NFM_A_N_O_').AsString := cds210.FieldByName('ANO').AsString;

    For intCont := 1 To cds211.RecordCount Do
    Begin
      cds211.RecNo := intCont;

      If (TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_REFERE').AsString)) Then
        qryCadNfm.FieldByName('NFM_REFERE').AsString := fGetReferencia(cds211.FieldByName('CODIGO_BASE').AsString);

      qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString := cds211.FieldByName('CODIGO_BASE').AsString;
      qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := cds211.FieldByName('QUANTIDADE_900').AsFloat;
      qryCadNfm.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := 0;
    End;

    qryCadNfm.ExecSQL;

    intProCod := intProCod + 1;

    gravando.RegistrarProgresso(0, cds210.RecNo, cds210.RecordCount);

    cds210.Next;
  End;

  conf.pSet('PRONFM', IntToStr(intProCod + 1));

 //Adiciona no cadastro da tinta
 (TGravandoExecucaoGeneralNovasFormulas.Create() as IGravandoExecucaoNome).Executar(TGravandoVazio.Create);

end;

end.
