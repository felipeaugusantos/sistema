{******************************************************************************}
{* Classe responsável pela geração do cadastro de Embalagens da tinta HydronorthImobiliaria *}
{***************************************************************************PH*}
unit untGravandoExecucaoHydronorthImobiliariaEmbalagens;

interface

uses
  untAbstractGravandoExecucaoHydronorthImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoHydronorthImobiliariaEmbalagens = class(TAbstractGravandoExecucaoHydronorthImobiliaria)
  protected
     function GetSqlDestino(): string; Override;
     function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings; intTabela: Integer): string; Override;
     function IsRegistroExistente(const qryOrigem: TDataSet; qryDestino: IDataSet; intUnidade: Integer): Boolean; Override;
     procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet; intEmbalagem: Integer); Override;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  const
    arrEmbalagem: Array[1..6] Of String = ('QUA', 'GAL', 'LAA', 'GAT', 'LAT', 'LTA');
    arrUnidades: Array[1..6] Of String = ('QT', 'GL', 'LA', 'GL', 'LA', 'LA');
    arrQuantidade: Array[1..6] Of Double = (800, 3200, 16000, 6000, 25000, 28000);
    arrDescricao: Array[1..6] Of String = ('QUARTINHO', 'GALÃO', 'LATA', 'GALÃO 6KG', 'LATA 25KG', 'LATA 28KG');
  end;

implementation

uses untStrUtils;
{ TGravandoExecucaoHydronorthImobiliariaCores }

procedure TGravandoExecucaoHydronorthImobiliariaEmbalagens.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  intEmbalagem: Integer;
begin
  Try
    Try
      Gravando.Texto := 'Verificando Path...';

      If Not fValidaPath Then
      Begin
        Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Rever configurações.', [AnsiReplaceStr(GetPath, '"', '')]);
        Exit;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('HYD_CADEMB');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Carregando Dados...';

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.SQL := GetSqlDestino;
      qryDestino.Open;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      For intEmbalagem := 1 To 6 Do
      Begin
        If Not IsRegistroExistente(Nil, qryDestino, intEmbalagem) Then
          GravarRegistro(Nil, qryDestino, intEmbalagem);

        Gravando.RegistrarProgresso(0, intEmbalagem, 6);
      End;
    Except
      On E: Exception Do
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally

  End;
end;

function TGravandoExecucaoHydronorthImobiliariaEmbalagens.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Embalagens';
end;

function TGravandoExecucaoHydronorthImobiliariaEmbalagens.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM HYD_CADEMB    ';
end;

function TGravandoExecucaoHydronorthImobiliariaEmbalagens.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings; intTabela: Integer): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoHydronorthImobiliariaEmbalagens.GravarRegistro(
  const qryOrigem: TDataSet; qryDestino: IDataSet; intEmbalagem: Integer);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('HYD_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('EMB_CODEMB').AsString := arrEmbalagem[intEmbalagem];
  qryDestino.FieldByName('EMB_DESEMB').AsString := arrDescricao[intEmbalagem];
  qryDestino.FieldByName('EMB_CODUNI').AsString := arrUnidades[intEmbalagem];
  qryDestino.FieldByName('EMB_TAMEMB').AsFloat  := arrQuantidade[intEmbalagem];
  qryDestino.Post;
end;

function TGravandoExecucaoHydronorthImobiliariaEmbalagens.IsRegistroExistente(
  const qryOrigem: TDataSet; qryDestino: IDataSet;
  intUnidade: Integer): Boolean;
begin
  Result := qryDestino.Locate('EMB_CODEMB', VarArrayOf([arrEmbalagem[intUnidade]]), []);
end;

end.

