{*************************************************************************}
{* Classe responsável pela geração do cadastro de BasesCatalisadoras da tinta ProfissionalAutomotiva *}
{**********************************************************************PH*}
unit untGravandoExecucaoProfissionalAutomotivaBasesCatalisadoras;

interface

uses
  untAbstractGravandoExecucaoProfissionalAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  UniClientDataSet, Vcl.Graphics, ComObj;

type
  TGravandoExecucaoProfissionalAutomotivaBasesCatalisadoras = class(TAbstractGravandoExecucaoProfissionalAutomotiva)
  Private
    procedure LimparTabelas;
    procedure pGravarCadastroBasesCatalisadoras(const Gravando: IGravando; AQryDestino: IDataSet; AContador: Integer);
  public
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function fGetPath(intPasta: Integer): String; override;
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean; Override;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList; AContador: Integer); Reintroduce;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoProfissionalAutomotivaBasesCatalisadoras }

procedure TGravandoExecucaoProfissionalAutomotivaBasesCatalisadoras.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  blnExcluir: Boolean;
  intContador: Integer;
begin
  Try
    Try
      blnExcluir := True;

      For intContador := 0 To FPastas.Count - 1 Do
      Begin
        ListarArquivo(Conf.fGet('PATPFA') + '\' + FPastas[intContador]);

        Gravando.Texto := 'Verificando Path do arquivo...';

        If Not fValidarPath(intContador) Then
        Begin
          Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
          Exit;
        End;

        If (Gravando.Status <> sgGravando) Then
          Exit;

        If (blnExcluir) Then
        Begin
          Gravando.Texto := 'Deletando Registros da tabela PFA_CATBAS...';
          LimparTabelas;
          blnExcluir := False;
        End;


        Gravando.Texto := 'Carregando Bases...';
        pCarregarBases(Gravando, intContador);

        cdsBases.Filtered := False;
        cdsBases.Filter := 'TIPO = ' + QuotedStr('BASE');
        cdsBases.Filtered := True;
        cdsBases.First;

        Gravando.Texto := 'Carregando Catalisadores...';
        pCarregarCatalisadores(Gravando, intContador);

        Gravando.Texto := 'Path verificado com sucesso...';
        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('PFA_CATBAS');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        qryDestino := GetDataSetDestino;
        pCarregarBasesCatalisadores(Gravando, fGetPath(intContador));

        Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
        Gravando.RegistrarProgresso(0, 0, 0);
        pGravarCadastroBasesCatalisadoras(Gravando, qryDestino, intContador);
      End;
    Except
      On E: Exception Do
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally
  End;
end;

function TGravandoExecucaoProfissionalAutomotivaBasesCatalisadoras.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases Catalisadoras';
end;


function TGravandoExecucaoProfissionalAutomotivaBasesCatalisadoras.fGetPath(intPasta: Integer): String;
begin
  Result := Conf.fGet('PATPFA') + '\' + FPastas[intPasta] +  '\' + FNomeCatalisadoresBases;
end;


function TGravandoExecucaoProfissionalAutomotivaBasesCatalisadoras.GetAdoQuery(
  var strNomeArquivo: String): TADOQuery;
begin
  Result := Nil;
end;

function TGravandoExecucaoProfissionalAutomotivaBasesCatalisadoras.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM PFA_CATBAS  ';
end;

function TGravandoExecucaoProfissionalAutomotivaBasesCatalisadoras.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoProfissionalAutomotivaBasesCatalisadoras.GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList; AContador: Integer);
begin
  //
end;

function TGravandoExecucaoProfissionalAutomotivaBasesCatalisadoras.IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean;
begin
  Result := False;
end;

procedure TGravandoExecucaoProfissionalAutomotivaBasesCatalisadoras.LimparTabelas;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM PFA_CATBAS';
  qryGen.ExecSQL;
end;

procedure TGravandoExecucaoProfissionalAutomotivaBasesCatalisadoras.pGravarCadastroBasesCatalisadoras(const Gravando: IGravando; AQryDestino: IDataSet; AContador: Integer);
Var
  qryBasCat: IDataSet;
begin
  qryBasCat := TAutcomTintaFactory.Get.fGetDataSet;
  qryBasCat.Close;
  qryBasCat.SQL := 'SELECT * FROM TMP_CATALISADORES_PFA ';
  qryBasCat.Open;

  While Not qryBasCat.Eof Do
  Begin
    If Not cdsBases.Locate('BASORI', qryBasCat.FieldByName('CAT_CODBAS').AsString, []) Then
    Begin
      qryBasCat.Next;
      Gravando.RegistrarProgresso(0, qryBasCat.RecNo, qryBasCat.RecordCount);
      Continue;
    End;

    If Not cdsCatali.Locate('COD_CATALISADOR', qryBasCat.FieldByName('CAT_CODCAT').AsString, []) Then
    Begin
      qryBasCat.Next;
      Gravando.RegistrarProgresso(0, qryBasCat.RecNo, qryBasCat.RecordCount);
      Continue;
    End;

    If Not AQryDestino.Locate('CAT_CODBAS;CAT_CODCAT', VarArrayOf([cdsBases.FieldByName('BASE').AsString, cdsCatali.FieldByName('BASE').AsString]), []) Then
    Begin
      AQryDestino.Insert;
      AQryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('PFA_CATBAS', TAutcomTintaFactory.Get.GetCodEmp);
      AQryDestino.FieldByName('CAT_CODBAS').AsString := cdsBases.FieldByName('BASE').AsString;
      AQryDestino.FieldByName('CAT_CODCAT').AsString := cdsCatali.FieldByName('BASE').AsString;
      AQryDestino.FieldByName('CAT_TIPBAS').AsString := qryBasCat.FieldByName('CAT_TIPBAS').AsString;
      AQryDestino.FieldByName('CAT_TIPCOL').AsString := fTipoColecao(AContador);
      AQryDestino.Post;
    End;

    qryBasCat.Next;
    Gravando.RegistrarProgresso(0, qryBasCat.RecNo, qryBasCat.RecordCount);
  End;
end;

end.

