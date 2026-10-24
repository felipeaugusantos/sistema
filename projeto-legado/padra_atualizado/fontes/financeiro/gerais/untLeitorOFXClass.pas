unit untLeitorOFXClass;

interface

uses Classes, SysUtils, Controls, System.Generics.Collections, untFuncoesSimples,
     StrUtils, Forms, cxProgressBar;

(* ************************************************************
   *  Classe criada para manipulação de arquivos do tipo OFX  *
   ********************************************KP**Req-67959*** *)

type
  //Classe que representa a movimentação do extrato
  TOFXItem = Class
  private
    FTipo: String;
    FData: TDate;
    FValor: Double;
    FID: string;
    FDocumento: String;
    FDescricao: String;
    FCheckNum : String;
  protected
    function GetData: TDate;
    function GetDocumento: String;
    function GetID: String;
    function GetTipo: String;
    function GetValor: Double;
    function GetDescricao: String;
    function GetCheckNum: String;

    procedure SetData(const Value: TDate);
    procedure SetDocumento(const Value: String);
    procedure SetID(const Value: String);
    procedure SetTipo(const Value: String);
    procedure SetValor(const Value: Double);
    procedure SetDescricao(const Value: String);
    procedure SetCheckNum(const Value: String);
  public
    procedure Assign(AOfxItem: TOFXItem);
    property Tipo: String      Read GetTipo      Write SetTipo;
    property Data: TDate       Read GetData      Write SetData;
    property Valor: Double     Read GetValor     Write SetValor;
    property ID: String        Read GetID        Write SetID;
    property Documento: String Read GetDocumento Write SetDocumento;
    property Descricao: String Read GetDescricao Write SetDescricao;
    property CheckNum: String  Read GetCheckNum  Write SetCheckNum;
  end;

  //Classe que representa o extrato
  TOFX = Class
  private
    FBancoID: String;
    FContaID: String;
    FDigitoContaID: String;
    FAgenciaID: String;
    FOrganizacao: String;
    FTipoConta: String;
    FValorInicial: Double;
    FValorFinal: Double;
    FDataInicial: TDate;
    FDataFinal: TDate;
    FMovimentacoes: TObjectList<TOFXItem>;
    FChaveOFX : String;
    function GetAgenciaID: String;
    function GetOrganizacao: String;
    procedure SetAgenciaID(const Value: String);
    procedure SetOrganizacao(const Value: String);
    procedure SetDataInicial(const Value: TDate);
    function GetContaPelaChaveOFX : String;
    function GetAgenciaPelaChaveOFX : String;
    function ProcessaStringContaID(AConta : String) : String;
  protected
    function GetBancoID: String;
    function GetContaID: String;
    function GetDataFinal: TDate;
    function GetDataInicial: TDate;
    function GetMovimentacoes: TObjectList<TOFXItem>;
    function GetTipoConta: String;
    function GetValorFinal: Double;
    function GetValorInicial: Double;
    function GetChaveOFX : String;

    procedure SetBancoID(const Value: String);
    procedure SetContaID(const Value: String);
    procedure SetDataFinal(const Value: TDate);
    procedure SetMovimentacoes(const Value: TObjectList<TOFXItem>);
    procedure SetTipoConta(const Value: String);
    procedure SetValorFinal(const Value: Double);
    procedure SetValorInicial(const Value: Double);
    procedure SetChaveOFX(const AValue : String);

  public
    constructor Create;overload;
    destructor Destroy;override;
    procedure Assign(AOfx: TOFX);
    property BancoID: String      Read GetBancoID      Write SetBancoID;
    property ContaID: String      Read GetContaID      Write SetContaID;
    property DigitoContaID: String Read FDigitoContaID Write FDigitoContaID;
    property AgenciaID: String    read GetAgenciaID    Write SetAgenciaID;
    property Organizacao: String  read GetOrganizacao  Write SetOrganizacao;
    property TipoConta: String    Read GetTipoConta    Write SetTipoConta;
    property ValorInicial: Double Read GetValorInicial Write SetValorInicial;
    property ValorFinal: Double   Read GetValorFinal   Write SetValorFinal;
    property DataInicial: TDate   Read GetDataInicial  Write SetDataInicial;
    property DataFinal: TDate     Read GetDataFinal    Write SetDataFinal;
    property Movimentacoes: TObjectList<TOFXItem>      Read GetMovimentacoes Write SetMovimentacoes;
    property ChaveOFX : String    read GetChaveOFX     write SetChaveOFX;
    property ContaPelaChaveOFX : String read GetContaPelaChaveOFX;
  end;

  //Classe responsável pelo tratamento do arquivo OFX
  TLeitorOFX = Class
  private
    FArquivo : TOFX;

    FNomeArquivo: String;

    function fEncontrarTexto(strValorTag, strTexto: String): Boolean; Overload;
    function fEncontrarTexto(ATag: String; Var strTexto: String; AArquivo: TStringList; APosicao: Integer): Boolean; Overload;
    function fPegaValorTag(strTexto: String): String;
    function fPrepararValor(strValor: String): String;
    function fTemSeparadorMilharEDecimal(AValor: String): Boolean;
    function fRemoverSeparadorMilhar(AValor: String): String;
    function EncontrarTagMovimentacao(ATag:String; AArquivo: TStringList;APosicao: Integer): String;
    function CorrigirTexto(AText: String): String;
    function fTemMemoSecundario(AArquivo: TStringList; AIndiceMovimentacao: Integer; out AValorMemoSecundario: String): Boolean;

    function ProcessandoArquivoSelecionado(pgbStatus: TcxProgressBar): Boolean;
    function NormalizarOFX(AOfx:String): String;
    function OFXPossuiMovimentacao(const AArquivo: TStringList): Boolean;

    function RetornaTipoMovimento(AValor: Double; ATipo: String): String;
  protected
    function GetArquivo: TOFX;
    procedure SetArquivo(const Value: TOFX);
  public
    constructor Create;overload;
    destructor Destroy;override;
    function fProcessarArquivo(var strNomeArquivo: String): Boolean;

    property Arquivo: TOFX Read GetArquivo Write SetArquivo;
  end;

implementation

{ TOFXItem }

uses untTCadCCaRepository, untTCadCCa, untGravando;

procedure TOFXItem.Assign(AOfxItem: TOFXItem);
begin
  if not Assigned(AOfxItem) then
    Exit;

  FTipo      := AOfxItem.FTipo;
  FData      := AOfxItem.FData;
  FValor     := AOfxItem.FValor;
  FID        := AOfxItem.FID;
  FDocumento := AOfxItem.FDocumento;
  FDescricao := AOfxItem.FDescricao;
  FCheckNum  := AOfxItem.FCheckNum;
end;

function TOFXItem.GetCheckNum: String;
begin
  Result := FCheckNum;
end;

function TOFXItem.GetData: TDate;
begin
  Result := FData;
end;

function TOFXItem.GetDescricao: String;
begin
  Result := FDescricao;
end;

function TOFXItem.GetDocumento: String;
begin
  Result := FDocumento;
end;

function TOFXItem.GetID: String;
begin
  Result := FID;
end;

function TOFXItem.GetTipo: String;
begin
  Result := FTipo;
end;

function TOFXItem.GetValor: Double;
begin
  Result := FValor;
end;

procedure TOFXItem.SetCheckNum(const Value: String);
begin
  FCheckNum := Value;
end;

procedure TOFXItem.SetData(const Value: TDate);
begin
  FData := Value;
end;

procedure TOFXItem.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TOFXItem.SetDocumento(const Value: String);
begin
  FDocumento := Value;
end;

procedure TOFXItem.SetID(const Value: String);
begin
  FID := Value;
end;

procedure TOFXItem.SetTipo(const Value: String);
begin
  FTipo := Value;
end;

procedure TOFXItem.SetValor(const Value: Double);
begin
  FValor := Value;
end;

{ TOFX }

procedure TOFX.Assign(AOfx: TOFX);
var
  I: Integer;
begin
  if not Assigned(AOfx) then
    Exit;

  FBancoID       := AOfx.FBancoID;
  FContaID       := AOfx.FContaID;
  FDigitoContaID := AOfx.FDigitoContaID;
  FAgenciaID     := AOfx.FAgenciaID;
  FOrganizacao   := AOfx.FOrganizacao;
  FTipoConta     := AOfx.FTipoConta;
  FValorInicial  := AOfx.FValorInicial;
  FValorFinal    := AOfx.FValorFinal;
  FDataInicial   := AOfx.FDataInicial;
  FDataFinal     := AOfx.FDataFinal;
  FChaveOFX      := AOfx.FChaveOFX;

  FMovimentacoes.Clear;
  for I := 0 to Pred(AOfx.Movimentacoes.Count) do
  begin
    FMovimentacoes.Add(TOFXItem.Create);
    FMovimentacoes.Last.Assign(AOfx.Movimentacoes[I]);
  end;
end;


constructor TOFX.Create;
begin
  inherited;
  FMovimentacoes := TObjectList<TOFXItem>.Create;
end;

destructor TOFX.Destroy;
begin
  FMovimentacoes.Clear;
  FMovimentacoes.Free;

  inherited;
end;

function TOFX.GetAgenciaID: String;
begin

  Result := GetAgenciaPelaChaveOFX;
  If Not fEmptyStr(Result) Then Exit;


  if FAgenciaID <> '' then
    Result := FAgenciaID
  else
  begin
    if Pos('/', FChaveOFX) > 0 then
      Result := Trim(Copy(FChaveOFX, 1, Pos('/', FChaveOFX)-1))
    else
    begin
      if (Length(FChaveOFX) > 4) And (Trim(Copy(FChaveOFX, 1, 4))<>'0000') then
        Result := Trim(Copy(FChaveOFX, 1, 4))
      else
        Result := '';

      if (BancoID = '104') And (Length(FChaveOFX) = 9) Then
        Result := '';

      if (BancoID = '001') and (Length(FChaveOFX) <= 8) then
        Result := '';

      if (BancoID = '237') and (Length(FChaveOFX) <= 8) then
        Result := '';

      if (BancoID = '004') and (Length(FChaveOFX) <= 7) then
        Result := '';
    end;

  end;
end;

function TOFX.GetBancoID: String;
begin
  if Length(FBancoID) > 3 then
    Result := Copy(FBancoID, 2, 3)
  else
    Result := FBancoID;
end;

function TOFX.GetChaveOFX: String;
begin
  Result := FChaveOFX;
end;

function TOFX.GetContaID: String;
begin
  Result := ProcessaStringContaID(FContaID);
end;

{*Busca a conta bancaria pela:
1 - Chave OFX;
2 - Pelo processamento da chave OFX.
Se utilizou o segundo metodo atualiza a chave na conta bancaria localizada*}
function TOFX.GetContaPelaChaveOFX: String;
var SContaBancariaRepository : TCadCCaRepository;
    SContaBancaria           : TCadCCa;
begin
  SContaBancariaRepository := TCadCCaRepository.Create;
  try
    SContaBancaria := SContaBancariaRepository.GetContaBancaria(BancoID, '', '', FChaveOFX);

    if Assigned(SContaBancaria) then
    Begin
      Result := SContaBancaria.CodigoConta;
      FDigitoContaID := SContaBancaria.DigitoConta.ValueOrDefault;
    End
    else
    begin
      Result := ProcessaStringContaID(FChaveOFX);
      SContaBancaria := SContaBancariaRepository.GetContaBancaria(BancoID, GetAgenciaID, Result);
      if Assigned(SContaBancaria) then
        begin
          FDigitoContaID := SContaBancaria.DigitoConta.ValueOrDefault;
          SContaBancaria.ChaveOFX := FChaveOFX;
          SContaBancariaRepository.pAtualizar;
        end;
    end;
  finally
    FreeAndNil(SContaBancariaRepository);
  end;
end;

function TOFX.GetAgenciaPelaChaveOFX: String;
var SContaBancariaRepository : TCadCCaRepository;
    SContaBancaria           : TCadCCa;
begin
  SContaBancariaRepository := TCadCCaRepository.Create;
  try
    SContaBancaria := SContaBancariaRepository.GetContaBancaria(BancoID, '', '', FChaveOFX);

    if Assigned(SContaBancaria) then
      Result := SContaBancaria.CodigoAgencia;

  finally
    FreeAndNil(SContaBancariaRepository);
  end;
end;

function TOFX.GetDataFinal: TDate;
begin
  Result := FDataFinal;
end;

function TOFX.GetDataInicial: TDate;
begin
  Result := FDataInicial;
end;

function TOFX.GetMovimentacoes: TObjectList<TOFXItem>;
begin
  Result := FMovimentacoes;
end;

function TOFX.GetOrganizacao: String;
begin
  Result := FOrganizacao;
end;

function TOFX.GetTipoConta: String;
begin
  Result :=  FTipoConta;
end;

function TOFX.GetValorFinal: Double;
begin
  Result := FValorFinal;
end;

function TOFX.GetValorInicial: Double;
begin
  Result := FValorInicial;
end;

function TOFX.ProcessaStringContaID(AConta: String): String;
begin
  if Pos('/', AConta) > 0 then
    Result := Trim(Copy(AConta, Pos('/', AConta)+1, Length(AConta)))
  else
  begin
    if (BancoID = '001') and (Length(AConta) > 8) then
      Result := Copy(AConta, 5, 8)
    else if (BancoID = '001') and (Length(AConta) <= 8) then
    Begin
      If Pos('-', AConta) > 0 Then
        Result := Copy(AConta, 1, Pos('-', AConta)-1)
      Else
        Result :=  AConta;
    End
    else if (BancoID = '033') and (Length(AConta) > 8) and (Pos('-', AConta) <= 0) then
      Result := Copy(AConta, 5, 8)
    else if (BancoID = '041') and (Length(AConta) > 9) and (Pos('-', AConta) <= 0) then
      Result := Copy(AConta, 5, 9)
    else if (BancoID = '104') and (Length(AConta) > 9) and (Pos('-', AConta) <= 0) then
      Result := Copy(AConta, 5, 8)
    else if (BancoID = '104') and (Length(AConta) = 9) and (Pos('-', AConta) <= 0) then
      Result := Copy(AConta, 1, 8)
    else if (BancoID = '237') and (Length(AConta) > 8) and (Pos('-', AConta) <= 0) then
      Result := Copy(AConta, 6, 8)
    else if (BancoID = '341') and (Length(AConta) > 5) and (Pos('-', AConta) <= 0) then
      Result := Copy(AConta, 5, 5)
    else if (BancoID = '745') and (Length(AConta) > 7) and (Pos('-', AConta) <= 0) then
      Result := Copy(AConta, 5, 7)
    else
      Result := AConta;
  end;
end;

procedure TOFX.SetAgenciaID(const Value: String);
begin
  FAgenciaID := Value;
end;

procedure TOFX.SetBancoID(const Value: String);
begin
  FBancoID := Value;
end;

procedure TOFX.SetContaID(const Value: String);
begin
  FContaID := Value;
end;

procedure TOFX.SetChaveOFX(const AValue: String);
begin
  FChaveOFX := AValue;
end;

procedure TOFX.SetDataFinal(const Value: TDate);
begin
  FDataFinal := Value;
end;

procedure TOFX.SetDataInicial(const Value: TDate);
begin
  FDataInicial := Value;
end;

procedure TOFX.SetMovimentacoes(const Value: TObjectList<TOFXItem>);
begin
  FMovimentacoes := Value;
end;

procedure TOFX.SetOrganizacao(const Value: String);
begin
  FOrganizacao := Value;
end;

procedure TOFX.SetTipoConta(const Value: String);
begin
  FTipoConta := Value;
end;

procedure TOFX.SetValorFinal(const Value: Double);
begin
  FValorFinal := Value;
end;

procedure TOFX.SetValorInicial(const Value: Double);
begin
  FValorInicial := Value;
end;

{ TLeitorOFX }

function TLeitorOFX.CorrigirTexto(AText: String): String;
begin
  Result := AText;
  Result := Result.Replace('Ãº', 'ú');
  Result := Result.Replace('Ã§', 'ç');
  Result := Result.Replace('Ã£', 'ã');
  Result := Result.Replace('Ã©', 'é');
  Result := Result.Replace('Ã-', 'í');
  Result := Result.Replace('Ãµ', 'õ');
  Result := Result.Replace('Ãª', 'ê');
  Result := Result.Replace('Ã¡', 'á');
end;

constructor TLeitorOFX.Create;
begin
  inherited;
  FNomeArquivo := '';
end;

destructor TLeitorOFX.Destroy;
begin
  if Assigned(FArquivo) then
    FArquivo.Free;

  inherited;
end;

function TLeitorOFX.EncontrarTagMovimentacao(ATag:String; AArquivo: TStringList;APosicao: Integer): String;
begin
  Result := '';

  if (APosicao < 0) or (APosicao >= AArquivo.Count) then
    Exit;

  while (APosicao < AArquivo.Count) and
        (not fEncontrarTexto('</STMTTRN>', AArquivo.Strings[APosicao])) do
  begin
    if fEncontrarTexto(ATag, AArquivo.Strings[APosicao]) then
    begin
      Result := AArquivo.Strings[APosicao];
      Break;
    end;

    Inc(APosicao);
  end;
end;

function TLeitorOFX.fEncontrarTexto(ATag: String; Var strTexto: String; AArquivo: TStringList; APosicao: Integer): Boolean;
  Var
    LValorTag : String;
begin
  Result := Pos(UpperCase(ATag), UpperCase(strTexto)) > 0;

  If Not Result Then
    LValorTag := EncontrarTagMovimentacao(ATag,AArquivo,APosicao);

  If Not fEmptyStr(LValorTag) Then
  Begin
    Result := True;
    strTexto := LValorTag;
  End;

end;

function TLeitorOFX.fEncontrarTexto(strValorTag, strTexto: String): Boolean;
begin
  Result := Pos(UpperCase(strValorTag), UpperCase(strTexto)) > 0;
End;

function TLeitorOFX.fPegaValorTag(strTexto: String): String;
var
  i, j : integer;
begin
  Result := '';
  strTexto := Trim(strTexto);
  if fEncontrarTexto('>', strTexto) then
  begin
    strTexto := Trim(strTexto);
    i := Pos('>', strTexto);
    Result := copy(strTexto, i+1, Length(strTexto)-i+1);
    j := Pos('</', Result);
    if j > 0 then
      Result := copy(Result, 1, j-1);
  end;
end;

function TLeitorOFX.fPrepararValor(strValor: String): String;
begin
  Result := strValor;

  if fTemSeparadorMilharEDecimal(strValor) then
    Result := fRemoverSeparadorMilhar(strValor);

  Result := StringReplace(Result, '.', ',',[]);
end;

function TLeitorOFX.fProcessarArquivo(var strNomeArquivo: String): Boolean;
  var
    LGravando: TfrmGravando;
begin
  if FileExists(strNomeArquivo) then
  begin
    FNomeArquivo := strNomeArquivo;

    pCriarFormularios(TfrmGravando, LGravando);
    Try
      LGravando.lblGravando.Caption := 'Extraindo Informações do Arquivo OFX...';
      LGravando.fExecutarAcao := ProcessandoArquivoSelecionado;
      LGravando.ShowModal;

      Result := LGravando.blnConfirma;
    Finally
      FreeAndNil(LGravando);
    End;
  End
  else
    raise exception.create('Arquivo OFX não encontrado!');
end;

function TLeitorOFX.fTemSeparadorMilharEDecimal(AValor: String): Boolean;
begin
  Result := False;

  If Pos(',', AValor) = 0 then
    Exit;

  If Pos('.', AValor) = 0 then
    Exit;

  Result := True;
end;

function TLeitorOFX.fRemoverSeparadorMilhar(AValor: String): String;
var
  LSeparadorMilhar: String;
begin
  If AValor.LastIndexOf(',') > AValor.LastIndexOf('.') then
    LSeparadorMilhar := '.'
  Else
    LSeparadorMilhar := ',';

  Result := StringReplace(AValor, LSeparadorMilhar, '', [rfReplaceAll]);
  Result := StringReplace(AValor, LSeparadorMilhar, '', [rfReplaceAll]);
end;

function TLeitorOFX.RetornaTipoMovimento(AValor: Double; ATipo: String): String;
begin
  if (AValor < 0) then
    Result := 'D'
  else if (Pos('DEBIT', UpperCase(ATipo)) > 0) then
    Result := 'D'
  else
    Result := 'C';
end;

function TLeitorOFX.NormalizarOFX(AOfx: String): String;
begin
  AOfx := StringReplace(AOfx, '<', sLineBreak + '<', [rfReplaceAll]); // Quebra entre tags
  Result := AOfx;
end;

function TLeitorOFX.OFXPossuiMovimentacao(const AArquivo: TStringList): Boolean;
var
  I, J: Integer;
  BancoID, Linha, LinhaInterna, Valor: string;
  EncontrouBankTranList, EncontrouStmtTrnValida: Boolean;
begin
  BancoID := '';
  EncontrouBankTranList := False;
  EncontrouStmtTrnValida := False;

  for I := 0 to AArquivo.Count - 1 do
  begin
    Linha := AArquivo[I];
    if Pos('<BANKID>', Linha) > 0 then
    begin
      BancoID := fPegaValorTag(Trim(Linha));
      BancoID := fStrZero(BancoID, 3);

      if Length(BancoID) > 3 then
        BancoID := Copy(BancoID, 2, 3);

      Break;
    end;
  end;

  if BancoID <> '341' then
  begin
    Result := True;
    Exit;
  end;

  for I := 0 to AArquivo.Count - 1 do
  begin
    Linha := AArquivo[I];

    if Pos('<BANKTRANLIST>', Linha) > 0 then
      EncontrouBankTranList := True

    else if Pos('</BANKTRANLIST>', Linha) > 0 then
      Break

    else if EncontrouBankTranList and (Pos('<STMTTRN>', Linha) > 0) then
    begin
      J := I + 1;
      while (J < AArquivo.Count) and (Pos('</STMTTRN>', AArquivo[J]) = 0) do
      begin
        LinhaInterna := AArquivo[J];

        if (Pos('<MEMO>', LinhaInterna) > 0) and
           ((Pos('NÃO POSSUI LANÇAMENTOS', UpperCase(LinhaInterna)) > 0) or
            (Pos('SEM LANÇAMENTOS', UpperCase(LinhaInterna)) > 0)) then
        begin
          EncontrouStmtTrnValida := False;
          Break;
        end;

        if (Pos('<TRNAMT>', LinhaInterna) > 0) then
        begin
          Valor := fPegaValorTag(LinhaInterna);
          if (Trim(Valor) <> '') and (Valor <> '0') then
            EncontrouStmtTrnValida := True;
        end;

        Inc(J);
      end;

      if EncontrouStmtTrnValida then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;

  Result := False;
end;


function TLeitorOFX.ProcessandoArquivoSelecionado(
  pgbStatus: TcxProgressBar): Boolean;
  var
    stlArquivo :TStringList;
    i: Integer;
    blnTemConteudo: Boolean;
    strLinha: String;
    LValorMemoSecundario : String;
    Item: TOFXItem;
    dteMinData, dteMaxData: TDate;
    LMovimentacao: Integer;

    LDataTexto: String;
Begin
  blnTemConteudo := False;

  stlArquivo := TStringList.Create;

  Try
    stlArquivo.LoadFromFile(FNomeArquivo,TEncoding.UTF8);
  Except
    stlArquivo.LoadFromFile(FNomeArquivo);
  End;

  stlArquivo.Text := NormalizarOFX(stlArquivo.Text);

  If Not OFXPossuiMovimentacao(stlArquivo) Then
  Begin
    fMensagem('ATENÇÃO!', 'Extrato sem movimentação!',['&OK']);
    Exit(False);
  End;


  i := 0;
  dteMinData := fNow;
  dteMaxData := 0;

  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := stlArquivo.Count;

  while i < stlArquivo.Count do
  begin
    pStepStatusGravacao(pgbStatus);

    strLinha := stlArquivo.Strings[i];
    if fEncontrarTexto('<OFX>', strLinha) then
    begin
      blnTemConteudo := True;
      FArquivo := TOFX.Create;
    end;

    if blnTemConteudo then
    begin
      with FArquivo do
      begin
        //Pegando os dados base do extrato(Banco, Ag, CC...)
        if fEncontrarTexto('<BANKID>',   strLinha) then
        begin
          BancoID := fPegaValorTag(Trim(strLinha));
          if MatchStr(BancoID,['1','21','84']) then
            BancoID := fStrZero(BancoID, 3);
        end;
        if fEncontrarTexto('<ACCTID>',   strLinha) then
          ChaveOFX := fPegaValorTag(Trim(strLinha));
        if fEncontrarTexto('<BRANCHID>', strLinha) then
          AgenciaID := fPegaValorTag(Trim(strLinha));
        if fEncontrarTexto('<ACCTTYPE>', strLinha) then
          TipoConta := fPegaValorTag(Trim(strLinha));

        Try
          if fEncontrarTexto('<DTSTART>',  strLinha) then
          Begin
            LDataTexto  := fTiraCaracEspeciaisPonto(fPegaValorTag(strLinha));

            DataInicial := EncodeDate(StrToIntDef(copy(LDataTexto,1,4), 0),
                                      StrToIntDef(copy(LDataTexto,5,2), 0),
                                      StrToIntDef(copy(LDataTexto,7,2), 0));
          End;
        Except
          raise Exception.Create('Data inicial do extrato(tag: <DTSTART>), inválida no arquivo! Verifique o arquivo .OFX!');
        End;

        Try
          if fEncontrarTexto('<DTEND>', strLinha) then
          Begin
            LDataTexto := fTiraCaracEspeciaisPonto(fPegaValorTag(strLinha));

            DataFinal  := EncodeDate(StrToIntDef(copy(LDataTexto,1,4), 0),
                                     StrToIntDef(copy(LDataTexto,5,2), 0),
                                     StrToIntDef(copy(LDataTexto,7,2), 0));
          End;
        Except
          raise Exception.Create('Data final do extrato(tag: <DTEND>), inválida no arquivo! Verifique o arquivo .OFX!');
        End;

        if fEncontrarTexto('<ORG>', strLinha)      then Organizacao   := fPegaValorTag(strLinha);

        //Pegando as movimentações do extrato(Transferências, depósitos...);
        if fEncontrarTexto('<STMTTRN>', strLinha) then
        begin
          Item :=  TOFXItem.Create;
          Item.CheckNum := '';
          LMovimentacao := i;
          Inc(i);
          strLinha := stlArquivo.Strings[i];
          if fEncontrarTexto('<TRNTYPE>',  strLinha,stlArquivo,LMovimentacao) then Item.Tipo := fPegaValorTag(strLinha);

          Inc(i);
          strLinha := stlArquivo.Strings[i];

          Try
            if fEncontrarTexto('<DTPOSTED>', strLinha,stlArquivo,LMovimentacao) then
            begin
              LDataTexto := fTiraCaracEspeciaisPonto(fPegaValorTag(strLinha));
              Item.Data := EncodeDate(StrToIntDef(copy(LDataTexto,1,4), 0),
                                      StrToIntDef(copy(LDataTexto,5,2), 0),
                                      StrToIntDef(copy(LDataTexto,7,2), 0));
            end;
          Except
            if fEncontrarTexto('<CHECKNUM>', strLinha,stlArquivo,LMovimentacao) then
            begin
              Item.CheckNum := fTiraCaracEspeciaisPonto(fPegaValorTag(strLinha));
              Item.Data := EncodeDate(StrToIntDef(copy(Item.CheckNum,1,4), 0),
                                      StrToIntDef(copy(Item.CheckNum,5,2), 0),
                                      StrToIntDef(copy(Item.CheckNum,7,2), 0));
            end;
          End;

          If Item.Data = 0 Then
            if fEncontrarTexto('<FITID>', strLinha,stlArquivo,LMovimentacao) then
              Item.Data := EncodeDate(StrToIntDef(copy(fPegaValorTag(strLinha),1,4), 0),
                                      StrToIntDef(copy(fPegaValorTag(strLinha),5,2), 0),
                                      StrToIntDef(copy(fPegaValorTag(strLinha),7,2), 0));

          if Item.Data > dteMaxData then
             dteMaxData := Item.Data;

          if Item.Data < dteMinData then
             dteMinData := Item.Data;

          Inc(i);
          strLinha := stlArquivo.Strings[i];
          if fEncontrarTexto('<TRNAMT>',  strLinha,stlArquivo,LMovimentacao)  then Item.Valor := fStrToFloat(fPrepararValor(fPegaValorTag(strLinha)));

          Item.Tipo := RetornaTipoMovimento(Item.Valor, Item.Tipo);

          if Item.Valor < 0 then
             Item.Valor  := Item.Valor * (-1);

          Inc(i);
          strLinha := stlArquivo.Strings[i];
          if fEncontrarTexto('<FITID>',  strLinha,stlArquivo,LMovimentacao)   then Item.ID := fPegaValorTag(strLinha);

          Inc(i);
          strLinha := stlArquivo.Strings[i];

          if fEmptyStr(Item.CheckNum) And fEncontrarTexto('<CHECKNUM>', strLinha, stlArquivo, LMovimentacao) then
            Item.CheckNum := fPegaValorTag(strLinha);

          if fEncontrarTexto('<MEMO>',  strLinha,stlArquivo,LMovimentacao) then
          begin
            Item.Descricao := CorrigirTexto(fPegaValorTag(strLinha));

            if fTemMemoSecundario(stlArquivo, LMovimentacao, LValorMemoSecundario) Then
              Item.Descricao := Item.Descricao + ' - ' + LValorMemoSecundario;
          end
          Else
          begin
            if Not fEmptyStr(Item.CheckNum) then
              Item.Documento := Item.CheckNum;

            If fEncontrarTexto('<NAME>',  strLinha,stlArquivo,LMovimentacao) then
              Item.Descricao := CorrigirTexto(fPegaValorTag(strLinha));
          end;

          Inc(i);
          strLinha := stlArquivo.Strings[i];
          if fEncontrarTexto('<PAYEEID>',  strLinha,stlArquivo,LMovimentacao) then
          begin
            Inc(i);
            strLinha := stlArquivo.Strings[i];
          end
          Else
          if fEncontrarTexto('<REFNUM>',  strLinha,stlArquivo,LMovimentacao) then
          begin
            Inc(i);
            strLinha := stlArquivo.Strings[i];
          end;

          Movimentacoes.Add(Item);
        end;
      end;

    end;
    Inc(i);

  end;

  if blnTemConteudo then
  begin
    if Assigned(FArquivo) then
    begin
      FArquivo.DataInicial := dteMinData;
      FArquivo.DataFinal   := dteMaxData;
    end;
  end;

  if Assigned(FArquivo) then
  begin
    if FArquivo.Movimentacoes.Count <= 0 then
    Begin
      fMensagem('ATENÇÃO!', 'Extrato sem movimentação!',['&OK']);
      Exit(False);
    End
    else
      Result := True;
  end
  else
    raise exception.create('Arquivo inválido!');
End;

function TLeitorOFX.GetArquivo: TOFX;
begin
  Result := FArquivo;
end;

function TLeitorOFX.fTemMemoSecundario(AArquivo: TStringList;
                                       AIndiceMovimentacao: Integer;
                                       out AValorMemoSecundario: String): Boolean;
var
  LMemos: TStringList;
  LPosicao: Integer;
begin
  Result := False;
  AValorMemoSecundario := '';

  LMemos := TStringList.Create;
  try
    LMemos.Sorted := False;

    LPosicao := AIndiceMovimentacao;
    while (LPosicao < AArquivo.Count) do
    begin
      if fEncontrarTexto('</STMTTRN>', AArquivo[LPosicao]) then
        Break;

      if fEncontrarTexto('<MEMO>', AArquivo[LPosicao]) then
        LMemos.Add(AArquivo[LPosicao]);

      Inc(LPosicao);
    end;

    if LMemos.Count > 1 then
    begin
      for LPosicao := 1 to Pred(LMemos.Count) do
      begin
        if fEmptyStr(AValorMemoSecundario) then
          AValorMemoSecundario := AValorMemoSecundario + fPegaValorTag(LMemos[LPosicao])
        else
          AValorMemoSecundario := AValorMemoSecundario + ' - ' + fPegaValorTag(LMemos[LPosicao])
      end;

      AValorMemoSecundario := CorrigirTexto(AValorMemoSecundario);

      Result := AnsiPos(AValorMemoSecundario, LMemos[0]) = 0;
    end;
  finally
    FreeAndNil(LMemos);
  end
end;

procedure TLeitorOFX.SetArquivo(const Value: TOFX);
begin
  FArquivo := Value;
end;

end.
