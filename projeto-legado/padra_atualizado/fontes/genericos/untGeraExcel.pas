unit untGeraExcel;

interface

uses Classes, untExcel, DB, ComCtrls, Forms, MaskUtils, DBGridCitel, DBGrids, cxProgressBar,
     StrUtils, cxGridDBTableView, untTypesSistema;

Type
  TFuncaoDouble             = Function(dtsDados: TDataSet): Double Of Object;
  TFuncaoString             = Function(dtsDados: TDataSet): String Of Object;
  TFuncaoDoubleSemParametro = Function: Double Of Object;
  TFuncaoStringSemParametro = Function: String Of Object;

  TTotais = Class
    private
      FTotais: Array Of Double;
      FLista : TStringList;

      function GetValor(Index: String): Double;
      procedure SetValor(Index: String; Valor: Double);

    public
      constructor Create;
      destructor Destroy; Override;

      procedure Zerar;

      property Campo[Index: String]: Double Read GetValor write SetValor; default;
      property Campos: TStringList read FLista;

  End;

Type
  TRecCampos = Record
    Descricao,
    NomeCampo: String;
    Coluna: Integer;
    Letra: String;
    Tipo: TFieldType;
    Precisao: Integer;
    DataSet: TDataSet;

    FuncaoCampo            : TFuncaoDouble;
    FuncaoCampoString      : TFuncaoString;
    FuncaoCampoSemPar      : TFuncaoDoubleSemParametro;
    FuncaoCampoStringSemPar: TFuncaoStringSemParametro;
  End;

Type
  TCampos = Class
    private
      FCampos: Array Of TRecCampos;
      FLista : TStringList;

      function GetColuna(Index: String): TRecCampos;overload;
      function GetColunaInt(Index: Integer): TRecCampos;overload;

      procedure SetColuna(Index: String; Campo: TRecCampos);

    public
      constructor Create;
      destructor Destroy; Override;

      procedure TrocaRefer(NomeOriginal, NovoNome, NovaDescricao:String);

      property ColunaPorNome[Index: String] : TRecCampos Read GetColuna write SetColuna; default;
      property ColunaPorIndice[Index: Integer]: TRecCampos Read GetColunaInt;
      property Colunas: TStringList read FLista;

  End;

Type
  TRecQuebras = Record
    NomeCampo,
    CampoDescricao,
    Titulo,
    ValorAtual,
    ValorAtualDescricao: String;
    Totais: TTotais;
    ImprTitulo: Boolean;
  End;

Type
  TArrQuebras = Array Of TRecQuebras;

Type
  TImpDetalhes  = procedure(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel) Of Object;
  TMontaResumo  = procedure(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras) Of Object;
  TSomaTotais   = procedure(Var Totais: TTotais; Dados: TDataSet) Of Object;
  TImpFiltros   = procedure(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Filtros: Array Of String) Of Object;
  TImpTitGrupo  = procedure(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Quebra: TRecQuebras) Of Object;
  TImpTitColuna = procedure (Excel: TExcel; Campos: TCampos) Of Object;
  TFimGeracao   = procedure(Excel: TExcel; Campos: TCampos) Of Object;

Type
  TQuebras = Class
    private
      FQuebras: TArrQuebras;
      FLista  : TStringList;

    public
      constructor Create;
      destructor Destroy; Override;

      procedure SomarTotais(pSomar: TSomaTotais; Dados: TDataSet);

      procedure Add(Quebra: TRecQuebras);
      procedure Delete(Quebra: TRecQuebras);

      function Count: Integer;

      property Quebras: TArrQuebras read FQuebras write FQuebras;

  End;

Type
  {$M+}
  TGeraExcel = Class
    private
      FInitialDirDeskTop: Boolean;

      FExcel  : TExcel;
      FCampos : TCampos;
      FQuebras: TQuebras;
      FDados  : TDataSet;
      FProgres: TProgressBar;
      FcxProgres: TcxProgressBar;
      FQtdCol : Integer;
      FUltCol : String;
      FFiltros: Array Of String;
      FNomRel : String;
      FFonteNomRel: Integer;
      FCongelarPaineis: Boolean;
      FDefinirBordas: Boolean;
      FLinhaInicial: Integer;
      FTestaArq: Boolean;

      pResumo : TMontaResumo;
      pSomaRes: TSomaTotais;
      pImpFiltros: TImpFiltros;
      pImpDet : TImpDetalhes;
      pImpTitGru: TImpTitGrupo;
      pFimGeracao: TFimGeracao;
      pImpTitColuna: TImpTitColuna;

      FImpEmp: Boolean;
      FNomArq: String;
      FMsgRod: String;
      FAlinhaEsquerdaTitulo,
      FImpTitColFim: Boolean;

      procedure pIniciaGeracao;
      procedure pMontaTitulos;
      procedure pTituloGrupo;
      procedure pFormataDetalhes(intLinIni, intLinFin : Integer);
      procedure pImprimeDetalhes;
      procedure pResumoGrupo;
      procedure pImprimeMsgRodape;
      procedure pFinalizaGeracao;

      procedure pMontaTituloColunas;
      procedure pMontaTituloGrupo(Titulo: String);
      procedure pNext;

      function fNovaQuebra: Boolean;

      function fColunaComoLetra(intColuna: Integer): String;

    protected
      function fGerarRelatorioInterna(cxProgress : TcxProgressBar): Boolean;

    public
      class Function fGerarRelatorio(dbgDados : TDBGridCitel; strTitulo : String): Boolean; Overload;
      class function fGerarRelatorio(cxvDados : TcxGridDBTableView; strTitulo : String): Boolean; overload;
      class function fGerarRelatorio(cxgDados : TcxGridDBTableView; strTitulo : String; Detalhes: TImpDetalhes): Boolean; overload;

      class function fUserDesktop(): String;

      constructor Create(Dados: TDataSet; Progresso: TProgressBar);
      Destructor Destroy; Override;

      function fGerarRelatorio(blnDirDeskTop: Boolean = False): Boolean; Overload;

      procedure AddCampo (Nome, Descricao: String; Precisao: Integer = 2; DataSet: TDataSet = Nil); Overload;
      procedure AddCampo (Funcao: TFuncaoDouble; Nome, Descricao: String; Precisao: Integer = 2); Overload;
      procedure AddCampo (Funcao: TFuncaoString; Nome, Descricao: String); Overload;

      procedure AddCampo (Funcao: TFuncaoDoubleSemParametro; Nome, Descricao: String; Precisao: Integer = 2); Overload;
      procedure AddCampo (Funcao: TFuncaoStringSemParametro; Nome, Descricao: String); Overload;
      procedure TrocaRefCampo(NomeOriginal, NovoNome, NovaDescricao:String);

      procedure AddQuebra(Nome, Descricao: String; ImprTitulo: Boolean = True; CampoDescricao: String = '');
      procedure DelQuebra(Nome: String);
      procedure AddFiltro(Descricao: String);
      procedure AddTotais(Descricao: String);
      Procedure pSetaFiltrosExcel(arrFiltros: TArrRecFiltros);

    published

      property blnImpEmp: Boolean read FImpEmp write FImpEmp;
      property strNomArq: String  read FNomArq write FNomArq;

      property strNomRel: String read FNomRel write FNomRel;

      property blnAlinhaEsquerdaTitulo: Boolean read FAlinhaEsquerdaTitulo Write FAlinhaEsquerdaTitulo;

      property intFonteNomRel: Integer read FFonteNomRel write FFonteNomRel;

      property strMsgRod: String read FMsgRod write FMsgRod;
      property objExcel: TExcel  read FExcel  write FExcel;

      property blnCongelarPaineis: Boolean Read FCongelarPaineis Write FCongelarPaineis;
      property blnDefinirBordas: Boolean Read FDefinirBordas Write FDefinirBordas;
      property blnImpTitColFim: Boolean Read FImpTitColFim Write FImpTitColFim;

      property blnTestaArq: Boolean read FTestaArq write FTestaArq;

      property OnImpDetalhes : TImpDetalhes  read pImpDet       write pImpDet;
      property OnMontaResumo : TMontaResumo  read pResumo       write pResumo;
      property OnSomaResumo  : TSomaTotais   read pSomaRes      write pSomaRes;
      property OnImpFiltros  : TImpFiltros   read pImpFiltros   write pImpFiltros;
      property OnImpTitGrupo : TImpTitGrupo  read pImpTitGru    write pImpTitGru;
      property OnFimGeracao  : TFimGeracao   read pFimGeracao   write pFimGeracao;
      property OnImpTitColuna: TImpTitColuna read pImpTitColuna write pImpTitColuna;
  End;
    {$M-}
implementation


uses  untFuncoesSimples, untFuncoesGenerica, SysUtils, untGravando, Registry, Windows;

Constructor TTotais.Create;
begin
  inherited Create;
  SetLength(FTotais, 0);
  FLista     := TStringList.Create;
end;

Destructor TTotais.destroy;
begin
  SetLength(FTotais, 0);
  FreeAndNil(FLista);
  inherited destroy;
end;

function TTotais.GetValor(Index: String): Double;
begin
  If FLista.IndexOf(Index) = -1 Then
    Result := 0
  Else
    Result := FTotais[FLista.IndexOf(Index)];
end;

procedure TTotais.SetValor(Index: String; Valor: Double);
begin
  If FLista.IndexOf(Index) = -1 Then
  Begin
    FLista.Add(Index);
    SetLength(FTotais, FLista.Count);
    FTotais[FLista.Count -1] := Valor;
  End
  Else
    FTotais[FLista.IndexOf(Index)] := Valor;
end;

procedure TTotais.Zerar;
  Var
    intCont: Integer;
begin
  For intCont := 0 To FLista.Count -1 Do
    FTotais[intCont] := 0;
end;

Constructor TCampos.Create;
begin
  inherited Create;
  SetLength(FCampos, 0);
  FLista := TStringList.Create;
end;

Destructor TCampos.destroy;
begin
  SetLength(FCampos, 0);
  FreeAndNil(FLista);
  inherited destroy;
end;

function TCampos.GetColuna(Index: String): TRecCampos;
begin
  Result := FCampos[FLista.IndexOf(Index)];
end;

function TCampos.GetColunaInt(Index: Integer): TRecCampos;
begin
  Result := FCampos[Index - 1];
end;

procedure TCampos.SetColuna(Index: String; Campo: TRecCampos);
begin

  If FLista.IndexOf(Index) = -1 Then
  Begin
    FLista.Add(Index);
    SetLength(FCampos, FLista.Count);
    FCampos[FLista.Count -1] := Campo;
  End
  Else
    FCampos[FLista.IndexOf(Index)] := Campo;

  FCampos[FLista.IndexOf(Index)].Coluna := FLista.IndexOf(Index) + 1;
  FCampos[FLista.IndexOf(Index)].Letra  := fGetLetraAlfa(FLista.IndexOf(Index) + 1);

end;

procedure TCampos.TrocaRefer(NomeOriginal, NovoNome, NovaDescricao: String);
 Var
  idx:integer;
begin
  idx := FLista.IndexOf(NomeOriginal);
  If idx <> -1 Then
  Begin
     FCampos[idx].NomeCampo:=NovoNome;
     FCampos[idx].Descricao:=NovaDescricao;
  End;
end;

Constructor TQuebras.Create;
begin
  inherited Create;
  SetLength(FQuebras, 0);
  FLista := TStringList.Create;
end;

procedure TQuebras.Delete(Quebra: TRecQuebras);
  function RemoveElemento(var pArray: TArrQuebras; const pIndex:integer):boolean;
    Var
    idxCont :integer;
  begin
    Result := (pIndex <= High(pArray)) and (pIndex >= Low(pArray));
    If not(Result) Then
      raise EListError.Create(Format('Indice informado não existe (%s).', [pIndex]))
    Else
      Begin
        For idxCont:= pIndex To High(pArray)-1 Do
        Begin
          pArray[idxCont] := pArray[idxCont+1];
        End;
        SetLength(pArray, Length(pArray)-1);
        Result := True;
      End;
  end;

var
  idx:Integer;

begin
  idx:=FLista.IndexOf(Quebra.NomeCampo);
  If idx <> -1 Then
  Begin
    if Assigned(FQuebras[idx].Totais) then
     FreeAndNil(FQuebras[idx].Totais);

    RemoveElemento(FQuebras,idx);
    FLista.Delete(idx);
    SetLength(FQuebras, FLista.Count);
  End;
end;

Destructor TQuebras.destroy;
  Var
    intCont: Integer;
begin
  For intcont := Low(FQuebras) To High(FQuebras) Do
    If Assigned(FQuebras[intcont].Totais) Then
      FreeAndNil(FQuebras[intcont].Totais);

  SetLength(FQuebras, 0);
  FreeAndNil(FLista);
  inherited destroy;
end;

procedure TQuebras.SomarTotais(pSomar: TSomaTotais; Dados: TDataSet);
  Var
    intCont: Integer;
begin
  If Assigned(pSomar) Then
    For intCont := Low(FQuebras) To High(FQuebras) Do
      pSomar(FQuebras[intCont].Totais, Dados);
end;

procedure TQuebras.Add(Quebra: TRecQuebras);
begin
  If FLista.IndexOf(Quebra.NomeCampo) = -1 Then
  Begin
    FLista.Add(Quebra.NomeCampo);
    SetLength(FQuebras, FLista.Count);
    FQuebras[FLista.Count -1] := Quebra;
  End;
end;

function TQuebras.Count: Integer;
begin
  Result := FLista.Count;
end;

constructor TGeraExcel.Create(Dados: TDataSet; Progresso: TProgressBar);
begin
  inherited Create;

  FAlinhaEsquerdaTitulo := False;

  FTestaArq := False;
  FDados   := Dados;
  FProgres := Progresso;
  FExcel   := TExcel.fCriarExcel(Nil); //TExcel.Create;

  FNomRel  := '';
  FFonteNomRel := -1;

  FNomArq  := '';

  FImpEmp  := True;
  FCongelarPaineis := True;
  FDefinirBordas := True;
  FImpTitColFim := True;

  FCampos  := TCampos.Create;
  FQuebras := TQuebras.Create;

  SetLength(FFiltros, 0);

  AddQuebra('[GERAL]', '[GERAL]');

end;

procedure TGeraExcel.DelQuebra(Nome: String);
  Var
    recQuebra: TRecQuebras;
begin
  recQuebra.NomeCampo := Nome;
  FQuebras.Delete(recQuebra);
end;

Destructor TGeraExcel.Destroy;
begin

  If Assigned(FQuebras) Then
    FreeAndNil(FQuebras);

  If Assigned(FExcel) Then
    FreeAndNil(FExcel);

  If Assigned(FCampos) Then
    FreeAndNil(FCampos);

  inherited Destroy;
end;

procedure TGeraExcel.pMontaTituloGrupo(Titulo: String);
begin
  With FExcel Do
  Begin
    Escrever(ProximaLinha, 01, Titulo);
    Negrito (LinhaAtual, 01, True);
    Mesclar ('A' + IntToStr(LinhaAtual), FUltCol + IntToStr(LinhaAtual));
    CorFundo('A' + IntToStr(LinhaAtual), FUltCol + IntToStr(LinhaAtual), Verde_Mar);
    CorFonte('A' + IntToStr(LinhaAtual), FUltCol + IntToStr(LinhaAtual), Branco);
    If FDefinirBordas Then
      Bordas('A' + IntToStr(LinhaAtual), FUltCol + IntToStr(LinhaAtual), True, True, False, False);

  End;
end;

procedure TGeraExcel.pNext;
begin
  FQuebras.SomarTotais(pSomaRes, FDados);

  FDados.Next;

  If Assigned(FProgres) Then FProgres.Position := FDados.RecNo;
  If Assigned(FcxProgres) Then FcxProgres.Position := FDados.RecNo;

  Application.ProcessMessages;
end;

procedure TGeraExcel.AddCampo(Funcao: TFuncaoDouble; Nome, Descricao: String; Precisao: Integer = 2);
  Var
    recCampo: TRecCampos;
begin
  recCampo.NomeCampo               := Nome;
  recCampo.FuncaoCampo             := Funcao;
  recCampo.FuncaoCampoSemPar       := Nil;
  recCampo.FuncaoCampoString       := Nil;
  recCampo.FuncaoCampoStringSemPar := Nil;
  recCampo.DataSet                 := FDados;
  recCampo.Descricao               := Descricao;
  recCampo.Precisao                := Precisao;
  recCampo.Tipo                    := ftFloat;

  FCampos[Nome] := recCampo;
end;

procedure TGeraExcel.AddCampo(Funcao: TFuncaoDoubleSemParametro; Nome, Descricao: String; Precisao: Integer = 2);
  Var
    recCampo: TRecCampos;
begin
  recCampo.NomeCampo               := Nome;
  recCampo.FuncaoCampo             := Nil;
  recCampo.FuncaoCampoSemPar       := Funcao;
  recCampo.FuncaoCampoString       := Nil;
  recCampo.FuncaoCampoStringSemPar := Nil;
  recCampo.DataSet                 := FDados;
  recCampo.Descricao               := Descricao;
  recCampo.Precisao                := Precisao;
  recCampo.Tipo                    := ftFloat;

  FCampos[Nome] := recCampo;
end;

procedure TGeraExcel.AddCampo(Funcao: TFuncaoString; Nome, Descricao: String);
  Var
    recCampo: TRecCampos;
begin
  recCampo.NomeCampo               := Nome;
  recCampo.FuncaoCampo             := Nil;
  recCampo.FuncaoCampoSemPar       := Nil;
  recCampo.FuncaoCampoString       := Funcao;
  recCampo.FuncaoCampoStringSemPar := Nil;
  recCampo.DataSet                 := FDados;
  recCampo.Descricao               := Descricao;
  recCampo.Precisao                := 0;
  recCampo.Tipo                    := ftString;

  FCampos[Nome] := recCampo;
end;

procedure TGeraExcel.AddCampo(Funcao: TFuncaoStringSemParametro; Nome, Descricao: String);
  Var
    recCampo: TRecCampos;
begin
  recCampo.NomeCampo               := Nome;
  recCampo.FuncaoCampo             := Nil;
  recCampo.FuncaoCampoSemPar       := Nil;
  recCampo.FuncaoCampoString       := Nil;
  recCampo.FuncaoCampoStringSemPar := Funcao;
  recCampo.DataSet                 := FDados;
  recCampo.Descricao               := Descricao;
  recCampo.Precisao                := 0;
  recCampo.Tipo                    := ftString;

  FCampos[Nome] := recCampo;
end;

procedure TGeraExcel.AddCampo(Nome, Descricao: String; Precisao: Integer = 2; DataSet: TDataSet = Nil);
  Var
    recCampo: TRecCampos;
begin
  If Not Assigned(DataSet) Then
    DataSet := FDados;

  recCampo.NomeCampo               := Nome;
  recCampo.FuncaoCampo             := Nil;
  recCampo.FuncaoCampoString       := Nil;
  recCampo.FuncaoCampoSemPar       := Nil;
  recCampo.FuncaoCampoStringSemPar := Nil;
  recCampo.DataSet                 := DataSet;
  recCampo.Descricao               := Descricao;

  // PREENCHER COM PRECISÃO = 11 QUANDO FOR FONE, PARA FORMATAR
  recCampo.Precisao                := Precisao;

  recCampo.Tipo                    := recCampo.DataSet.FieldByName(Nome).DataType;

  FCampos[Nome] := recCampo;
end;

procedure TGeraExcel.AddQuebra(Nome, Descricao: String; ImprTitulo: Boolean = True; CampoDescricao: String = '');
  Var
    recQuebra: TRecQuebras;
begin
  recQuebra.NomeCampo           := Nome;
  recQuebra.Titulo              := Descricao;
  recQuebra.ValorAtual          := '< VAZIO >';
  recQuebra.ValorAtualDescricao := '';
  recQuebra.Totais              := TTotais.Create;
  recQuebra.ImprTitulo          := ImprTitulo;
  recQuebra.CampoDescricao      := CampoDescricao;
  FQuebras.Add(recQuebra);
end;

procedure TGeraExcel.AddFiltro(Descricao: String);
begin
  SetLength(FFiltros, Length(FFiltros) + 1);
  FFiltros[Length(FFiltros) - 1] := Descricao;
end;

procedure TGeraExcel.AddTotais(Descricao: String);
  Var
    intcont: Integer;
begin
  For intcont := 0 To FQuebras.Count -1 Do
    FQuebras.Quebras[intcont].Totais.Campo[Descricao] := 0;
end;

procedure TGeraExcel.pIniciaGeracao;
  Var
    intCont: Integer;
begin

  With FExcel, FDados Do
  Begin

    DefinirFonte(CourierNew, 10);

    For intcont := 0 To FQuebras.Count -1 Do
      FQuebras.Quebras[intCont].Totais.Zerar;

    If FExcel.blnAbrirArquivoExistente Then
      LinhaAtual := MaximodeLinhas + 1
    Else
    Begin
      LinhaAtual := 1;
      PintarTudo(Branco);
    End;

    FLinhaInicial := LinhaAtual;
    FQtdCol       := FCampos.Colunas.Count;
    FUltCol       := fGetLetraAlfa(FQtdCol);

    If Assigned(FProgres) Then
    Begin
      FProgres.Position := 0;
      FProgres.Visible  := False; // Agora Exibe o untGravando, depois tirar o progresso do create e dos relatorios.
      FProgres.Max      := RecordCount;
    End;

    If Assigned(FcxProgres) Then
    Begin
      FcxProgres.Position       := 0;
      FcxProgres.Visible        := True;
      FcxProgres.Properties.Max := RecordCount;
    End;

  End;

End;

procedure TGeraExcel.pMontaTituloColunas;
  Var
    intCont: Integer;
begin
  With FExcel, FDados Do
  Begin
    If Assigned(pImpTitColuna) And (Not FImpTitColFim) Then
       pImpTitColuna(FExcel, FCampos);

    ProximaLinha;

    For intCont := 1 To FQtdCol Do
    Begin
      Escrever(LinhaAtual, intCont, FCampos.ColunaPorIndice[intCont].Descricao);
      Negrito (LinhaAtual, intCont, True);

      If FCampos.ColunaPorIndice[intCont].Tipo = ftFloat Then
        Alinhamento(LinhaAtual,intCont, Direita)
      Else
        Alinhamento(LinhaAtual,intCont, Esquerda);
    End;

    CorFundo('A' + IntToStr(LinhaAtual), FUltCol + IntToStr(LinhaAtual), Preto);
    CorFonte('A' + IntToStr(LinhaAtual), FUltCol + IntToStr(LinhaAtual), Branco);
    If FDefinirBordas Then
      Bordas('A' + IntToStr(LinhaAtual), FUltCol + IntToStr(LinhaAtual));

    If Assigned(pImpTitColuna) And FImpTitColFim Then
      pImpTitColuna(FExcel, FCampos);
  End;
end;


procedure TGeraExcel.pMontaTitulos;
  Var
    intCont: Integer;
    LinhaFinalTitulo : Integer;
begin
  With FExcel, FDados Do
  Begin
    LinhaFinalTitulo := FLinhaInicial;


    if FImpEmp Then
      Inc(LinhaFinalTitulo);

    If Not fEmptyStr(FNomRel) Then
      Inc(LinhaFinalTitulo);

    LinhaFinalTitulo := LinhaFinalTitulo + Length(FFiltros);

    For intCont := FLinhaInicial To LinhaFinalTitulo Do
    Begin
      Mesclar    ('A' + IntToStr(intCont), FUltCol + IntToStr(intCont));
      Negrito    ('A' + IntToStr(intCont), FUltCol + IntToStr(intCont), True);

      If FAlinhaEsquerdaTitulo Then
        Alinhamento('A' + IntToStr(intCont), FUltCol + IntToStr(intCont), Esquerda)
      Else
        Alinhamento('A' + IntToStr(intCont), FUltCol + IntToStr(intCont), Centro);
    End;

    If FImpEmp Then
      Escrever(ProximaLinha,01, fRetNomeEmpresa);

    If Not fEmptyStr(FNomRel) Then
    Begin
      Escrever(ProximaLinha,01, FNomRel);
      If FFonteNomRel <> - 1 Then
        DefinirFonte('A' + IntToStr(LinhaAtual), FUltCol + IntToStr(LinhaAtual), Arial, FFonteNomRel);
    End;

    If (LinhaAtual > FLinhaInicial) Then
    Begin
      CorFundo('A' + IntToStr(FLinhaInicial + 1), FUltCol + IntToStr(LinhaAtual), Amarelo);

      If FDefinirBordas Then
        Bordas('A' + IntToStr(FLinhaInicial + 1), FUltCol + IntToStr(LinhaAtual), True,True,True,True);

    End;

    For intCont := 0 To Length(FFiltros) -1 Do
      Escrever(ProximaLinha,01, FFiltros[intCont]);

    With FDados Do
    Begin
//      For intCont := FLinhaInicial To LinhaAtual Do
//      Begin
//        Mesclar    ('A' + IntToStr(intCont), FUltCol + IntToStr(intCont));
//        Negrito    ('A' + IntToStr(intCont), FUltCol + IntToStr(intCont), True);
//        Alinhamento('A' + IntToStr(intCont), FUltCol + IntToStr(intCont), Centro);
//      End;      

      If Assigned(pImpFiltros) Then
        pImpFiltros(FExcel, FDados, FCampos, FFiltros);

      pMontaTituloColunas;

      If FCongelarPaineis Then
        CongelarPaines('A' + IntToStr(FExcel.LinhaAtual + 1));
    End;

  End;

end;

procedure TGeraExcel.pTituloGrupo;
  Var
    intQuebras: Integer;
begin

  With FDados Do
  Begin
    For intQuebras := 0 To FQuebras.Count -1 Do
    Begin
      If FQuebras.Quebras[intQuebras].NomeCampo <> '[GERAL]' Then
      Begin
        If FQuebras.Quebras[intQuebras].ValorAtual <> FieldByName(FQuebras.Quebras[intQuebras].NomeCampo).AsString Then
        Begin
          FQuebras.Quebras[intQuebras].ValorAtual := FieldByName(FQuebras.Quebras[intQuebras].NomeCampo).AsString;
          If FQuebras.Quebras[intQuebras].CampoDescricao <> '' Then
            FQuebras.Quebras[intQuebras].ValorAtualDescricao := FieldByName(FQuebras.Quebras[intQuebras].CampoDescricao).AsString;
          If FQuebras.Quebras[intQuebras].ImprTitulo Then
            pMontaTituloGrupo(fPadL(' ', intQuebras * 2) + FQuebras.Quebras[intQuebras].Titulo + FieldByName(IfThen(FQuebras.Quebras[intQuebras].CampoDescricao <> '',FQuebras.Quebras[intQuebras].CampoDescricao,  FQuebras.Quebras[intQuebras].NomeCampo)).AsString);

          If Assigned(pImpTitGru) Then
            pImpTitGru(FExcel, FDados, FCampos, FQuebras.Quebras[intQuebras]);
        End;
      End;
    End;
  End;

end;

procedure TGeraExcel.TrocaRefCampo(NomeOriginal, NovoNome,
  NovaDescricao: String);
begin
  FCampos.TrocaRefer(NomeOriginal, NovoNome, NovaDescricao);
end;

procedure TGeraExcel.pImprimeDetalhes;
  Var
    intCont: Integer;
    Cor: TCorExcel;
begin

  With FExcel Do
  Begin
    For intCont := 1 To FQtdCol Do
    Begin

      If FCampos.ColunaPorIndice[intCont].Tipo = ftFloat Then
      Begin
        If Assigned(FCampos.ColunaPorIndice[intCont].FuncaoCampo) Then
          Escrever(LinhaAtual, intCont, FCampos.ColunaPorIndice[intCont].FuncaoCampo(FDados))

        Else If Assigned(FCampos.ColunaPorIndice[intCont].FuncaoCampoSemPar) Then
          Escrever(LinhaAtual, intCont, FCampos.ColunaPorIndice[intCont].FuncaoCampoSemPar)

        Else
          Escrever(LinhaAtual, intCont, FCampos.ColunaPorIndice[intCont].DataSet.FieldByName(FCampos.ColunaPorIndice[intCont].NomeCampo).AsFloat);
      End

      Else If Assigned(FCampos.ColunaPorIndice[intCont].FuncaoCampoString) Then
      Begin
        Escrever(LinhaAtual, intCont, FCampos.ColunaPorIndice[intCont].FuncaoCampoString(FDados));
      End

      Else If Assigned(FCampos.ColunaPorIndice[intCont].FuncaoCampoStringSemPar) Then
      Begin
        Escrever(LinhaAtual, intCont, FCampos.ColunaPorIndice[intCont].FuncaoCampoStringSemPar);
      End

      Else
      Begin
        If (FCampos.ColunaPorIndice[intCont].Precisao = 11) Then
        Begin
          Escrever(LinhaAtual, intCont, fFormataFone(FCampos.ColunaPorIndice[intCont].DataSet.FieldByName(FCampos.ColunaPorIndice[intCont].NomeCampo).AsString));
        End
        Else
        Begin
          Escrever(LinhaAtual, intCont, FCampos.ColunaPorIndice[intCont].DataSet.FieldByName(FCampos.ColunaPorIndice[intCont].NomeCampo).AsString);
        End;
      End;

    End;

    If FDefinirBordas Then
      Bordas('A' + IntToStr(LinhaAtual), FUltCol + IntToStr(LinhaAtual));

    If (FDados.RecNo Mod 2 = 0) Then
      Cor := Cinza
    Else
      Cor := Branco;

    CorFundo('A' + IntToStr(LinhaAtual), FUltCol + IntToStr(LinhaAtual), Cor);

    If Assigned(pImpDet) Then
      pImpDet(FExcel, FDados, FCampos, Cor);
  End;

end;

procedure TGeraExcel.pImprimeMsgRodape;
begin
  If (Not fEmptyStr(strMsgRod)) Then
  Begin
    With objExcel Do
    Begin
      Escrever(ProximaLinha, 1, strMsgRod);
    End;
  End;
end;

procedure TGeraExcel.pResumoGrupo;
  Var
    intQuebras: Integer;
    intSubQueb: Integer;
begin

  With FDados Do
  Begin

    For intQuebras := FQuebras.Count -1 Downto 0 Do
    Begin

      {*************************************************************}
      {* VERIFICA SE DEVE IMPRIMIR O TOTAL GERAL                   *}
      {**********************************************************JC*}
      If (FQuebras.Quebras[intQuebras].NomeCampo = '[GERAL]') Then
      Begin
         If Assigned(pResumo) And Eof Then
          pResumo(FExcel, FCampos, FQuebras.Quebras[intQuebras]);
      End

      {*************************************************************}
      {* CASO TROCOU O VALOR DO GRUPO OU TENHA CHEGADO AO FIM      *}
      {* GERA O RESUMO PARA O GRUPO E SEUS SUB-GRUPOS              *}
      {**********************************************************JC*}
      Else If Eof Or (FQuebras.Quebras[intQuebras].ValorAtual <> FieldByName(FQuebras.Quebras[intQuebras].NomeCampo).AsString) Then
      Begin
        For intSubQueb := FQuebras.Count -1 Downto intQuebras Do
        Begin
          {****************************************}
          {* CASO AINDA NAO TENHA GERADO O RESUMO *}
          {*************************************JC*}
          If FQuebras.Quebras[intSubQueb].ValorAtual <> '<<<< QUEBROU >>>>' Then
          Begin
            If Assigned(pResumo) Then
              pResumo(FExcel, FCampos, FQuebras.Quebras[intSubQueb]);

            FQuebras.Quebras[intSubQueb].ValorAtual := '<<<< QUEBROU >>>>'; //PARA IMPRIMIR NOVAMENTE O TITULO e VERIFICAR SE JA GEROU O RESUMO
            FQuebras.Quebras[intSubQueb].Totais.Zerar; //ZERA OS TOTAIS
          End;
        End;
      End;

    End;

  End;

End;

procedure TGeraExcel.pFinalizaGeracao;
begin

  With FExcel Do
  Begin
    OrientacaoPagina(Retrato);

    AutoAjuste;

    If Assigned(pFimGeracao) Then
      pFimGeracao(FExcel, FCampos);

    SalvarArquivo;
    FecharArquivo;

    If Assigned(FProgres) Then
      FProgres.Visible := False;

  End;

end;

class function TGeraExcel.fGerarRelatorio(dbgDados: TDBGridCitel; strTitulo : String): Boolean;
  Var
    objGeraExcel : TGeraExcel;
    intIndex     : Integer;
begin
  if (not Assigned(dbgDados.DataSource)) Or
     (not Assigned(dbgDados.DataSource.DataSet)) Or
     (Not dbgDados.DataSource.DataSet.Active) Or
     (dbgDados.DataSource.DataSet.IsEmpty) Then
  Begin
    fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);
    Result := False;
    Exit;
  End;

  Try
    dbgDados.DataSource.DataSet.DisableControls;
    Try
      objGeraExcel := TGeraExcel.Create(dbgDados.DataSource.DataSet, nil);

      With objGeraExcel Do
      Begin
        strNomRel := strTitulo;

        For intIndex := 0 To dbgDados.Columns.Count -1 Do
        Begin
          If dbgDados.Columns[intIndex].Visible Then
          Begin
            AddCampo(dbgDados.Columns[intIndex].FieldName, dbgDados.Columns[intIndex].Title.Caption);
          End;
        End;

        Result := fGerarRelatorio;

      End;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(e.Message, 'TGeraExcel.fGerarRelatorio');
      End;
    End;
  Finally
    dbgDados.DataSource.DataSet.First;
    dbgDados.DataSource.DataSet.EnableControls;
    FreeAndNil(objGeraExcel);
  End;

end;

procedure TGeraExcel.pFormataDetalhes(intLinIni, intLinFin : Integer);
  Var
    intCont: Integer;
    strCelulaIni: String;
    strCelulaFin: String;
begin
  For intCont := 1 To FQtdCol Do
  Begin

    strCelulaIni := fColunaComoLetra(intCont) + IntToStr(intLinIni);
    strCelulaFin := fColunaComoLetra(intCont) + IntToStr(intLinFin);

    If FCampos.ColunaPorIndice[intCont].Tipo = ftFloat Then
    Begin

      If FCampos.ColunaPorIndice[intCont].Precisao > 0 Then
        FExcel.FormatoNumerico(strCelulaIni, strCelulaFin, '#.##0,' + fReplicatorStr('0', FCampos.ColunaPorIndice[intCont].Precisao))
      Else
        FExcel.FormatoNumerico(strCelulaIni, strCelulaFin, '#.##0,' + '#.##0');

      FExcel.Alinhamento(strCelulaIni, strCelulaFin, Direita);
    End

    Else If Assigned(FCampos.ColunaPorIndice[intCont].FuncaoCampoString) Then
    Begin
      FExcel.FormatoNumerico(strCelulaIni, strCelulaFin, '@');
      FExcel.Alinhamento(strCelulaIni, strCelulaFin, Esquerda);
    End

    Else If Assigned(FCampos.ColunaPorIndice[intCont].FuncaoCampoStringSemPar) Then
    Begin
      FExcel.FormatoNumerico(strCelulaIni, strCelulaFin, '@');
      FExcel.Alinhamento(strCelulaIni, strCelulaFin, Esquerda);
    End

    Else
    Begin
      If (FCampos.ColunaPorIndice[intCont].Precisao = 11) Then
      Begin
        FExcel.FormatoNumerico(strCelulaIni, strCelulaFin, '@');
        FExcel.Alinhamento(strCelulaIni, strCelulaFin, Esquerda);
      End
      Else
      Begin
        If (FCampos.ColunaPorIndice[intCont].Tipo In [ftDate, ftDateTime]) Then
          FExcel.FormatoNumerico(strCelulaIni, strCelulaFin, 'dd/mm/aaaa')

        ELse If FCampos.ColunaPorIndice[intCont].Tipo <> ftMemo Then
          FExcel.FormatoNumerico(strCelulaIni, strCelulaFin, '@');

        FExcel.Alinhamento(strCelulaIni, strCelulaFin, Esquerda);
      End;
    End;

  End;
end;

function TGeraExcel.fNovaQuebra: Boolean;
  Var
    intAux: Integer;
begin
  Result := False;
  For intAux := 0 To FQuebras.Count -1 Do
  Begin
    If FQuebras.Quebras[intAux].NomeCampo = '[GERAL]' Then
      Continue;

    If FQuebras.Quebras[intAux].ValorAtual <> FDados.FieldByName(FQuebras.Quebras[intAux].NomeCampo).AsString Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

class function TGeraExcel.fUserDesktop(): String;
var
  Registro: TRegistry;
begin
  Registro := TRegistry.Create;
  try
    Registro.RootKey := HKEY_CURRENT_USER;
    Registro.OpenKey('Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders\', True);
    Result := Registro.ReadString('Desktop');
  finally
    Registro.CloseKey;
    Registro.Free;
  end;
end;

function TGeraExcel.fGerarRelatorioInterna(cxProgress: TcxProgressBar): Boolean;
  Var
    intLinIni : Integer;
begin
  FcxProgres := cxProgress;
  Result := False;

  FExcel.blnTestaArq := FTestaArq;

  If FInitialDirDeskTop Then
    FExcel.strInitialDir := fUserDesktop();

  If FExcel.CriarArquivo(FNomArq, FExcel.strInitialDir) Then
  begin

    With FExcel, FDados Do
    Begin

      pIniciaGeracao;

      pMontaTitulos;

      First;

      While (Not Eof) Do
      Begin

        pTituloGrupo;
        intLinIni := LinhaAtual + 1;

        While (Not fNovaQuebra) And (Not Eof) Do
        Begin
          ProximaLinha;
          pImprimeDetalhes;
          pNext;
        End;

        pFormataDetalhes(intLinIni,LinhaAtual);
        pResumoGrupo;

      End;

      pImprimeMsgRodape;
      pFinalizaGeracao;

      Result := True;

    End;

  End;

  If FExcel.blnErroArq Then
   pMensagemOK('Não é possível gerar o arquivo, verifique se o mesmo está sendo utilizado!');
end;

{***********************************************************}
{* FUNCIONA SOMENTE DE A ATÉ ZZ. EX: A, D, AA, AB, DE, ETC *}
{********************************************************MV*}
function TGeraExcel.fColunaComoLetra(intColuna: Integer): String;
  Var
    intPrimeiraLetra: Integer;
    intSegundaLetra: Integer;
begin
  if intColuna < 1 Then
  Begin
    Raise Exception.Create('Coluna inválida(' + IntToStr(intColuna) + '): verifique. ');
  End;

  If intColuna <= 26 Then
  Begin
    Result := Chr(64+intColuna);
  End
  Else
  Begin
    intPrimeiraLetra := intColuna Div 26;
    intSegundaLetra := intColuna Mod 26;

    If intSegundaLetra = 0 Then
    Begin
      Dec(intPrimeiraLetra);
      intSegundaLetra := 26;
    End;

    intSegundaLetra := 64+intSegundaLetra;
    Result := Chr(intSegundaLetra);
    If intPrimeiraLetra > 0 Then
    Begin
      Result := Chr(64+intPrimeiraLetra) + Result;
    End;
  End;
end;

function TGeraExcel.fGerarRelatorio(blnDirDeskTop: Boolean = False): Boolean;
  var
    LfrmGravando : TfrmGravando;
begin
  Try
    Try
      FInitialDirDeskTop := blnDirDeskTop;

      pCriarFormularios(TfrmGravando, LfrmGravando);
      LfrmGravando.lblGravando.Caption := 'Gerando Arquivo...';
      LfrmGravando.fExecutarAcao := fGerarRelatorioInterna;
      LfrmGravando.ShowModal;
      Result := LfrmGravando.blnConfirma;
    Finally
      FreeAndNil(LfrmGravando);
    End;
  Except
    On E : Exception Do
    Begin
      Result := False;

      If (Pos('Não é possível gerar o arquivo', E.Message) > 0) Or
         (Pos('Falha na execução do servidor', E.Message) > 0) Or
         (Pos('Given module is not a frame nor a window', E.Message) > 0) Then
        pMensagemOk('Não foi possível concluir a geração do arquivo, verifique.')
      Else
        pMensagensErro(E.Message, 'TGeraExcel.fGerarRelatorio');
    End;
  End;

end;

class function TGeraExcel.fGerarRelatorio(cxvDados: TcxGridDBTableView; strTitulo: String): Boolean;
  Var
    objGeraExcel : TGeraExcel;
    intCnt : Integer;
    DataSet : TDataSet;
begin
  If (Not Assigned(cxvDados.DataController.DataSource)) Or
     (Not Assigned(cxvDados.DataController.DataSource.DataSet)) Or
     (Not cxvDados.DataController.DataSource.DataSet.Active) Or
     (cxvDados.DataController.DataSource.DataSet.IsEmpty) Then
  Begin
    fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);
    Result := False;
    Exit;
  End;

  DataSet := cxvDados.DataController.DataSource.DataSet;

  Try
    DataSet.DisableControls;
    Try
      objGeraExcel := TGeraExcel.Create(DataSet, Nil);

      With objGeraExcel Do
      Begin

        strNomRel := strTitulo;

        For intCnt := 0 To cxvDados.ColumnCount-1 Do
        Begin
          If cxvDados.Columns[intCnt].Visible Then
          Begin
            AddCampo(cxvDados.Columns[intCnt].DataBinding.FieldName, cxvDados.Columns[intCnt].Caption);
          End;
        End;

        For intCnt := 0 To cxvDados.GroupedColumnCount-1 Do
        Begin
          If (cxvDados.GroupedColumns[intCnt] Is TcxGridDbColumn) Then
          Begin
            AddQuebra((cxvDados.GroupedColumns[intCnt] As TcxGridDbColumn).DataBinding.FieldName, cxvDados.GroupedColumns[intCnt].Caption + ': ');
          End;
        End;

        Result := fGerarRelatorio;
      End;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TGeraExcel.fGerarRelatorio');
      End;
    End;
  Finally
    DataSet.First;
    DataSet.EnableControls;
    FreeAndNil(objGeraExcel);
  End;
end;

class function TGeraExcel.fGerarRelatorio(cxgDados: TcxGridDBTableView;
  strTitulo: String; Detalhes: TImpDetalhes): Boolean;
  Var
    objGeraExcel : TGeraExcel;
    intCnt : Integer;
    DataSet : TDataSet;
begin
  If (Not Assigned(cxgDados.DataController.DataSource)) Or
     (Not Assigned(cxgDados.DataController.DataSource.DataSet)) Or
     (Not cxgDados.DataController.DataSource.DataSet.Active) Or
     (cxgDados.DataController.DataSource.DataSet.IsEmpty) Then
  Begin
    fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);
    Result := False;
    Exit;
  End;

  DataSet := cxgDados.DataController.DataSource.DataSet;

  Try
    DataSet.DisableControls;
    Try
      objGeraExcel := TGeraExcel.Create(DataSet, Nil);

      With objGeraExcel Do
      Begin
        If Assigned(Detalhes) Then
          OnImpDetalhes := Detalhes;

        strNomRel := strTitulo;

        For intCnt := 0 To cxgDados.ColumnCount-1 Do
        Begin
          If cxgDados.Columns[intCnt].Visible Then
          Begin
            AddCampo(cxgDados.Columns[intCnt].DataBinding.FieldName, cxgDados.Columns[intCnt].Caption);
          End;
        End;

        For intCnt := 0 To cxgDados.GroupedColumnCount-1 Do
        Begin
          If (cxgDados.GroupedColumns[intCnt] Is TcxGridDbColumn) Then
          Begin
            AddQuebra((cxgDados.GroupedColumns[intCnt] As TcxGridDbColumn).DataBinding.FieldName, cxgDados.GroupedColumns[intCnt].Caption + ': ');
          End;
        End;

        Result := fGerarRelatorio;
      End;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TGeraExcel.fGerarRelatorio');
      End;
    End;
  Finally
    DataSet.First;
    DataSet.EnableControls;
    FreeAndNil(objGeraExcel);
  End;
end;

Procedure TGeraExcel.pSetaFiltrosExcel(arrFiltros: TArrRecFiltros);
  Var
    intContador: Integer;
Begin
  For intContador := Low(arrFiltros) To High(arrFiltros) Do
    With arrFiltros[intContador] Do
     If blnTitulo Then
       strNomRel := strNomFil
     Else
       AddFiltro(strNomFil);
End;

end.
