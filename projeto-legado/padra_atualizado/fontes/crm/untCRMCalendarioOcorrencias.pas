unit untCRMCalendarioOcorrencias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.Samples.Calendar, Uni, UniClientDataSet,
  Vcl.ComCtrls, Vcl.Buttons,Data.DB;

type

  TRecIdxOrd = Record
    strFields: String;
    strDescFields: String;
  End;

  RecAgendamentoOcorrencia = Record
    dia: String;
    descricao: String;
    cliente: String;
    codigoOcorrencia: String;
    data: TDateTime;
    hora: TDateTime;
    numdoc: String;
    grupoOcorrencia: String;
    situacao: String;
    codigoCliente: String;
    numlead: String;
    codigoEmpresa: String;
    codigoTipoOco: String;
    DtaAgendamento: String;
    codigoOpe: String;
    codigoCoc: String;
  End;

  TCalendarioOcorrenciaCRM = class(TCalendar)
  private
    FExibirDiasSemanaFeriado: Boolean;
    FArrayDatas: Array of RecAgendamentoOcorrencia;
    FArrayOcorrenciasDia: Array of RecAgendamentoOcorrencia;
    FAno,
    FMes,
    Fdia: Word;
    FTotalAgendamentosDia,
    FEspacoEntreLinhas,
    FTamFonteDescricao,
    FTamFonteDia,
    FIndiceCodOco: Integer;
    FIndiceCodCli: Integer;
    FCorDestaqueCelula: TColor;
    FDataSelecionada,
    FDataFoco: TDateTime;
    FCdsOcorrencias: TUniClientDataSet;
    FDataSelecionadaAnteriormente: TDateTime;
    FPularAnterior,
    FPularProximo: Boolean;
    FIndiceCodEmpresa: Integer;
    FIndiceCodToc: Integer;
    FIndiceDesToc: Integer;
    FIndiceDtaAgendamento: Integer;
    FIndiceCodOpe: Integer;
    FIndiceCodCoc: Integer;
    FIndiceSituacao: Integer;
    FIndiceNumDoc: Integer;
    FIndiceNumLead: Integer;
    FintTotColAge: Integer;
    FLarguraCol: Integer;
    FNomeFormulario: String;
    FBlnColunasPadrao: Boolean;
    qryCol : TUniQuery;
    FTip_Fc: String;
    FTamFonteAge: Integer;

    procedure pMarcaDataFeriado(const Data: TDateTime);
    procedure pAjustaAlturaLinhaCabecalho;
    procedure pAjustaLarguraColunas;
    function fObtemPosicao(const PosicaoAnterior: Integer; const Rect: TRect; const Texto: string): Integer;
    function fObtemCorFonte(const ATexto: string): TColor; overload;
    function fObtemCorFonte(const ADiaSemana: Integer): TColor; overload;
    function fObtemNumeroOcorrenciasPorCelula(const Rect: TRect; const ATexto: string; const aTamNumeroData: Integer): Integer;
    function fObtemCorFundoTexto(const ADataCelula: TDateTime): TColor;
    procedure pSetarIndiceSubItensPadrao;
    procedure pConfigurarColunas(var ListView: TListView);
    procedure pConfigurarColunasPadrao(var ListView: TListView);
    procedure pCarregarColunasCfg(const strDescricao: string);
    function fConfigurarColunasUsu(var ListView: TListView): Boolean;
    procedure pSetarIndiceCampos(const strNomCampo: String; intIndice: Integer);
    procedure pAdicionarDadosAgendamentoPadrao(var ListView: TListView);
    procedure pAdicionarDadosAgendamento(var ListView: TListView);
    procedure pConfigurarListView(var ListView: TListView);
    procedure pAjustarIndices(var ListView: TListView);
    function fRetornaIdxOrdenacao(strNomGrd: String): TRecIdxOrd;
    procedure pAtualizarOrdCol(var ListView: TListView);
  protected
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy;override;
    procedure pAtualizarCalendario(cdsOcorrencias: TUniClientDataSet);
    function fObterDetalhamentoDia(var ListView: TListView): Boolean;
    procedure pAjustaTamanhoColunas;
    function fObtemPrimeiroDiaMes: TDateTime;

    property ExibirDiasSemanaFeriado: Boolean read FExibirDiasSemanaFeriado  write FExibirDiasSemanaFeriado;
    property TotalAgendamentosDia: Integer read FTotalAgendamentosDia write FTotalAgendamentosDia;
    property IndiceOcorrencia: Integer read FIndiceCodOco;
    property CorDestaqueCelula: TColor read FCorDestaqueCelula write FCorDestaqueCelula;
    property DataSelecionada: TDateTime read FDataSelecionada write FDataSelecionada;
    property DataFoco: TDateTime read FDataFoco write FDataFoco;
    property DataSelecionadaAnteriormente: TDateTime read FDataSelecionadaAnteriormente write FDataSelecionadaAnteriormente;
    property PularAnterior: Boolean read FPularAnterior write FPularAnterior;
    property PularProximo: Boolean read FPularProximo write FPularProximo;
    property IndiceCliente: Integer read FIndiceCodCli write FIndiceCodCli;
    property IndiceCodEmpresa: Integer read FIndiceCodEmpresa write FIndiceCodEmpresa;
    property IndiceCodToc: Integer read FIndiceCodToc write FIndiceCodToc;
    property IndiceDesToc: Integer read FIndiceDesToc write FIndiceDesToc;
    property IndiceDtaAgendamento: Integer read FIndiceDtaAgendamento write FIndiceDtaAgendamento;
    property IndiceCodOpe: Integer read FIndiceCodOpe write FIndiceCodOpe;
    property IndiceCodCoc: Integer read FIndiceCodCoc write FIndiceCodCoc;
    property strNomFormulario: String read FNomeFormulario write FNomeFormulario;
    property strTip_Fc: String read FTip_Fc write FTip_Fc;
    property TamFonteAge: Integer read FTamFonteAge write FTamFonteAge;
  end;

implementation


uses
  DateUtils, untFuncoesSimples, StrUtils;

{ TCalendarioOcorrenciaCRM }

constructor TCalendarioOcorrenciaCRM.Create(Owner: TComponent);
begin
  inherited;

  FExibirDiasSemanaFeriado := True;
  FTotalAgendamentosDia := 0;
  FEspacoEntreLinhas := 2;
  FTamFonteDescricao := 7;
  FTamFonteDia := 11;
  FCorDestaqueCelula := clMoneyGreen;
  FCdsOcorrencias := TUniClientDataSet.Create(Owner);
  FDataSelecionada := 0;
  FDataFoco := 0;   
  Self.DefaultDrawing := True;
  FPularAnterior := False;
  FPularProximo := True;
  FBlnColunasPadrao := True;
  pSetarIndiceSubItensPadrao;
  qryCol := fCriaQuery;
  FTamFonteAge := 8;
end;

procedure TCalendarioOcorrenciaCRM.pAjustaAlturaLinhaCabecalho;
var
  iCnt,
  AlturaInicial,
  NovaAltura: Integer;
Begin
  AlturaInicial  := Self.Height div Self.RowCount ;
  NovaAltura := AlturaInicial div 3;

  Self.RowHeights[0] := NovaAltura;
  For iCnt := 1 to Self.RowCount -2 Do
  Begin
    Self.RowHeights[iCnt] :=  AlturaInicial + (NovaAltura div (Self.RowCount -1));
  End;
End;

procedure TCalendarioOcorrenciaCRM.pAjustaLarguraColunas;
var
  intCont,
  Largura,
  LarguraTotalInicial: Integer;
begin
  LarguraTotalInicial := Self.Width;

  If Not(FExibirDiasSemanaFeriado) Then
    Largura := LarguraTotalInicial div 5
  Else
    Largura := LarguraTotalInicial div 7;

  intCont := 0;
  Repeat
    Self.ColWidths[intCont] := Largura;

    If FExibirDiasSemanaFeriado Then
    Begin
      Self.ColWidths[0] := Largura - (Self.Margins.Left + Self.Margins.Right);
      Self.ColWidths[6] := Largura - (Self.Margins.Left + Self.Margins.Right);
    End;

    If Not FExibirDiasSemanaFeriado Then
    Begin
      Self.ColWidths[1] := Largura - (Self.Margins.Left + Self.Margins.Right); // segunda
      Self.ColWidths[5] := Largura - (Self.Margins.Left + Self.Margins.Right); // sexta
    End;

    Inc(intCont);

  Until (intCont = Self.ColCount-1);

  If Not(FExibirDiasSemanaFeriado) Then
  Begin
    Self.ColWidths[0] := 0;  // Domingo
    Self.ColWidths[6] := 0;  // Sábado
  End;

end;

procedure TCalendarioOcorrenciaCRM.pAjustaTamanhoColunas;
begin
  pAjustaLarguraColunas;
  pAjustaAlturaLinhaCabecalho;
end;

procedure TCalendarioOcorrenciaCRM.pAtualizarCalendario(cdsOcorrencias
  : TUniClientDataSet);
var
  intCont: integer;
Begin
  FDia := 0;
  FAno := 0;
  FMes := 0;

  FillChar(FArrayDatas, SizeOf(FArrayDatas), #0);
  SetLength(FArrayDatas, Length(FArrayDatas));
  intCont := 0;

  FCdsOcorrencias := cdsOcorrencias;
  FCdsOcorrencias.IndexFieldNames := 'OCO_DTAAGE;CLI_NOMCLI;OCO_CODCLI;GOC_DESGOC;OCO_CODOCO';
  FCdsOcorrencias.DisableControls;
  try
    FCdsOcorrencias.First;
    While Not FCdsOcorrencias.Eof Do
    Begin
      SetLength(FArrayDatas, Length(FArrayDatas) + 1);
      SetLength(FArrayOcorrenciasDia, Length(FArrayOcorrenciasDia));

      DecodeDate(FCdsOcorrencias.FieldByName('OCO_DTAAGE').AsDateTime, FAno, FMes, Fdia);

      FArrayDatas[intCont].dia := IntToStr(FDia);
      FArrayDatas[intCont].data := FCdsOcorrencias.FieldByName('OCO_DTAAGE').AsDateTime;
      FArrayDatas[intCont].hora := FCdsOcorrencias.FieldByName('OCO_HORAGE').AsDateTime;
      FArrayDatas[intCont].cliente := FCdsOcorrencias.FieldByName('CLI_NOMCLI').AsString;
      FArrayDatas[intCont].codigocliente := FCdsOcorrencias.FieldByName('OCO_CODCLI').AsString;
      FArrayDatas[intCont].codigoocorrencia := FCdsOcorrencias.FieldByName('OCO_CODOCO').AsString;
      FArrayDatas[intCont].descricao := FCdsOcorrencias.FieldByName('TOC_DESTOC').AsString;
      FArrayDatas[intCont].numDoc := FCdsOcorrencias.FieldByName('DOCUMENTO').AsString;
      FArrayDatas[intCont].grupoocorrencia := FCdsOcorrencias.FieldByName('GOC_DESGOC').AsString;
      If Not fEmptyStr(FCdsOcorrencias.FieldByName('OCO_CODSIT').AsString) then
        FArrayDatas[intCont].situacao := fRetDesSitOco(FCdsOcorrencias.FieldByName('OCO_CODSIT').AsString);
      FArrayDatas[intCont].numlead  := FCdsOcorrencias.FieldByName('NLEAD').AsString;
      FArrayDatas[intCont].codigoempresa := FCdsOcorrencias.FieldByName('OCO_CODEMP').AsString;
      FArrayDatas[intCont].codigoTipoOco := FCdsOcorrencias.FieldByName('OCO_CODTOC').AsString;
      FArrayDatas[intCont].DtaAgendamento := FCdsOcorrencias.FieldByName('OCO_DTAAGE').AsString;
      FArrayDatas[intCont].codigoOpe := FCdsOcorrencias.FieldByName('OCO_CODOPE').AsString;
      FArrayDatas[intCont].codigoCoc := FCdsOcorrencias.FieldByName('OCO_CODCOC').AsString;

      Inc(intCont);
      FCdsOcorrencias.Next;
    End;
  finally
    FCdsOcorrencias.EnableControls;
  end;  

end;

function TCalendarioOcorrenciaCRM.fObtemPosicao(const PosicaoAnterior: Integer; const Rect: TRect; const Texto: String): Integer;
Begin
  If PosicaoAnterior = 0 Then
    Result := Rect.Top + Canvas.TextHeight(Texto) + FEspacoEntreLinhas
  Else
    Result := PosicaoAnterior + Canvas.TextHeight(Texto) - FEspacoEntreLinhas;
End;

function TCalendarioOcorrenciaCRM.fObtemPrimeiroDiaMes: TDateTime;
var
  Dia, Mes, Ano: Word;
Begin
  DecodeDate(Today, Ano, Mes, Dia);
  Result := EncodeDateTime(Ano, Mes, 1, 0, 0, 0, 0);
End;

procedure TCalendarioOcorrenciaCRM.pMarcaDataFeriado(const Data: TDateTime);
Begin
  If fEhFeriado(Data) Then
  Begin
    Canvas.Font.Style := [];
    Canvas.Font.Color := clRed;
  End;
End;

procedure TCalendarioOcorrenciaCRM.pSetarIndiceSubItensPadrao;
begin
  FIndiceDesToc := 0;
  FIndiceSituacao := 1;
  FIndiceNumDoc := 2;
  FIndiceNumLead:= 3;
  FIndiceCodOco := 4;
  FIndiceCodCli := 5;
  FIndiceCodEmpresa := 6;
  FIndiceCodToc := 7;
  FIndiceDtaAgendamento := 8;
  FIndiceCodOpe := 9;
  FIndiceCodCoc := 10;
end;

procedure TCalendarioOcorrenciaCRM.pSetarIndiceCampos(
  const strNomCampo: String; intIndice: Integer);
begin
  If strNomCampo = 'TOC_DESTOC' Then
    FIndiceDesToc := intIndice;

  If strNomCampo = 'XXX' Then
    FIndiceSituacao := intIndice;

  If strNomCampo = 'OCO_NUMDOC' Then
    FIndiceNumDoc := intIndice;

  If strNomCampo = 'NLEAD' Then
    FIndiceNumLead := intIndice;

  If strNomCampo = 'OCO_CODOCO' Then
    FIndiceCodOco := intIndice;

  If strNomCampo = 'OCO_CODCLI' Then
    FIndiceCodCli := intIndice;

  If strNomCampo = 'OCO_CODEMP' Then
    FIndiceCodEmpresa := intIndice;

  If strNomCampo = 'OCO_CODTOC' Then
    FIndiceCodToc := intIndice;

  If strNomCampo = 'OCO_DTAAGE' Then
    FIndiceDtaAgendamento := intIndice;

  If strNomCampo = 'OCO_CODOPE' Then
    FIndiceCodOpe := intIndice;

  If strNomCampo = 'OCO_CODCOC' Then
    FIndiceCodCoc := intIndice;
end;

destructor TCalendarioOcorrenciaCRM.Destroy;
Begin
  FreeAndNil(FCdsOcorrencias);
  FreeAndNil(qryCol);

  inherited;
End;

function TCalendarioOcorrenciaCRM.fObtemCorFonte(const ATexto: string): TColor;
Begin
  If (AnsiUpperCase(ATexto) = 'DOM') Then
    Result := clRed
  Else
    Result := clInfoText;
End;

function TCalendarioOcorrenciaCRM.fObtemCorFonte(const ADiaSemana: Integer): TColor;
Begin
  If (ADiaSemana = 1) Then
    Result := clRed
  Else
    Result := clInfoText;
End;   

function TCalendarioOcorrenciaCRM.fObtemNumeroOcorrenciasPorCelula(const Rect: TRect; const ATexto: string; const aTamNumeroData: Integer): Integer;
var
  TamTexto: Integer;
  TamSinal: Integer;
Begin
  Result := 0;
  Try        
    TamSinal := Canvas.TextHeight('+');
    TamTexto := Rect.Height - aTamNumeroData  - TamSinal - 2;

    Result := TamTexto div Canvas.TextHeight(ATexto);
    TamTexto := TamTexto - (FEspacoEntreLinhas * Result);
    Result := TamTexto div Canvas.TextHeight(ATexto);     
  Finally
    If Result <= 0 Then
      Result := 1;
  End;
End;

function TCalendarioOcorrenciaCRM.fObtemCorFundoTexto(const ADataCelula: TDateTime): TColor;
Begin
  If (ADataCelula <> Self.CalendarDate) Then
    Result := FCorDestaqueCelula
  Else
    Result := clWindow;
End;

procedure TCalendarioOcorrenciaCRM.DrawCell(ACol, ARow: integer; ARect: TRect;
  AState: TGridDrawState);
var
  Texto, Descricao: String;
  contador, DiaDoMes: Integer;
  iPosicaoItem: Integer;
  NumeroOcorrenciasDia, NumeroOcorrenciasPorCelula: Integer;
  DataCelula: TDateTime;
  MarginRect: TRect;   
  DiaSemana: Integer;
  TamData: Integer;
begin   
  Texto := CellText[ACol, ARow];
  DiaDoMes := StrToIntDef(Texto, 0);
  Canvas.Font.Color := clInfoText;
  MarginRect := Rect(ARect.Left +10, ARect.Top, ARect.Right -10, ARect.Bottom);

  If DiaDoMes <= 0 Then
  Begin
    Canvas.Font.Style := [fsBold];  
    Canvas.Font.Color := fObtemCorFonte(Texto); 
    Canvas.TextRect(ARect, ARect.Left + (ARect.Right - ARect.Left) div 2, ARect.Top + (ARect.Bottom - ARect.Top - Canvas.TextHeight(Texto)) div 2,
      AnsiUpperCase( Texto ));
    Canvas.Font.Style := [];
  End;  
  
  If DiaDoMes > 0 Then
  Begin
    DataCelula := EncodeDateTime(Self.Year, Self.Month, DiaDoMes, 0, 0, 0, 0);
    DiaSemana := DayOfWeek(DataCelula);

    Canvas.Font.Color := fObtemCorFonte(DiaSemana);
    pMarcaDataFeriado(DataCelula);

    If (gdFocused in AState) Then
    Begin
      FDataFoco := DataCelula;  
    End;    

    Canvas.Font.Style := [fsBold];
    Canvas.Font.Size := FTamFonteDia;
    Canvas.TextOut(ARect.Left + 2, ARect.Top + 2, Texto);
    Canvas.Font.Style := [];

    TamData := Canvas.TextHeight(Texto);
    iPosicaoItem := 0;
    NumeroOcorrenciasDia := 0;

    For contador := 0 To Length(FArrayDatas) - 1 Do
    Begin
      If DataCelula = FArrayDatas[contador].data Then
      Begin
        Inc(NumeroOcorrenciasDia);
        Descricao:= FArrayDatas[contador].cliente + ' - ' + FArrayDatas[contador].descricao ;
        iPosicaoItem := fObtemPosicao(iPosicaoItem, ARect, Descricao);

        Canvas.Font.Style := [fsBold];
        Canvas.Font.Size := FTamFonteDia;
        Canvas.TextOut(ARect.Left + 2, ARect.Top + 2, FArrayDatas[contador].dia);
        Canvas.Font.Style := [];
        Canvas.Font.Size := FTamFonteDescricao;          

        NumeroOcorrenciasPorCelula := fObtemNumeroOcorrenciasPorCelula(ARect, Descricao, TamData);  
 
        If NumeroOcorrenciasDia <= NumeroOcorrenciasPorCelula then
        Begin
          MarginRect.Top := iPosicaoItem;
          MarginRect.Bottom := ARect.Bottom;
          Canvas.TextRect(MarginRect, Descricao);
          Canvas.Font.Style := [];
          iPosicaoItem := fObtemPosicao(iPosicaoItem, ARect, Descricao);
        End;

        If NumeroOcorrenciasDia > NumeroOcorrenciasPorCelula then
        Begin           
          Canvas.Brush.Color := fObtemCorFundoTexto(DataCelula);
          Canvas.Font.Style := [fsBold];
          Canvas.TextOut(ARect.Right - 15, ARect.Bottom - 15, ' + ');
          Break;
        End;

      End
      Else
        iPosicaoItem := 0;

    end;     
  end;       
end;

procedure TCalendarioOcorrenciaCRM.pConfigurarColunas(var ListView: TListView);
Begin
  If Not fConfigurarColunasUsu(ListView) Then
    pConfigurarColunasPadrao(ListView);
End;


procedure TCalendarioOcorrenciaCRM.pConfigurarColunasPadrao(var ListView: TListView);
var
  ColunaTmp: TListColumn;
  intCnt: Integer;
  strCaption: String;
begin
  FintTotColAge := 5;
  FLarguraCol := ListView.Width div FintTotColAge;
  For intCnt := 0 To  FintTotColAge-1  Do
  Begin
    Case intCnt Of
      0: strCaption:= 'Grupo';
      1: strCaption:= 'Tipo';
      2: strCaption:= 'Situação';
      3: strCaption:= 'Documento';
      4: strCaption:= 'N° Lead';
    End;

    ColunaTmp := ListView.Columns.Add;
    ColunaTmp.AutoSize := True;
    ColunaTmp.Caption := strCaption;
    ColunaTmp.Width := FLarguraCol;
  End;
end;

procedure TCalendarioOcorrenciaCRM.pCarregarColunasCfg(
  const strDescricao: string);
const
  SQLSelect = 'SELECT * FROM COLCNF        ' +
              ' WHERE                      ' +
              '   COL_CODEMP = :CODEMP     ' +
              '   AND COL_NOMFOR = :NOMFOR ' +
              '   AND COL_CODOPE = :CODOPE ' +
              '   AND COL_NOMGRD = :NOMGRD ' +
              '   AND COL_COLNAM <> "CLI_NOMCLI" ' +
              ' ORDER BY COL_COLORD ASC    ';
begin
  qryCol.DisableControls;
  Try
    qryCol.Close;
    qryCol.SQL.Clear;
    qryCol.SQL.Add(SQLSelect);
    qryCol.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCol.ParamByName('NOMFOR').AsString := FNomeFormulario;
    qryCol.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryCol.ParamByName('NOMGRD').AsString := strDescricao;;
    qryCol.Open;

    While Not qryCol.eof do
    Begin
      qryCol.Edit;

      If (Not Pos(strTip_Fc, 'C_P_') > 0) And (qryCol.FieldByName('COL_COLNAM').AsString = 'DOCUMENTO') Then
        qryCol.FieldByName('COL_COLEXI').AsString := 'N';

      If (Not(Pos(strTip_Fc, 'C_P_') > 0) And fCfgSis('IFVLOR', varBoolean) And (qryCol.FieldByName('COL_COLNAM').AsString = 'FGO_VALORC')) Then
        qryCol.FieldByName('COL_COLEXI').AsString := 'N';

      If (Not Pos(strTip_Fc, 'C_P_') > 0) And (qryCol.FieldByName('COL_COLNAM').AsString = 'FGO_VLRCON') Then
        qryCol.FieldByName('COL_COLEXI').AsString := 'N';

      If (Not(fCfgSis('USADEP', varBoolean))) And (qryCol.FieldByName('COL_COLNAM').AsString = 'STATUSDEPS') Then
        qryCol.FieldByName('COL_COLEXI').AsString := 'N';

      If (Not fUtilizarCategoriaParaPedidoOrcamento) And (qryCol.FieldByName('COL_COLNAM').AsString = 'CAT_DESCRI') Then
        qryCol.FieldByName('COL_COLEXI').AsString := 'N';

      If (Not fUtilizarCategoriaParaPedidoOrcamento) And (qryCol.FieldByName('COL_COLNAM').AsString = 'CAT_CORCAT') Then
        qryCol.FieldByName('COL_COLEXI').AsString := 'N';

      If (Not fCfgSis('SEGCND', varBoolean)) And (qryCol.FieldByName('COL_COLNAM').AsString = 'FGO_PREVIS') Then
        qryCol.FieldByName('COL_COLEXI').AsString := 'N';

      If (Not fCfgSis('OCOAST', varBoolean)) And (qryCol.FieldByName('COL_COLNAM').AsString = 'OCO_ASSUNT') Then
        qryCol.FieldByName('COL_COLEXI').AsString := 'N';

      If (Not fCfgSis('CRMTEA', varBoolean)) And (qryCol.FieldByName('COL_COLNAM').AsString = 'TEA_DESCRI') Then
      Begin
        qryCol.FieldByName('COL_COLEXI').AsString := 'N';
      End;

      If (qryCol.FieldByName('COL_COLNAM').AsString = 'TEA_CORTEA') Then
        qryCol.FieldByName('COL_COLEXI').AsString := 'N';

      qryCol.Post;

      qryCol.Next;
    End;
  Finally
    qryCol.EnableControls;
  End;
end;

function TCalendarioOcorrenciaCRM.fConfigurarColunasUsu(var ListView: TListView): Boolean;
var
  ColunaTmp: TListColumn;
begin
  Result := False;

  pCarregarColunasCfg(ListView.Name);

  If Not qryCol.IsEmpty Then
  Begin
    qryCol.Filter   := 'COL_COLEXI="S" ';
    qryCol.Filtered := True;
    FintTotColAge := qryCol.RecordCount;
    qryCol.Filtered := False;

    FBlnColunasPadrao := False;
    If FintTotColAge > 0 Then
      FLarguraCol := ListView.Width div FintTotColAge
    Else
      FLarguraCol := ListView.Width;

    qryCol.First;
    While Not qryCol.eof do
    Begin
      If (qryCol.FieldByName('COL_COLEXI').AsString = 'S') Then
      Begin
        ColunaTmp := ListView.Columns.Add;
        ColunaTmp.AutoSize := True;
        ColunaTmp.Caption := qryCol.FieldByName('COL_COLCAP').AsString;
        ColunaTmp.Width := FLarguraCol;
      End;
      qryCol.Next;
    End;

    Result := True;
  End;
end;

procedure TCalendarioOcorrenciaCRM.pConfigurarListView(var ListView: TListView);
Begin
  ListView.Items.BeginUpdate;
  Try
    ListView.Items.Clear;
    ListView.Columns.Clear;
    ListView.Groups.Clear;
    ListView.DoubleBuffered := True;
    ListView.ViewStyle := vsReport;
    ListView.GroupView := True;
    ListView.RowSelect := True;
    ListView.Font.Size := FTamFonteAge;
    ListView.Font.Style := [fsBold];
    pConfigurarColunas(ListView);
  Finally
    ListView.Items.EndUpdate;
  End;
End;

procedure TCalendarioOcorrenciaCRM.pAtualizarOrdCol(var ListView: TListView);
var
  RecIdx: TRecIdxOrd;
  cdsOrd, cdsBkp: TUniClientDataSet;
  Index: TIndexDef;
  intField: Integer;
begin

  If FCdsOcorrencias.IsEmpty Then
    Exit;

  cdsOrd := TUniClientDataSet( FCdsOcorrencias );
  cdsBkp := TUniClientDataSet.Create(Nil);

  Try
    Try
      cdsBkp.Data := cdsOrd.data;

      cdsOrd.IndexDefs.Clear;
      cdsOrd.IndexName := '';
      cdsOrd.StoreDefs := False;
      cdsOrd.IndexFieldNames := '';

      RecIdx := fRetornaIdxOrdenacao(ListView.Name);

      cdsOrd.Active := false;
      Index:= cdsOrd.IndexDefs.AddIndexDef;
      Index.Name   := 'IDX_001';
      Index.Fields := RecIdx.strFields;
      Index.DescFields := RecIdx.strDescFields;

      cdsOrd.IndexName := 'IDX_001';

      cdsOrd.CreateDataSet;
      cdsOrd.Data := cdsBkp.Data;

      For intField := 0 To cdsOrd.Fields.Count -1 Do
      Begin
        If cdsOrd.Fields[intField].DataType = ftFloat Then
          TFloatField(cdsOrd.Fields[intField]).DisplayFormat := '#,##0.00';
      End;
    Except
      On E: Exception Do
      Begin
        If Not cdsBkp.IsEmpty Then
        Begin
          cdsOrd.data := cdsBkp.Data;
          cdsOrd.Active := True;
        End;
      End;
    End;
  Finally
    FreeAndNil(cdsBkp);
  End;
end;

procedure TCalendarioOcorrenciaCRM.pAdicionarDadosAgendamento(var ListView: TListView);
Var
  dia, mes, ano: Word;
  ListaItem: TListItem;
  GrupoId, intCont: Integer;
  Grupo: TListGroup;
  strAux: String;
  intIndice: Integer;
Begin
  intCont := 0;
  GrupoId := 0;

  pAtualizarOrdCol(ListView);

  FCdsOcorrencias.DisableControls;
  ListView.Items.BeginUpdate;
  Try
    Grupo := ListView.Groups.Add;

    FCdsOcorrencias.First;
    While Not FCdsOcorrencias.EOF do
    Begin

      If FCdsOcorrencias.FieldByName('OCO_DTAAGE').AsDateTime =  Self.CalendarDate Then
      Begin

        SetLength(FArrayOcorrenciasDia, Length(FArrayOcorrenciasDia) + 1);
        If intCont = 0 Then
        Begin
          Grupo.Header := FCdsOcorrencias.FieldByName('CLI_NOMCLI').AsString;
          Grupo.State := [lgsNormal, lgsCollapsible];
          GrupoId := Grupo.GroupID;
        End
        Else
        If ((intCont > 0) and (FCdsOcorrencias.FieldByName('CLI_NOMCLI').AsString <> (Grupo.Header))) Then
        Begin
          Grupo := ListView.Groups.Add;
          Grupo.Header := FCdsOcorrencias.FieldByName('CLI_NOMCLI').AsString;
          Grupo.State := [lgsNormal, lgsCollapsible];
          GrupoId := Grupo.GroupID;
        End;

        ListaItem := ListView.Items.Add;
        ListaItem.GroupID := GrupoId;

        intIndice := 0;
        qryCol.First;
        While Not qryCol.EOF do
        Begin
          Try
            If qryCol.FieldByName('COL_COLEXI').AsString = 'S' Then
            Begin
              If intIndice = 0 Then
              Begin
                ListaItem.Caption := FCdsOcorrencias.FieldByName(qryCol.FieldByName('COL_COLNAM').AsString).AsString;
              End
              Else
              Begin
                ListaItem.SubItems.Add(FCdsOcorrencias.FieldByName(qryCol.FieldByName('COL_COLNAM').AsString).AsString);
              End;
              Inc(intIndice);
            End;
          Except
            On E: Exception Do
            Begin
              strAux := E.Message;
            End;
          End;
          qryCol.Next;
        End;

        // São adicionados campos para operações independente do formato de exibição - não ficam visíveis
        ListaItem.SubItems.Add(FCdsOcorrencias.FieldByName('OCO_CODOCO').AsString);
        ListaItem.SubItems.Add(FCdsOcorrencias.FieldByName('OCO_CODCLI').AsString);
        ListaItem.SubItems.Add(FCdsOcorrencias.FieldByName('OCO_CODEMP').AsString);
        ListaItem.SubItems.Add(FCdsOcorrencias.FieldByName('OCO_CODTOC').AsString);
        ListaItem.SubItems.Add(FCdsOcorrencias.FieldByName('OCO_DTAAGE').AsString);
        ListaItem.SubItems.Add(FCdsOcorrencias.FieldByName('OCO_CODOPE').AsString);
        ListaItem.SubItems.Add(FCdsOcorrencias.FieldByName('OCO_CODCOC').AsString);

        DecodeDate(FCdsOcorrencias.FieldByName('OCO_DTAAGE').AsDateTime, Ano, Mes, dia);
        FArrayOcorrenciasDia[intCont].data := FCdsOcorrencias.FieldByName('OCO_DTAAGE').AsDateTime;
        FArrayOcorrenciasDia[intCont].dia := IntToStr(dia);
        FArrayOcorrenciasDia[intCont].hora := FCdsOcorrencias.FieldByName('OCO_HORAGE').AsDateTime;
        FArrayOcorrenciasDia[intCont].descricao := FCdsOcorrencias.FieldByName('TOC_DESTOC').AsString;
        FArrayOcorrenciasDia[intCont].codigoocorrencia := FCdsOcorrencias.FieldByName('OCO_CODOCO').AsString;
        FArrayOcorrenciasDia[intCont].numlead := FCdsOcorrencias.FieldByName('NLEAD').AsString;

        Inc(intCont);
      End;
      FCdsOcorrencias.Next;
    End;

    pAjustarIndices(ListView);

  Finally
    FCdsOcorrencias.EnableControls;
    ListView.Items.EndUpdate;
  End;
End;

procedure TCalendarioOcorrenciaCRM.pAjustarIndices(var ListView: TListView);
var
  intIndice: Integer;
Begin
  If FintTotColAge <= 0 Then
    Exit;

  intIndice := FintTotColAge-1;

  pSetarIndiceCampos('OCO_CODOCO', intIndice);
  Inc(intIndice);

  pSetarIndiceCampos('OCO_CODCLI', intIndice);
  Inc(intIndice);

  pSetarIndiceCampos('OCO_CODEMP', intIndice);
  Inc(intIndice);

  pSetarIndiceCampos('OCO_CODTOC', intIndice);
  Inc(intIndice);

  pSetarIndiceCampos('OCO_DTAAGE', intIndice);
  Inc(intIndice);

  pSetarIndiceCampos('OCO_CODOPE', intIndice);
  Inc(intIndice);

  pSetarIndiceCampos('OCO_CODCOC', intIndice);
End;

procedure TCalendarioOcorrenciaCRM.pAdicionarDadosAgendamentoPadrao(var ListView: TListView);
var
  ListaItem: TListItem;
  GrupoId, intCnt, intCont: Integer;
  Grupo: TListGroup;
Begin
  If Not FBlnColunasPadrao Then
    Exit;

  intCont := 0;
  GrupoId := 0;

  ListView.Items.BeginUpdate;
  Try
    Grupo := ListView.Groups.Add;

    For intCnt := 0 to Length(FArrayDatas) - 1 Do
    Begin
      If FArrayDatas[intCnt].data = Self.CalendarDate Then
      Begin
        SetLength(FArrayOcorrenciasDia, Length(FArrayOcorrenciasDia) + 1);

        If intCont = 0 Then
        Begin
          Grupo.Header := FArrayDatas[intCnt].cliente;
          Grupo.State := [lgsNormal, lgsCollapsible];
          GrupoId := Grupo.GroupID;
        End
        Else
        If intCont > 0 Then
        Begin
          If FArrayDatas[intCnt].cliente <> Grupo.Header Then
          Begin
            Grupo := ListView.Groups.Add;
            Grupo.Header := FArrayDatas[intCnt].cliente;
            Grupo.State := [lgsNormal, lgsCollapsible];
            GrupoId := Grupo.GroupID;
          End;
        End;

        ListaItem := ListView.Items.Add;
        ListaItem.GroupID := GrupoId;
        ListaItem.Caption := FArrayDatas[intCnt].grupoocorrencia;
        ListaItem.SubItems.Add(FArrayDatas[intCnt].descricao);
        ListaItem.SubItems.Add(FArrayDatas[intCnt].situacao);
        ListaItem.SubItems.Add(FArrayDatas[intCnt].numdoc);
        ListaItem.SubItems.Add(FArrayDatas[intCnt].numlead);
        ListaItem.SubItems.Add(FArrayDatas[intCnt].codigoocorrencia);  // Alterar a definição dos Indices em caso de alteracao de ordem de subtitens
        ListaItem.SubItems.Add(FArrayDatas[intCnt].codigocliente);
        ListaItem.SubItems.Add(FArrayDatas[intCnt].codigoempresa);
        ListaItem.SubItems.Add(FArrayDatas[intCnt].codigoTipoOco);
        ListaItem.SubItems.Add(FArrayDatas[intCnt].DtaAgendamento);
        ListaItem.SubItems.Add(FArrayDatas[intCnt].CodigoOpe);
        ListaItem.SubItems.Add(FArrayDatas[intCnt].CodigoCoc);

        FArrayOcorrenciasDia[intCont].data := FArrayDatas[intCnt].data;
        FArrayOcorrenciasDia[intCont].dia := FArrayDatas[intCnt].dia;
        FArrayOcorrenciasDia[intCont].hora := FArrayDatas[intCnt].hora;
        FArrayOcorrenciasDia[intCont].descricao := FArrayDatas[intCnt].descricao;
        FArrayOcorrenciasDia[intCont].codigoocorrencia := FArrayDatas[intCnt].codigoocorrencia;
        FArrayOcorrenciasDia[intCont].numlead := FArrayDatas[intCnt].numlead;

        Inc(intCont);
      End;
    End;
  Finally
    ListView.Items.EndUpdate;
  End;
End;

function TCalendarioOcorrenciaCRM.fObterDetalhamentoDia(var ListView: TListView): Boolean;
Begin
  If Not Assigned(ListView) Then
  Begin
    Result := False;
    Exit;
  End;

  FillChar(FArrayOcorrenciasDia, SizeOf(FArrayOcorrenciasDia), #0);
  Try
    Try
      pConfigurarListView(ListView);

      If FBlnColunasPadrao Then
        pAdicionarDadosAgendamentoPadrao(ListView)
      Else
        pAdicionarDadosAgendamento(ListView);
    Except
      On E: Exception Do
       pMensagensErro(E.Message, '[TCalendarioOcorrenciaCRM.fObterDetalhamentoDia]');
    End;
  Finally
    FTotalAgendamentosDia := Length(FArrayOcorrenciasDia);
    Result := FTotalAgendamentosDia > 0;
  End;

End;

function TCalendarioOcorrenciaCRM.fRetornaIdxOrdenacao(strNomGrd: String): TRecIdxOrd;
const SQLSelect = 'SELECT * FROM ORDCOL      ' +
                  ' WHERE                      ' +
                  '   ORD_CODEMP = :CODEMP     ' +
                  '   AND ORD_NOMFOR = :NOMFOR ' +
                  '   AND ORD_CODOPE = :CODOPE ' +
                  '   AND ORD_NOMGRD = :NOMGRD ' +
                  ' ORDER BY ORD_ORDCAM ';
var
  qryOrd: TUniQuery;
begin
  Result.strDescFields := EmptyStr;
  Result.strFields := EmptyStr;

  qryOrd := fCriaQuery;
  Try
    qryOrd.DisableControls;
    qryOrd.Close;
    qryOrd.SQL.Clear;
    qryOrd.SQL.Add(SQLSelect);

    qryOrd.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryOrd.ParamByName('NOMFOR').AsString := FNomeFormulario;
    qryOrd.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryOrd.ParamByName('NOMGRD').AsString := strNomGrd;
    qryOrd.Open;

    If qryOrd.IsEmpty Then
      Exit;

    qryOrd.DisableControls;
    qryOrd.first;
    While Not qryOrd.eof do
    Begin
      If ((qryOrd.FieldByName('ORD_ORDDSC').AsString = 'S') And
         ((qryOrd.FieldByName('ORD_ORDNAM').AsString <> 'OCO_DTAAGE') Or
          (qryOrd.FieldByName('ORD_ORDNAM').AsString <> 'CLI_NOMCLI') Or
          (qryOrd.FieldByName('ORD_ORDNAM').AsString <> 'OCO_CODCLI'))) Then
      Begin
        If fEmptyStr(Result.strDescFields) Then
          Result.strDescFields := qryOrd.FieldByName('ORD_ORDNAM').AsString
        Else
          Result.strDescFields := Result.strFields + ';' + qryOrd.FieldByName('ORD_ORDNAM').AsString ;
      End;

      If fEmptyStr(Result.strFields) Then
        Result.strFields := qryOrd.FieldByName('ORD_ORDNAM').AsString
      Else
        Result.strFields := Result.strFields + ';' + qryOrd.FieldByName('ORD_ORDNAM').AsString ;

      qryOrd.Next;
    End;
    qryOrd.EnableControls;
  Finally
    FreeAndNil(qryOrd);
  End;
end;


End.
