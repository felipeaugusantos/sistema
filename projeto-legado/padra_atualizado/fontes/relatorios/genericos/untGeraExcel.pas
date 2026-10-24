unit untGeraExcel;

interface

uses Classes, untExcel, DB, ComCtrls, Forms, MaskUtils, Variants, untTypesSistema;

Type
  TFuncaoDoubleCol          = Function(dtsDados: TDataSet;strCampo:String): Double Of Object;
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
    Porcentagem: Boolean;
    Alinhamento: TAlinhamentoExcel;
    FuncaoCampoCol         : TFuncaoDoubleCol;
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
      FExcel  : TExcel;
      FCampos : TCampos;
      FQuebras: TQuebras;
      FDados  : TDataSet;
      FProgres: TProgressBar;
      FQtdCol : Integer;
      FUltCol : String;
      FFiltros: Array Of String;
      FNomRel : String;
      FCongelarPaineis: Boolean;
      FDefinirBordas: Boolean;
      FLinhaInicial: Integer;
      FImpTitColuna: Boolean;
      FImpDetalhes: Boolean;
      FCriaObjExcel: Boolean;
      FImpZebrado: Boolean;
      FPulaLinha: Boolean;
      FImpTitColFim: Boolean;
      FIncQtdCol: Integer;

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

      FArqAbe: Boolean;

      procedure pIniciaGeracao;
      procedure pMontaTitulos;
      procedure pTituloGrupo;
      procedure pImprimeDetalhes;
      procedure pResumoGrupo;
      procedure pImprimeMsgRodape;
      procedure pFinalizaGeracao;

      procedure pMontaTituloColunas;
      procedure pMontaTituloGrupo(Titulo: String);
      procedure pNext;

      function fNovaQuebra: Boolean;
      procedure pFormataDetalhes(intLinIni, intLinFin : Integer);
      function fColunaComoLetra(intColuna: Integer): String;
      //unction fArquivoAberto(strNomArq: String): Boolean;

    protected

    public

      constructor Create(Dados: TDataSet; Progresso: TProgressBar; blnCriaObjExcel: Boolean = True);
      Destructor Destroy; Override;

      function fGerarRelatorio: Boolean;

      Procedure pSetaFiltrosExcel(arrFiltros: TArrRecFiltros);

      procedure AddCampo (Nome, Descricao: String; Precisao: Integer = 2; Porcentagem: Boolean = False); Overload;
      procedure AddCampo (Funcao: TFuncaoDouble; Nome, Descricao: String; Precisao: Integer = 2; Porcentagem: Boolean = False); Overload;
      procedure AddCampo (Funcao: TFuncaoString; Nome, Descricao: String); Overload;
      procedure AddCampo (ForcaAlinhamento: TAlinhamentoExcel; Nome, Descricao: String); Overload;
      procedure AddCampo (Funcao: TFuncaoDoubleCol; Nome, Descricao: String; Precisao: Integer = 2; Porcentagem: Boolean = False); Overload;
      procedure AddCampo (Funcao: TFuncaoDoubleSemParametro; Nome, Descricao: String; Precisao: Integer = 2; Porcentagem: Boolean = False); Overload;
      procedure AddCampo (Funcao: TFuncaoStringSemParametro; Nome, Descricao: String); Overload;
      procedure TrocaRefCampo(NomeOriginal, NovoNome, NovaDescricao:String);

      procedure AddQuebra(Nome, Descricao: String; ImprTitulo: Boolean = True; CampoDescricao: String = '');
      procedure DelQuebra(Nome: String);
      procedure AddFiltro(Descricao: String);
      procedure AddTotais(Descricao: String);

    published

      property blnImpEmp: Boolean read FImpEmp write FImpEmp;
      property strNomArq: String  read FNomArq write FNomArq;

      property strNomRel: String read FNomRel write FNomRel;
      property strMsgRod: String read FMsgRod write FMsgRod;
      property objExcel: TExcel  read FExcel  write FExcel;
      property intQtdCol: Integer read FQtdCol write FQtdCol;

      property blnCongelarPaineis: Boolean       Read FCongelarPaineis Write FCongelarPaineis;
      property blnDefinirBordas: Boolean         Read FDefinirBordas Write FDefinirBordas;
      property blnImprimirTituloColunas: Boolean Read FImpTitColuna Write FImpTitColuna;
      property blnImprimirDetalhes: Boolean      Read FImpDetalhes Write FImpDetalhes;
      property blnImpZebrado: Boolean            Read FImpZebrado Write FImpZebrado;
      property blnPulaLinha: Boolean             Read FPulaLinha Write FPulaLinha;
      property blnImpTitColFim: Boolean          Read FImpTitColFim Write FImpTitColFim;
      property intIncQtdCol: Integer             Read  FIncQtdCol Write FIncQtdCol;

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

uses SysUtils, untFuncoesFactory, untIFuncoes, Math, untClassPanelCx, StrUtils;

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

constructor TGeraExcel.Create(Dados: TDataSet; Progresso: TProgressBar;
  blnCriaObjExcel: Boolean = True);
begin
  inherited Create;

  FDados   := Dados;
  FProgres := Progresso;
  FCriaObjExcel := blnCriaObjExcel;

  If blnCriaObjExcel Then
    FExcel   := TExcel.fCriarExcel(Nil); //TExcel.Create;

  FNomRel  := '';
  FNomArq  := '';

  FImpEmp  := True;
  FCongelarPaineis := True;
  FDefinirBordas := True;
  FImpTitColuna := True;
  FImpDetalhes := True;
  FImpZebrado := True;
  FPulaLinha := True;
  FImpTitColFim := True;
  FIncQtdCol := 0;
  FArqAbe := False;

  FCampos  := TCampos.Create;
  FQuebras := TQuebras.Create;
  FQtdCol  := 0;

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

  If (FCriaObjExcel) And Assigned(FExcel) Then
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

  Application.ProcessMessages;
end;

procedure TGeraExcel.AddCampo(Funcao: TFuncaoDouble; Nome, Descricao: String; Precisao: Integer = 2; Porcentagem: Boolean = False);
  Var
    recCampo: TRecCampos;
begin
  recCampo.NomeCampo               := Nome;
  recCampo.FuncaoCampo             := Funcao;
  recCampo.FuncaoCampoSemPar       := Nil;
  recCampo.FuncaoCampoString       := Nil;
  recCampo.FuncaoCampoStringSemPar := Nil;
  recCampo.Descricao               := Descricao;
  recCampo.Precisao                := Precisao;
  reccampo.Porcentagem             := Porcentagem;
  recCampo.Tipo                    := ftFloat;
  recCampo.FuncaoCampoCol          := Nil;

  FCampos[Nome] := recCampo;
end;

procedure TGeraExcel.AddCampo(ForcaAlinhamento: TAlinhamentoExcel; Nome, Descricao: String);
  Var
    recCampo: TRecCampos;
begin
  recCampo.NomeCampo               := Nome;
  recCampo.FuncaoCampo             := Nil;
  recCampo.FuncaoCampoString       := Nil;
  recCampo.FuncaoCampoSemPar       := Nil;
  recCampo.FuncaoCampoStringSemPar := Nil;
  recCampo.Descricao               := Descricao;
  recCampo.Porcentagem             := False;

  // PREENCHER COM PRECISÃO = 11 QUANDO FOR FONE, PARA FORMATAR
  recCampo.Precisao                := 2;
  recCampo.Tipo                    := FDados.FieldByName(Nome).DataType;
  recCampo.Alinhamento             := ForcaAlinhamento;
  recCampo.FuncaoCampoCol          := Nil;

  FCampos[Nome] := recCampo;
end;

procedure TGeraExcel.AddCampo(Funcao: TFuncaoDoubleSemParametro; Nome, Descricao: String; Precisao: Integer = 2; Porcentagem: Boolean = False);
  Var
    recCampo: TRecCampos;
begin
  recCampo.NomeCampo               := Nome;
  recCampo.FuncaoCampo             := Nil;
  recCampo.FuncaoCampoSemPar       := Funcao;
  recCampo.FuncaoCampoString       := Nil;
  recCampo.FuncaoCampoStringSemPar := Nil;
  recCampo.Descricao               := Descricao;
  recCampo.Precisao                := Precisao;
  reccampo.Porcentagem             := Porcentagem;
  recCampo.Tipo                    := ftFloat;
  recCampo.FuncaoCampoCol          := Nil;

  FCampos[Nome] := recCampo;
end;

procedure TGeraExcel.AddCampo(Funcao: TFuncaoDoubleCol; Nome, Descricao: String; Precisao: Integer = 2; Porcentagem: Boolean = False);
  Var
    recCampo: TRecCampos;
begin
  recCampo.NomeCampo               := Nome;
  recCampo.FuncaoCampo             := Nil;
  recCampo.FuncaoCampoCol          := Funcao;
  recCampo.FuncaoCampoSemPar       := Nil;
  recCampo.FuncaoCampoString       := Nil;
  recCampo.FuncaoCampoStringSemPar := Nil;
  recCampo.Descricao               := Descricao;
  recCampo.Precisao                := Precisao;
  reccampo.Porcentagem             := Porcentagem;
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
  recCampo.Descricao               := Descricao;
  recCampo.Precisao                := 0;
  reccampo.Porcentagem             := False;
  recCampo.Tipo                    := ftString;
  recCampo.FuncaoCampoCol          := Nil;

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
  recCampo.Descricao               := Descricao;
  recCampo.Precisao                := 0;
  reccampo.Porcentagem             := False;
  recCampo.Tipo                    := ftString;
  recCampo.FuncaoCampoCol          := Nil;

  FCampos[Nome] := recCampo;
end;

procedure TGeraExcel.AddCampo(Nome, Descricao: String; Precisao: Integer = 2; Porcentagem: Boolean = False);
  Var
    recCampo: TRecCampos;
begin
  recCampo.NomeCampo               := Nome;
  recCampo.FuncaoCampo             := Nil;
  recCampo.FuncaoCampoString       := Nil;
  recCampo.FuncaoCampoSemPar       := Nil;
  recCampo.FuncaoCampoStringSemPar := Nil;
  recCampo.Descricao               := Descricao;

  // PREENCHER COM PRECISÃO = 11 QUANDO FOR FONE, PARA FORMATAR
  recCampo.Precisao                := Precisao;
  reccampo.Porcentagem             := Porcentagem;

  recCampo.Tipo                    := FDados.FieldByName(Nome).DataType;
  recCampo.FuncaoCampoCol          := Nil;

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

    If FExcel.blnAbrirArquivoExistente Or (Not FCriaObjExcel) Then
      LinhaAtual := MaximodeLinhas + IfThen(blnPulaLinha, 1, 0)
    Else
    Begin
      LinhaAtual := 1;
      PintarTudo(Branco);
    End;

    FLinhaInicial := LinhaAtual;

    If FQtdCol = 0 Then
      FQtdCol := FCampos.Colunas.Count + FIncQtdCol;

    FUltCol   := fGetLetraAlfa(FQtdCol);

    FExcel.arrDados := VarArrayCreate([1, FQtdCol], varVariant);

    If Assigned(FProgres) Then
    Begin
      FProgres.Position := 0;
      FProgres.Visible  := True;
      FProgres.Max      := RecordCount;
    End;

  End;

End;

procedure TGeraExcel.pMontaTituloColunas;
  Var
    intCont: Integer;
begin
  With FExcel, FDados Do
  Begin
    If FImpTitColuna Then
    Begin
      If Assigned(pImpTitColuna) And (Not FImpTitColFim) Then
         pImpTitColuna(FExcel, FCampos);

      If FCriaObjExcel Then
        ProximaLinha;

      For intCont := 1 To (FQtdCol-FIncQtdCol) Do
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
    End;

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
    If FCriaObjExcel Then
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
        Alinhamento('A' + IntToStr(intCont), FUltCol + IntToStr(intCont), Centro);
      End;

      If FImpEmp Then
        Escrever(ProximaLinha,01, fRetNomeEmpresa);

      If Not fEmptyStr(FNomRel) Then
        Escrever(ProximaLinha,01, FNomRel);

      If (LinhaAtual > FLinhaInicial) Then
      Begin
        CorFundo('A' + IntToStr(FLinhaInicial + 1), FUltCol + IntToStr(LinhaAtual), Amarelo);

        If FDefinirBordas Then
          Bordas('A' + IntToStr(FLinhaInicial + 1), FUltCol + IntToStr(LinhaAtual), True,True,True,True);

      End;

      For intCont := 0 To Length(FFiltros) -1 Do
        Escrever(ProximaLinha,01, FFiltros[intCont]);
    End;

    With FDados Do
    Begin
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

  With FExcel, FDados Do
  Begin
    Cor := Branco;

    If FImpDetalhes Then
    Begin
      blnEscreverArray := True;

      For intCont := 1 To (FQtdCol-FIncQtdCol) Do
      Begin

        If FCampos.ColunaPorIndice[intCont].Tipo = ftFloat Then
        Begin
          If Assigned(FCampos.ColunaPorIndice[intCont].FuncaoCampo) Then
            Escrever(LinhaAtual, intCont, FCampos.ColunaPorIndice[intCont].FuncaoCampo(FDados))

          Else If Assigned(FCampos.ColunaPorIndice[intCont].FuncaoCampoSemPar) Then
            Escrever(LinhaAtual, intCont, FCampos.ColunaPorIndice[intCont].FuncaoCampoSemPar, True)
          Else If Assigned(FCampos.ColunaPorIndice[intCont].FuncaoCampoCol) Then
            Escrever(LinhaAtual, intCont, FCampos.ColunaPorIndice[intCont].FuncaoCampoCol(FDados,FCampos.ColunaPorIndice[intCont].NomeCampo), True)
          Else If FCampos.ColunaPorIndice[intCont].Precisao > 0 Then
            Escrever(LinhaAtual, intCont, RoundTo(FieldByName(FCampos.ColunaPorIndice[intCont].NomeCampo).AsFloat, FCampos.ColunaPorIndice[intCont].Precisao * -1), True)
          Else
            Escrever(LinhaAtual, intCont, FieldByName(FCampos.ColunaPorIndice[intCont].NomeCampo).AsFloat, True);
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
            Escrever(LinhaAtual, intCont, fFormataFone(FieldByName(FCampos.ColunaPorIndice[intCont].NomeCampo).AsString));
          End
          Else
          Begin
            Escrever(LinhaAtual, intCont, FieldByName(FCampos.ColunaPorIndice[intCont].NomeCampo).AsString);
          End;
        End;

      End;

      FExcel.EscreveVarios('A' + IntToStr(LinhaAtual), FUltCol + IntToStr(LinhaAtual));
      FExcel.blnEscreverArray := False;

      If FDefinirBordas Then
        Bordas('A' + IntToStr(LinhaAtual), FUltCol + IntToStr(LinhaAtual));

      If (RecNo Mod 2 = 0) Then
        Cor := Cinza
      Else
        Cor := Branco;

      If Cor <> Branco Then
      Begin
        CorFundo('A' + IntToStr(LinhaAtual), FUltCol + IntToStr(LinhaAtual), Cor);
      End;
    End;

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
    If FCriaObjExcel Then
    Begin
      OrientacaoPagina(Retrato);

      AutoAjuste;

      If Assigned(pFimGeracao) Then
        pFimGeracao(FExcel, FCampos);

      SalvarArquivo;
      FecharArquivo;

      {FArqAbe := fArquivoAberto(NomeArquivo);
      If Not FArqAbe Then
      Begin
        SalvarArquivo;
        FecharArquivo;
      End;}
      
      If Assigned(FProgres) Then
        FProgres.Visible := False;
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

function TGeraExcel.fGerarRelatorio: Boolean;
  Var
    intLinIni : Integer;
begin

  Result := False;

  If (Not FCriaObjExcel) Or FExcel.CriarArquivo(FNomArq) Then
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

      If Not FArqAbe Then
        Result := True;
    End;

  End;

end;

procedure TGeraExcel.pFormataDetalhes(intLinIni, intLinFin : Integer);
  Var
    intCont: Integer;
    strCelulaIni: String;
    strCelulaFin: String;
    strFormatoNumerico: String;
begin
  If Not FImpDetalhes Then
    Exit;

  For intCont := 1 To (FQtdCol-FIncQtdCol) Do
  Begin

    strCelulaIni := fColunaComoLetra(intCont) + IntToStr(intLinIni);
    strCelulaFin := fColunaComoLetra(intCont) + IntToStr(intLinFin);

    If FCampos.ColunaPorIndice[intCont].Tipo = ftFloat Then
    Begin

      If FCampos.ColunaPorIndice[intCont].Precisao > 0 Then
        strFormatoNumerico := '#.##0,' + fReplicatorStr('0', FCampos.ColunaPorIndice[intCont].Precisao)
      Else
        strFormatoNumerico := '#.##0,00';

      If FCampos.ColunaPorIndice[intCont].Porcentagem Then
        strFormatoNumerico := strFormatoNumerico + '%';

      FExcel.FormatoNumerico(strCelulaIni, strCelulaFin, strFormatoNumerico);

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
        If FCampos.ColunaPorIndice[intCont].Tipo <> ftMemo Then
          FExcel.FormatoNumerico(strCelulaIni, strCelulaFin, '@');
        FExcel.Alinhamento(strCelulaIni, strCelulaFin, Esquerda);
      End;

      If FCampos.ColunaPorIndice[intCont].Alinhamento = Direita Then
        FExcel.Alinhamento(strCelulaIni, strCelulaFin, Direita);
    End;
  End;
end;

{function TGeraExcel.fArquivoAberto(strNomArq: String): Boolean;
var
   stmArquiv: TStream;
begin
  Result := False;
  Try
     Try
       If FileExists(strNomArq) Then
         stmArquiv := TFileStream.Create(strNomArq, fmOpenRead or fmShareExclusive);
     Except
       on EStreamError do
       Begin
         pMensagemOK('O arquivo ' + strNomArq + ' está sendo usado por outro processo. Operação cancelada!');
         Result := True; // EFOpenError
       End;
     End;
  Finally
    If Assigned(stmArquiv) Then
      FreeAndNil(stmArquiv);
  End;
end;}

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
