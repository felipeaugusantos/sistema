unit untYapayPgto;

interface

uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Forms, System.Math, Dialogs,  System.Generics.Collections,

     Uni, cxProgressBar,

     untIYapayIntegracaoLibCartoes, untTYapayFuncoes, untYapayTipos;

Type
  TYapayPgto = Class(TInterfacedObject, ICartoes)
  Private
    function CorrigeDados(AValor: String; AFloat: Boolean = False): Variant;
    function CorrigeDadosBanco(AValor: Variant): Variant;
    function RetornaDelimitador(AText: String): Char;
    function IndexCampo(ACampo: String): Integer;

    function RetornaTipoDeRegistro(ADescricao: String): String;
    function RetornaParcelaDoRegistro(ADescricao: String): String;
    function RegistroDePagamento(ADescricao: String): Boolean;
    function RegistroDeSaque(ADescricao: String): Boolean;

    procedure pValidarSeOArquivoFoiAlterado(strLinhaDoArquivo: String);
  Public
    constructor Create;
    Destructor Destroy; Override;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaYapayPgto;
  End;

  Var
    NomeArquivo,
    DataArquivo,
    FModeloArquivo,
    FCodigoConciliacao: String;
    FImportouPagamentos: Boolean;

    FYapayRegistrosPgto: TList<TYapayRegistro>;

    lstCampos : TStringList;

Const
  NOMTAB = 'YAP_YAPGTO';
  INICAM = 'YAP_';

implementation

{ TYapayPgto }
{**********************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE CRÉDITO *}
{* YAP_YAPGTO                                 *}
{*******************************************AJ*}
function TYapayPgto.CorrigeDadosBanco(AValor: Variant): Variant;
begin
  Result := AValor;
  If TYapayFuncoes.fEmptyStr(Result) Then
    Result := Null;
end;

constructor TYapayPgto.Create;
begin
  lstCampos :=  TStringList.Create;
end;

destructor TYapayPgto.Destroy;
begin
  If Assigned(lstCampos) Then
    FreeAndNil(lstCampos);
  inherited;
end;

class function TYapayPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaYapayPgto;
Begin
  If strTabela = NOMTAB Then
  Begin
    SetLength(Result, 16);

    Result[0].strDescri  := INICAM + 'CODEST'; Result[0].strTipCmp  := 'VARCHAR(10)'  ;
    Result[1].strDescri  := INICAM + 'TIPREG'; Result[1].strTipCmp  := 'VARCHAR(20)'  ;
    Result[2].strDescri  := INICAM + 'DTAPAG'; Result[2].strTipCmp  := 'DATE'         ;
    Result[3].strDescri  := INICAM + 'EXTRAT'; Result[3].strTipCmp  := 'VARCHAR(20)'  ;
    Result[4].strDescri  := INICAM + 'CODTRA'; Result[4].strTipCmp  := 'VARCHAR(20)'  ;
    Result[5].strDescri  := INICAM + 'DESCRI'; Result[5].strTipCmp  := 'VARCHAR(150)' ;
    Result[6].strDescri  := INICAM + 'CODPED'; Result[6].strTipCmp  := 'VARCHAR(20)'  ;
    Result[7].strDescri  := INICAM + 'NUMPAR'; Result[7].strTipCmp  := 'VARCHAR(2)'   ;
    Result[8].strDescri  := INICAM + 'NOMARQ'; Result[8].strTipCmp  := 'VARCHAR(255)' ;
    Result[9].strDescri  := INICAM + 'DTAARQ'; Result[9].strTipCmp  := 'DATE'         ;
    result[10].strDescri := INICAM + 'VALPAG'; Result[10].strTipCmp := 'DECIMAL(15,2)';
    Result[11].strDescri := INICAM + 'SALDO_'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := INICAM + 'CONCIL'; Result[12].strTipCmp := 'INT DEFAULT 0';
    Result[13].strDescri := INICAM + 'STATUS'; Result[13].strTipCmp  := 'VARCHAR(20)'  ;
    Result[14].strDescri := INICAM + 'CODCON'; Result[14].strTipCmp  := 'VARCHAR(20)'  ;
    Result[15].strDescri := INICAM + 'DESPAG'; Result[15].strTipCmp  := 'VARCHAR(100)'  ;
  End;
End;

class function TYapayPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var
  arrCampos: TArrEstruturaYapayPgto;
  intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(YAP_CODEST,YAP_EXTRAT,YAP_CODTRA,YAP_CODPED,YAP_NUMPAR,YAP_DTAPAG,YAP_TIPREG)) ENGINE INNODB ' ;
end;

function TYapayPgto.IndexCampo(ACampo: String): Integer;
begin
  Result := lstCampos.IndexOf(AnsiUpperCase(ACampo));

  If Result = -1 Then
  Begin
    Raise Exception.Create('Não encontramos a coluna [' + ACampo + '] no arquivo '+ NomeArquivo +#13#10 +
                           'Verifique se a descrição da coluna está escrita de forma idêntica ao esperado.');
  End;
end;

function TYapayPgto.CorrigeDados(AValor: String; AFloat: Boolean = False): Variant;
Begin
  Result := Trim(AValor);

  If AFloat Then
  Begin
    Result := StringReplace(VarToStr(Result), 'R$ ', EmptyStr, [rfReplaceAll]);
    Result := TYapayFuncoes.fStrToFloat(Result);
  End;
End;

procedure TYapayPgto.pAdicionaLinha(strString: String);
Var
  LStringValores: TStringList;

  LRegistro: TYapayRegistro;
begin

  If strString.Trim.IsEmpty Then
    Exit;

  pValidarSeOArquivoFoiAlterado(strString);

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;


  If Not Assigned(FYapayRegistrosPgto) Then
    FYapayRegistrosPgto := TList<TYapayRegistro>.Create;

  If (Pos('Data do lançamento;Extrato;Transação;Descrição do lançamento;', strString) > 0) Then
  Begin
    FModeloArquivo := '1';
    FCodigoConciliacao := TYapayFuncoes.RetornaSequencial(NOMTAB);
    Exit;
  End;

  If (Pos('Id;Transação;Pedido;Status;Descrição;Valor;', strString) > 0) Then
  Begin
    FModeloArquivo := '2';
    FCodigoConciliacao := TYapayFuncoes.RetornaSequencial(NOMTAB);
    Exit;
  End;

  If (Pos('Data;ID Transa', strString) > 0) Then
  Begin
    FModeloArquivo := '3';
    FCodigoConciliacao := TYapayFuncoes.RetornaSequencial(NOMTAB);

    If Assigned(lstCampos) THen
      FreeAndNil(lstCampos);
    lstCampos := TStringList.Create;
    lstCampos.Delimiter := RetornaDelimitador(strString);
    lstCampos.StrictDelimiter := True;
    lstCampos.DelimitedText := AnsiUpperCase(TYapayFuncoes.fConverteParaAcento(strString));

    Exit;
  End;

  LStringValores := Nil;
  Try
    LStringValores := TStringList.Create;
    LStringValores.Delimiter := ';';
    LStringValores.StrictDelimiter := True;

    LStringValores.DelimitedText := strString;

    LRegistro.CodigoEstabelecimento := '0';

    LRegistro.CodigoConciliacao := RightStr(FCodigoConciliacao,6);

    If FModeloArquivo = '2' Then
    Begin
      LRegistro.TipoRegistro := RetornaTipoDeRegistro(LStringValores[4]);
      LRegistro.CodigoExtrato := CorrigeDados(LStringValores[0]);
      LRegistro.CodigoTransacao := CorrigeDados(LStringValores[1]);
      LRegistro.DescricaoLancamento := CorrigeDados(LStringValores[4]);
      LRegistro.NumeroPedido := CorrigeDados(LStringValores[2]);
      LRegistro.DataPagamento := CorrigeDados(LStringValores[7]);
      LRegistro.NumeroParcela := RetornaParcelaDoRegistro(LStringValores[4]);
      LRegistro.ValorPago := CorrigeDados(LStringValores[5], True);
      LRegistro.Saldo := CorrigeDados(LStringValores[5], True);
      LRegistro.Status := CorrigeDados(LStringValores[3]);
      LRegistro.FormaPagamento := CorrigeDados(LStringValores[10]);
    End
    Else If FModeloArquivo = '1' Then
    Begin
      LRegistro.TipoRegistro := RetornaTipoDeRegistro(LStringValores[3]);
      LRegistro.CodigoExtrato := CorrigeDados(LStringValores[1]);
      LRegistro.CodigoTransacao := CorrigeDados(LStringValores[2]);
      LRegistro.DescricaoLancamento := CorrigeDados(LStringValores[3]);
      LRegistro.NumeroPedido := CorrigeDados(LStringValores[4]);
      LRegistro.DataPagamento := CorrigeDados(LStringValores[0]);
      LRegistro.NumeroParcela := RetornaParcelaDoRegistro(LStringValores[3]);
      LRegistro.ValorPago := CorrigeDados(LStringValores[5], True);
      LRegistro.Saldo := CorrigeDados(LStringValores[6], True);
    End
    Else If FModeloArquivo = '3' Then
    Begin
      {$WARNINGS OFF}
      LRegistro.DescricaoLancamento := UTF8ToString(CorrigeDados(LStringValores[IndexCampo('Descrição')]));
      {$WARNINGS ON}
      LRegistro.TipoRegistro        := RetornaTipoDeRegistro(LRegistro.DescricaoLancamento);
      LRegistro.CodigoExtrato       := CorrigeDados(LStringValores[IndexCampo('ID Transação')]);
      LRegistro.CodigoTransacao     := CorrigeDados(LStringValores[IndexCampo('ID Transação')]);
      LRegistro.NumeroPedido        := CorrigeDados(LStringValores[IndexCampo('N. Pedido')]);
      LRegistro.DataPagamento       := CorrigeDados(LStringValores[IndexCampo('Data')]);
      LRegistro.NumeroParcela       := RetornaParcelaDoRegistro(LStringValores[IndexCampo('Parcelas')]);
      LRegistro.ValorPago           := CorrigeDados(LStringValores[IndexCampo('Valor Liq.')], True);
      LRegistro.Saldo               := LRegistro.ValorPago;
      LRegistro.FormaPagamento      := CorrigeDados(LStringValores[IndexCampo('Forma de Pagamento')]);
      If (Not TYapayFuncoes.fEmptyStr(LRegistro.DataPagamento)) Then
        LRegistro.DataPagamento := Copy(LRegistro.DataPagamento, 7, 4) + '-' +
                                   Copy(LRegistro.DataPagamento, 4, 2) + '-' +
                                   Copy(LRegistro.DataPagamento, 1, 2);

      If LRegistro.NumeroPedido.IsEmpty Then
        LRegistro.NumeroPedido := '0';
    End;

    LRegistro.NomeArquivo := NomeArquivo;
    LRegistro.DataArquivo := DataArquivo;
    FYapayRegistrosPgto.Add(LRegistro);

    If (VS_ListaEstabelecimentos.IndexOf('0') < 0) Then
      VS_ListaEstabelecimentos.Add('0');
  Finally
    If Assigned(LStringValores) Then
      FreeAndNil(LStringValores);
  End;
end;

procedure TYapayPgto.pGravarRegistros(pgbProg: TcxProgressBar);
Var
  LRegistro: TYapayRegistro;
  LMovimentoFinanceiro : TUniQuery;
begin
  LMovimentoFinanceiro := Nil;
  Try
    pgbProg.Position := 0;

    if (FYapayRegistrosPgto = nil) then
    begin
      Exit;
    end;

    If FYapayRegistrosPgto.Count = 0 Then
      Exit;

    LMovimentoFinanceiro := VS_FuncoesExternas.fICriaQuery;
    LMovimentoFinanceiro.SQL.Text := TYapayFuncoes.RetornaSQLReplace('YAP_YAPGTO',['YAP_CONCIL']);

    pgbProg.Properties.Max := FYapayRegistrosPgto.Count - 1;

    For LRegistro In FYapayRegistrosPgto Do
    Begin
      LMovimentoFinanceiro.Close;

      TyapayFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'YAP_TIPREG', CorrigeDadosBanco(LRegistro.TipoRegistro));
      TyapayFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'YAP_CODEST', CorrigeDadosBanco(LRegistro.CodigoEstabelecimento));
      TyapayFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'YAP_DTAPAG', CorrigeDadosBanco(LRegistro.DataPagamento));
      TyapayFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'YAP_EXTRAT', CorrigeDadosBanco(LRegistro.CodigoExtrato));
      TyapayFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'YAP_CODTRA', CorrigeDadosBanco(LRegistro.CodigoTransacao));
      TyapayFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'YAP_DESCRI', CorrigeDadosBanco(LRegistro.DescricaoLancamento));
      TyapayFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'YAP_CODPED', CorrigeDadosBanco(LRegistro.NumeroPedido));
      TyapayFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'YAP_NUMPAR', CorrigeDadosBanco(LRegistro.NumeroParcela));
      TyapayFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'YAP_NOMARQ', CorrigeDadosBanco(LRegistro.NomeArquivo));
      TyapayFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'YAP_DTAARQ', CorrigeDadosBanco(LRegistro.DataArquivo));
      TyapayFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'YAP_VALPAG', CorrigeDadosBanco(LRegistro.ValorPago));
      TyapayFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'YAP_SALDO_', CorrigeDadosBanco(LRegistro.Saldo));
      TyapayFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'YAP_STATUS', CorrigeDadosBanco(LRegistro.Status));
      TyapayFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'YAP_CODCON', CorrigeDadosBanco(LRegistro.CodigoConciliacao));
      TyapayFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'YAP_DESPAG', CorrigeDadosBanco(LRegistro.FormaPagamento));

      LMovimentoFinanceiro.ExecSQL;

      FImportouPagamentos := True;

      TYapayFuncoes.pStepStatusGravacao(pgbProg);
    End;
    TYapayFuncoes.GravarEstabelecimentos;
  Finally
    If Assigned(LMovimentoFinanceiro) Then
      FreeAndNil(LMovimentoFinanceiro);
  End;
end;

procedure TYapayPgto.pValidarSeOArquivoFoiAlterado(strLinhaDoArquivo: String);
Var
  stlCamposDoArquivo: TStringList;
  blnArquivoValido  : Boolean;
begin
  If strLinhaDoArquivo.IsEmpty Then
    Exit;

  stlCamposDoArquivo := Nil;
  Try
    stlCamposDoArquivo := TStringList.Create;
    stlCamposDoArquivo.StrictDelimiter := True;
    stlCamposDoArquivo.Delimiter := ';';

    stlCamposDoArquivo.DelimitedText := strLinhaDoArquivo;

    blnArquivoValido := (stlCamposDoArquivo.Count In [7, 10, 11]);
  Finally
    If Assigned(stlCamposDoArquivo) Then
      FreeAndNil(stlCamposDoArquivo);
  End;

  If Not blnArquivoValido Then
    Raise Exception.Create('O arquivo foi modificado em outro programa ou recebeu alterações no layout.'+ #13 +
                           'Para realizar a importação, o arquivo CSV não pode ter sofrido alterações.' + #13 +
                           'Operação cancelada!');
end;

function TYapayPgto.RegistroDePagamento(ADescricao: String): Boolean;
begin
  Result := False;

  If (Pos('CRÉDITO', ADescricao.ToUpper) <= 0) Then
  Begin
    If Not ((Copy(ADescricao.ToUpper,1,2) = 'CR') And
             (Copy(ADescricao.ToUpper,4,4) = 'DITO')) Then
      Exit;
  End;

  If (Pos('PARCELA', ADescricao.ToUpper) <= 0) Then
  Begin

    If (Pos('AO PAGAMENTO DA TRANSA', ADescricao.ToUpper) <= 0) Then
      If (Pos('AO RECEBIMENTO DA TRANSA', ADescricao.ToUpper) <= 0) Then
        Exit;

  End;

  Result := True;
end;

function TYapayPgto.RegistroDeSaque(ADescricao: String): Boolean;
begin
  Result := False;

  If (Pos('DÉBITO', ADescricao.ToUpper) <= 0) Then
  Begin
    If Not ((Copy(ADescricao.ToUpper,1,1) = 'D') And
            (Copy(ADescricao.ToUpper,3,4) = 'BITO')) Then
      Exit;
  End;

  If FModeloArquivo.Equals('3') Then
  Begin

    If (Pos('SAQUE', ADescricao.ToUpper) > 0) Then
     Exit(True);

    if (Pos('LIQUIDA', ADescricao.ToUpper) > 0) and
       (Pos('DA UR', ADescricao.ToUpper) > 0) and
       (Pos('CIP', ADescricao.ToUpper) > 0) then
    begin
      Exit(True);
    end;


    If (Pos(' TRANSFERÊNCIA BANCÁRIA', ADescricao.ToUpper) <= 0) Then
      Exit;

  End
  Else If (Pos('SOLICITA', ADescricao.ToUpper) <= 0) Then
    Exit;

  If Not FModeloArquivo.Equals('3') And (Pos('SAQUE', ADescricao.ToUpper) <= 0) Then
    Exit;

  Result := True;
end;

function TYapayPgto.RetornaParcelaDoRegistro(ADescricao: String): String;
begin
  Result := '01';

  If Pos('PARCELA', ADescricao.ToUpper) > 0 Then
  Begin
    Result := ADescricao
                 .ToUpper
                 .SubString(Pos('PARCELA', ADescricao.ToUpper) + 7, 2)
                 .Trim();

    If RightStr(Result, 1) = '/' Then
      Result := LeftStr(Result, 1);
  End
  Else If FModeloArquivo.Equals('3') Then
  Begin
    If Not TyapayFuncoes.fEmptyStr(ADescricao) And
       Not MatchStr(ADescricao,['-']) Then
    Begin
      Result := LeftStr(ADescricao,2);
      Result := Result.Replace('/','');
    End;
  End;

  If Result.Length = 1 Then
    Result := '0' + Result;
end;

function TYapayPgto.RetornaTipoDeRegistro(ADescricao: String): String;
begin
  If RegistroDePagamento(ADescricao) Then
    Result := 'PAGAMENTO'
  Else If RegistroDeSaque(ADescricao) Then
    Result := 'SAQUE'
  Else
    Result := 'AJUSTE';
end;

function TYapayPgto.RetornaDelimitador(AText: String): Char;
begin
  Result := ',';

  If Pos(';',AText) > 0 Then
    Result := ';';
end;

end.

