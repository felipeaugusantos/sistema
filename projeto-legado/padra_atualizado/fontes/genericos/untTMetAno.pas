unit untTMetAno;

interface
{$M+}

uses Classes, DateUtils, Controls, SysUtils, Uni, strUtils, UniClientDataSet,
  untTypesSistema, untIMetAno, untInterfacedObjectNoCount;

type
  TMetAno = Class(TInterfacedObjectNoCount, IMetAno)
  private
    FAnoAtual: Integer;
    FMetaAno: Double;
    FLitrAno: Double;
    FMargemMensal: Double;
    FCodEmp: String;
    FDiasUteisAno: Double;
    FDiasUteisPeriodo: Double;
    FDtaIni: TDate;
    FDtaFin: TDate;
    FFeriados: TStringList;
    FMetaMeses: Array[0..11] Of TRecMes;
    FMesAtual: Integer;
    FFimDosMeses: Boolean;
    FGlobal: Boolean;
    FEmpOrigem: Boolean;
    FComCus : String;
    FMetaIncompleta: Boolean;
    FLitragemIncompleta: Boolean;
    function fGetMetaAno: Double;
    function fGetMesAtual: TRecMes;
    procedure pInicializar;
    procedure pCarregarFeriados;
    function fRetDiasUteis(dtaIni, dtaFin: TDate): Double;
    function fRetDiasUteisAno: Double;
    procedure pRetMetaRealizada(dtaIni, dtaFin: TDate; Out fltMeta, fltMargem, fltCusto, fltLitragem: Double);
    procedure pRetMetaRealizadaLitragem(dtaIni, dtaFin: TDate; Out fltLitragem: Double);
    procedure pAlimentarClient(CdsView: TUniClientDataSet);
    procedure pRetTotalMeta(strCodEmp, strAno: String; intMesIni, intMesFim: Integer; Out fltMeta, fltLitragem: Double);
    function fGetMargemMensal(strCodEmp, strAno: String; intMesIni, intMesFim: Integer): Double;
    function fGetSqlPesoLitroKilo(strCampo, strTipUni: String): String;
  public
    constructor Create(blnGlobal: Boolean = False; blnEmpOrigem: Boolean = False; strComCus: String = '');
    destructor Destroy; override;

    procedure pSetMes(intMes: Integer);

    procedure pCarregar(strAno: String; fltMeta, fltMarMes: Double; strCodEmp: String;
                        blnGravarMeta: Boolean; CdsView: TUniClientDataSet = Nil;
                        blnCarregarMeta : Boolean = False;
                        intMesIni: Integer = 1; intMesFim: Integer = 12;
                        blnRecalculaMetaProjetada: Boolean = True;
                        fltLitragem : Double = 0);

    procedure pSetaEmpOrigemCusto(blnEmpOrigem: Boolean; strComCus: String);

    procedure First;
    procedure Next;

    function fGetMes(intMes: Integer): TRecMes;
    function fGetDiasCorridos: Double;
    function fGetFimDosMeses: Boolean;
    function fGetFMargemMensal: Double;

    function fCalculaMargem(fltCusto, fltVenda: Double): Double;

    procedure pCalculaTotal(CdsView: TUniClientDataSet);
    procedure pAtualizaResult(CdsView: TUniClientDataSet);
    function fCarregouMetaEmpresa: Boolean;
    procedure pAtualizaVariaveis(CdsView: TUniClientDataSet);
    procedure pGravarMetaEmpresa;
    procedure pAtualizaMetaRealizada;
    function fGetSTR_TOTAL: String;
  published
    property MesAtual: TRecMes read fGetMesAtual;
    property MetaAno: Double read fGetMetaAno;
    property MargemMensal: Double read fGetFMargemMensal;
    property Eof: Boolean read fGetFimDosMeses;
    property blnMetaIncompleta: Boolean read FMetaIncompleta write FMetaIncompleta;
    property blnLitragemIncompleta: Boolean read FLitragemIncompleta write FLitragemIncompleta;
    property blnEmpOri: Boolean read FEmpOrigem write FEmpOrigem;
  end;

implementation

uses untFuncoesSimples, untConstantes, Data.DB, untFuncTinta;

{ TMetAno }

constructor TMetAno.Create(blnGlobal: Boolean = False; blnEmpOrigem: Boolean = False; strComCus: String = '');
begin
  FFeriados := TStringList.Create;
  FGlobal := blnGlobal;
  FEmpOrigem := blnEmpOrigem;
  FComCus := strComCus;
  FMetaIncompleta := False;
  FLitragemIncompleta := False;
end;

destructor TMetAno.Destroy;
begin
  FreeAndNil(FFeriados);
  inherited;
end;

function TMetAno.fCalculaMargem(fltCusto, fltVenda: Double): Double;
begin
  If Pos(fCfgSis('MARMKP'), '1_5_') > 0 Then
  Begin
    If fltVenda = 0 Then
      Result := 0
    Else
      Result := (1 - fltCusto / fltVenda) * 100;
  End
  Else
  Begin
    If fltCusto = 0 Then
      Result := 0
    Else
      Result := ((fltVenda / fltCusto) * 100) - 100;
  End;
end;

function TMetAno.fGetDiasCorridos: Double;
  Var
    dtaIni, dtaFin: TDate;
begin
  dtaIni := EncodeDate(FAnoAtual, FMesAtual, 01);
  dtaFin := IncDay(IncMonth(dtaIni), -1);
  
  Result := fRetDiasUteis(dtaIni, IIF(dtaFin < VS_Date, dtaFin, VS_Date));
end;

function TMetAno.fGetFimDosMeses: Boolean;
begin
  Result := FFimDosMeses;
end;

function TMetAno.fGetMargemMensal(strCodEmp, strAno: String;
  intMesIni, intMesFim: Integer): Double;
  Var
    qryMetas : TUniQuery;
begin
  qryMetas := fCriaQuery;

  With qryMetas Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT MET_MARMES AS MARMES ');
    SQL.Add('   FROM METEMP ');
    SQL.Add('  WHERE MET_CODEMP = :CODEMP ');
    SQL.Add('    AND MET_ANOMET = :ANOMET ');
    SQL.Add('    AND MET_INDICE BETWEEN :MESINI AND :MESFIM ');
    ParamByName('CODEMP').AsString  := strCodEmp;
    ParamByName('ANOMET').AsString  := strAno;
    ParamByName('MESINI').AsInteger := intMesIni;
    ParamByName('MESFIM').AsInteger := intMesFim;
    Open;
    Result := FieldByName('MARMES').AsFloat;
    Close;
  End;

  FreeAndNil(qryMetas);
end;

function TMetAno.fGetFMargemMensal: Double;
begin
  Result := FMargemMensal;
end;

function TMetAno.fGetMes(intMes: Integer): TRecMes;
begin
  If intMes < 1 Then
    intMes := 1;

  If intMes > 12 Then
    intMes := 12;
    
  Result := FMetaMeses[intMes -1];
end;

function TMetAno.fGetMesAtual: TRecMes;
begin
  Result := FMetaMeses[FMesAtual -1];
end;

function TMetAno.fGetMetaAno: Double;
begin
  Result := FMetaAno;
end;

function TMetAno.fGetSqlPesoLitroKilo(strCampo, strTipUni: String): String;
begin
  Result := ' IF(COALESCE(IF((TRIM(UNI_KILLIT)=""), NULL, UNI_KILLIT), "L") = "' + strTipUni + '", ' + strCampo + ', 0) ';
end;

function TMetAno.fGetSTR_TOTAL: String;
begin
  Result := 'TOTAL';
end;

procedure TMetAno.pRetTotalMeta(strCodEmp, strAno: String; intMesIni, intMesFim: Integer; Out fltMeta, fltLitragem: Double);
  Var
    qryMetas : TUniQuery;
begin
  qryMetas := fCriaQuery;

  With qryMetas Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT SUM(IFNULL(MET_METPRO,0)) AS METPRO, ');
    SQL.Add('        SUM(IFNULL(MET_LITPRO,0)) AS LITPRO  ');
    SQL.Add('   FROM METEMP ');
    SQL.Add('  WHERE MET_CODEMP = :CODEMP ');
    SQL.Add('    AND MET_ANOMET = :ANOMET ');
    SQL.Add('    AND MET_INDICE BETWEEN :MESINI AND :MESFIM ');
    ParamByName('CODEMP').AsString  := strCodEmp;
    ParamByName('ANOMET').AsString  := strAno;
    ParamByName('MESINI').AsInteger := intMesIni;
    ParamByName('MESFIM').AsInteger := intMesFim;
    Open;
    fltMeta := FieldByName('METPRO').AsFloat;
    fltLitragem := FieldByName('LITPRO').AsFloat;
    Close;
  End;

  FreeAndNil(qryMetas);
end;

procedure TMetAno.First;
begin
  pSetMes(1);
end;

procedure TMetAno.Next;
Begin
  pSetMes(FMesAtual + 1)
end;

procedure TMetAno.pAlimentarClient(CdsView: TUniClientDataSet);
begin
  FMetaIncompleta := False;
  FLitragemIncompleta := False;

  CdsView.DisableControls;

  CdsView.EmptyDataSet;
  While Not Eof Do
  Begin
    CdsView.Insert;
    CdsView.FieldByName('INDEX').AsInteger  := MesAtual.intMes;
    CdsView.FieldByName('DIAUTI').AsFloat   := MesAtual.fltDiasUteis;
    CdsView.FieldByName('MESANO').AsString  := MesAtual.strMesAno;
    CdsView.FieldByName('METDIA').AsFloat   := MesAtual.fltMetaProjetada / MesAtual.fltDiasUteis;
    CdsView.FieldByName('METPRO').AsFloat   := MesAtual.fltMetaProjetada;
    CdsView.FieldByName('METREA').AsFloat   := MesAtual.fltMetaRealizada;
    CdsView.FieldByName('RESULT').AsFloat   := MesAtual.fltResultado;
    CdsView.FieldByName('MARMES').AsFloat   := MesAtual.fltMargemProjetada;
    CdsView.FieldByName('MARREA').AsFloat   := MesAtual.fltMargemRealizada;
    CdsView.FieldByName('LITPRO').AsFloat   := MesAtual.fltLitragemProjetada;
    CdsView.FieldByName('LITREA').AsFloat   := MesAtual.fltLitragemRealizada;
    CdsView.Post;

    If (CdsView.FieldByName('INDEX').AsInteger = 12) Then
    Begin
      FMetaIncompleta := (fFormataFloat(CdsView.FieldByName('METREA').AsFloat, 2) = 0);
      FLitragemIncompleta := (fFormataFloat(CdsView.FieldByName('LITREA').AsFloat, 2) = 0);
    End;

    Next;
  End;
  pCalculaTotal(CdsView);

  CdsView.EnableControls;
end;

procedure TMetAno.pAtualizaMetaRealizada;
  Var
    intPosicao : Integer;
    dtaIni, dtaFin : TDate;
begin
  FMetaIncompleta := False;
  FLitragemIncompleta := False;

  For intPosicao := 1 To 12 Do
  Begin
    dtaIni := EncodeDate(FAnoAtual, intPosicao, 1);
    dtaFin := IncDay(IncMonth(dtaIni), -1);
    With FMetaMeses[intPosicao -1] Do
    Begin
      pRetMetaRealizada(dtaIni, dtaFin, fltMetaRealizada, fltMargemRealizada, fltCustoMes, fltLitragemRealizada);

      If (intPosicao = 12) Then
      Begin
        FMetaIncompleta := (fFormataFloat(fltMetaRealizada, 2) = 0);
        FLitragemIncompleta := (fFormataFloat(fltLitragemRealizada, 2) = 0);
      End;
    End;
  End;
end;

procedure TMetAno.pAtualizaResult(CdsView: TUniClientDataSet);
begin
  CdsView.First;
  While Not CdsView.Eof Do
  Begin
    If (CdsView.FieldByName('INDEX').AsInteger <> 13) Then
    Begin
      CdsView.Edit;
      If CdsView.FieldByName('METPRO').AsFloat < 0 Then
        CdsView.FieldByName('METPRO').AsFloat := 0;
      If CdsView.FieldByName('MARMES').AsFloat < 0 Then
        CdsView.FieldByName('MARMES').AsFloat := 0;
      CdsView.FieldByName('RESULT').AsFloat := (CdsView.FieldByName('METREA').AsFloat - CdsView.FieldByName('METPRO').AsFloat);
      If CdsView.FieldByName('DIAUTI').AsFloat > 0 Then
        CdsView.FieldByName('METDIA').AsFloat := (CdsView.FieldByName('METPRO').AsFloat / CdsView.FieldByName('DIAUTI').AsFloat)
      Else
        CdsView.FieldByName('METDIA').AsFloat := 0;
      CdsView.Post;
    End;
    CdsView.Next;
  End;
end;

procedure TMetAno.pAtualizaVariaveis(CdsView: TUniClientDataSet);
begin
  First;
  CdsView.First;
  While Not CdsView.Eof Do
  Begin
    If (CdsView.FieldByName('INDEX').AsInteger <> 13) Then
    Begin
      FMetaMeses[CdsView.RecNo -1].fltDiasUteis       := CdsView.FieldByName('DIAUTI').AsFloat;
      FMetaMeses[CdsView.RecNo -1].strMesAno          := CdsView.FieldByName('MESANO').AsString;
      FMetaMeses[CdsView.RecNo -1].fltMetaProjetada   := CdsView.FieldByName('METPRO').AsFloat;
      FMetaMeses[CdsView.RecNo -1].fltMetaRealizada   := CdsView.FieldByName('METREA').AsFloat;
      FMetaMeses[CdsView.RecNo -1].fltResultado       := CdsView.FieldByName('RESULT').AsFloat;
      FMetaMeses[CdsView.RecNo -1].fltMargemProjetada := CdsView.FieldByName('MARMES').AsFloat;
      FMetaMeses[CdsView.RecNo -1].fltMargemRealizada := CdsView.FieldByName('MARREA').AsFloat;
      FMetaMeses[CdsView.RecNo -1].fltMetaDiariaProjetada := CdsView.FieldByName('METDIA').AsFloat;
      FMetaMeses[CdsView.RecNo -1].fltLitragemProjetada := CdsView.FieldByName('LITPRO').AsFloat;
      FMetaMeses[CdsView.RecNo -1].fltLitragemRealizada := CdsView.FieldByName('LITREA').AsFloat;
    End;
    Next;
    CdsView.Next;
  End;
end;

procedure TMetAno.pCalculaTotal(CdsView: TUniClientDataSet);
  Var
    fltRealizado : Double;
    fltDiasUteis : Double;
    fltCustoTotal: Double;
    fltMetaDiariaProjetada : Double;
    fltMargemProjetada : Double;
    fltMetaProjetada : Double;
    fltMetaProjetadaInd : Double;
    fltLitrProjetadaInd : Double;
    fltResultMensal : Double;
    intRecNo : Integer;
    fltLitPro : Double;
    fltLitRea : Double;
begin
  fltRealizado := 0;
  fltDiasUteis := 0;
  fltCustoTotal:= 0;
  fltMetaDiariaProjetada := 0;
  fltMargemProjetada := 0;
  fltMetaProjetada := 0;
  fltResultMensal := 0;
  fltLitPro := 0;
  fltLitRea := 0;
  intRecNo := CdsView.RecNo;
  pAtualizaResult(CdsView);
  pAtualizaVariaveis(CdsView);

  First;
  While Not Eof Do
  Begin
    fltMargemProjetada := fltMargemProjetada + MesAtual.fltMargemProjetada;
    fltMetaDiariaProjetada  := fltMetaDiariaProjetada  + MesAtual.fltMetaDiariaProjetada;
    fltResultMensal := fltResultMensal + MesAtual.fltResultado;
    fltRealizado  := fltRealizado  + MesAtual.fltMetaRealizada;
    fltDiasUteis  := fltDiasUteis  + MesAtual.fltDiasUteis;
    fltCustoTotal := fltCustoTotal + MesAtual.fltCustoMes;

    fltLitRea := fltLitRea + MesAtual.fltLitragemRealizada;

    If FMetaIncompleta Then
    Begin
      fltMetaProjetadaInd := MesAtual.fltMetaRealizada;

      If (fFormataFloat(MesAtual.fltMetaProjetada, 0) <> 0) And
         (fFormataFloat(MesAtual.fltMetaRealizada, 0)  = 0) Then
        fltMetaProjetadaInd := fltMetaProjetadaInd + MesAtual.fltMetaProjetada;

      fltMetaProjetada := fltMetaProjetada + fltMetaProjetadaInd;
    End
    Else
      fltMetaProjetada := fltMetaProjetada + MesAtual.fltMetaProjetada;

    If FLitragemIncompleta Then
    Begin
      fltLitrProjetadaInd := MesAtual.fltLitragemRealizada;

      If (fFormataFloat(MesAtual.fltLitragemProjetada, 0) <> 0) And
         (fFormataFloat(MesAtual.fltLitragemRealizada, 0)  = 0) Then
        fltLitrProjetadaInd := fltLitrProjetadaInd + MesAtual.fltLitragemProjetada;

      fltLitPro := fltLitPro + fltLitrProjetadaInd;
    End
    Else
      fltLitPro := fltLitPro + MesAtual.fltLitragemProjetada;

    Next;
  End;

  If (fltMargemProjetada <> 0) Then
    fltMargemProjetada := fltMargemProjetada / 12;

  {******************************************************************************************}
  {* QUANDO A META ESTÁ COMPLETA O MEU TOTAL MUDA PARA:                                     *}
  {* ((TOTAL DA META REALIZADA) + (META PROJETADA DO MÊS 12)) - (META REALIZADA DO MÊS 12)  *}
  {***************************************************************************************RN*}
  If Not FMetaIncompleta Then
    fltMetaProjetada := fFormataFloat((fltRealizado + FMetaMeses[12 -1].fltMetaProjetada) - FMetaMeses[12 -1].fltMetaRealizada, 2);

  If Not FLitragemIncompleta Then
    fltLitPro := fFormataFloat((fltLitRea + FMetaMeses[12 -1].fltLitragemProjetada) - FMetaMeses[12 -1].fltLitragemRealizada, 2);

  If (Not CdsView.Locate('INDEX', 13, [])) Then
  Begin
    CdsView.Insert;
    CdsView.FieldByName('INDEX').AsInteger := 13;
  End
  Else
    CdsView.Edit;

  CdsView.FieldByName('METPRO').AsFloat   := fltMetaProjetada;
  //CdsView.FieldByName('METDIA').AsFloat   := fltMetaDiariaProjetada;
  CdsView.FieldByName('DIAUTI').AsFloat   := fltDiasUteis;
  CdsView.FieldByName('METREA').AsFloat   := fltRealizado;
  CdsView.FieldByName('MESANO').AsString  := fGetSTR_TOTAL;
  CdsView.FieldByName('MARMES').AsFloat   := fltMargemProjetada;
  CdsView.FieldByName('MARREA').AsFloat   := fCalculaMargem(fltCustoTotal, fltRealizado);
  CdsView.FieldByName('LITPRO').AsFloat   := fltLitPro;
  CdsView.FieldByName('LITREA').AsFloat   := fltLitRea;
  CdsView.FieldByName('RESULT').AsFloat   := CdsView.FieldByName('METREA').AsFloat - CdsView.FieldByName('METPRO').AsFloat;
  CdsView.Post;

  CdsView.RecNo := intRecNo;  
end;

procedure TMetAno.pCarregar(strAno: String; fltMeta, fltMarMes: Double; strCodEmp: String;
                        blnGravarMeta: Boolean; CdsView: TUniClientDataSet = Nil;
                        blnCarregarMeta : Boolean = False;
                        intMesIni: Integer = 1; intMesFim: Integer = 12;
                        blnRecalculaMetaProjetada: Boolean = True;
                        fltLitragem : Double = 0);
  Var
    intPosicao: Integer;
    fltDiasRestantes, fltTotalRealizado, fltTotLiRealizado: Double;
    dtaIni, dtaFin: TDate;
begin
  pInicializar;

  FAnoAtual := StrToIntDef(strAno, 0);
  FMetaAno := fltMeta;
  FLitrAno := fltLitragem;
  FMargemMensal := fltMarMes;

  If strCodEmp <> FCodEmp Then
    FFeriados.Clear;

  FCodEmp := strCodEmp;

  If FFeriados.Count <= 0 Then
    pCarregarFeriados;

  If (Length(strAno) <> 4) Or (StrToIntDef(strAno, 0) = 0) Then
    Raise Exception.Create('Ano digitado não é válido!');

  If (fltMeta <= 0) And (blnGravarMeta) Then
    Raise Exception.Create('Meta digitada não é válida!');

  If (fltLitragem <= 0) And (blnGravarMeta) And (VS_strUsaTmq = 'S') Then
    Raise Exception.Create('Litragem digitada não é válida!');

  If (Not blnCarregarMeta) And ((FMetaAno + FMargemMensal + FLitrAno) = 0) Then
  Begin
    pRetTotalMeta(FCodEmp, strAno, intMesIni, intMesFim, FMetaAno, FLitrAno);
    FMargemMensal := fGetMargemMensal(FCodEmp, strAno, intMesIni, intMesFim);
  End;

  If (blnCarregarMeta) And (fCarregouMetaEmpresa) Then
  Begin
    pSetMes(1);
    If CdsView <> Nil Then
      pAlimentarClient(CdsView);
    Exit;
  End;

  FDiasUteisAno := fRetDiasUteisAno;

  fltTotalRealizado := 0;
  fltTotLiRealizado := 0;
  fltDiasRestantes := IIF((intMesIni = intMesFim), fRetDiasUteis(EncodeDate(FAnoAtual, intMesIni, 1), IncDay(IncMonth(EncodeDate(FAnoAtual, intMesIni, 1)), -1)), FDiasUteisAno);

  For intPosicao := intMesIni To intMesFim Do
  Begin
    // Obtém primeiro dia do mês
    dtaIni := EncodeDate(FAnoAtual, intPosicao, 1);
    // Obtém último dia do mês
    dtaFin := IncDay(IncMonth(dtaIni), -1);

    With FMetaMeses[intPosicao -1] Do
    Begin
      intMes := intPosicao;
      // Dias úteis no mês
      fltDiasUteis := fRetDiasUteis(dtaIni, dtaFin);

      // Meta em Valor
      If (intPosicao > 1) And (FMetaMeses[intPosicao -2].fltMetaRealizada = 0) Then
      Begin
        If FMetaMeses[intPosicao -2].fltDiasUteis > 0 Then
          fltMetaProjetada := (FMetaMeses[intPosicao -2].fltMetaProjetada / FMetaMeses[intPosicao -2].fltDiasUteis) * fltDiasUteis;

        pRetMetaRealizada(dtaIni, dtaFin, fltMetaRealizada, fltMargemRealizada, fltCustoMes, fltLitragemRealizada);

        If fltMetaRealizada > 0 Then
          fltMetaProjetada := ((FMetaAno - fltTotalRealizado) / (fltDiasRestantes)) * fltDiasUteis;
      End
      Else
      Begin
        fltMetaProjetada     := ((FMetaAno - fltTotalRealizado) / (fltDiasRestantes)) * fltDiasUteis;
        pRetMetaRealizada(dtaIni, dtaFin, fltMetaRealizada, fltMargemRealizada, fltCustoMes, fltLitragemRealizada);
      End;

      // Meta em Litros
      If (intPosicao > 1) And (FMetaMeses[intPosicao -2].fltLitragemRealizada = 0) Then
      Begin
        If FMetaMeses[intPosicao -2].fltDiasUteis > 0 Then
          fltLitragemProjetada := (FMetaMeses[intPosicao -2].fltLitragemProjetada / FMetaMeses[intPosicao -2].fltDiasUteis) * fltDiasUteis;

        pRetMetaRealizadaLitragem(dtaIni, dtaFin, fltLitragemRealizada);

        If fltLitragemRealizada > 0 Then
          fltLitragemProjetada := ((FLitrAno - fltTotLiRealizado) / (fltDiasRestantes)) * fltDiasUteis;
      End
      Else
      Begin
        fltLitragemProjetada := ((FLitrAno - fltTotLiRealizado) / (fltDiasRestantes)) * fltDiasUteis;
        pRetMetaRealizadaLitragem(dtaIni, dtaFin, fltLitragemRealizada);
      End;

      If Not blnRecalculaMetaProjetada Then
        pRetTotalMeta(FCodEmp, strAno, intPosicao, intPosicao, fltMetaProjetada, fltLitragemProjetada);

      If (fFormataFloat(MargemMensal, 2) = 0) Then
        fltMargemProjetada := fGetMargemMensal(FCodEmp, strAno, intPosicao, intPosicao)
      Else
        fltMargemProjetada := MargemMensal;

      fltResultado := fltMetaProjetada - fltMetaRealizada;
      strMesAno    := String(arrMesAbr[intPosicao]) + '/' + IntToStr(FAnoAtual);
      strMesAnoNum := fStrZero(intPosicao, 2) + '/' + IntToStr(FAnoAtual);
      fltTotalRealizado := fltTotalRealizado + fltMetaRealizada;
      fltTotLiRealizado := fltTotLiRealizado + fltLitragemRealizada;

      // Se não teve nenhuma realização então não estava usando o autcom ainda
      If (fltTotalRealizado+fltTotLiRealizado) = 0 Then
      Begin
        fltMetaProjetada := 0;
        fltMetaRealizada := 0;
        fltMargemRealizada := 0;
        fltLitragemProjetada := 0;
        fltLitragemRealizada := 0;
        fltResultado := 0;
      End;

      fltDiasRestantes := fltDiasRestantes - fltDiasUteis;
    End;
  End;

  pSetMes(1);

  If CdsView <> Nil Then
    pAlimentarClient(CdsView);
end;

procedure TMetAno.pSetaEmpOrigemCusto(blnEmpOrigem: Boolean; strComCus: String);
begin
  FEmpOrigem := blnEmpOrigem;
  FComCus := strComCus;
end;

procedure TMetAno.pCarregarFeriados;
  Var
    qryFeriados: TUniQuery;
Begin
  qryFeriados := fCriaQuery;
  FFeriados.Clear;
  Try
    With qryFeriados, SQL Do
    Begin
      Add('SELECT FER_DTAFER AS DTAFER');
      Add('  FROM CADFER');
      Add('UNION ALL');
      Add('SELECT FCI_DTAFER AS DTAFER');
      Add('  FROM FERCID');
      Add(' WHERE FCI_CODCID = (SELECT EMP_CODCID');
      Add('                       FROM CADEMP');
      Add('                      WHERE EMP_CODEMP = :CODEMP)');

      ParamByName('CODEMP').AsString := FCodEmp;
      Open;

      While not Eof Do
      Begin
        FFeriados.Add(FormatDateTime('dd/mm/yyyy', FieldByName('DTAFER').AsDateTime));
        Next;
      End;
    End;
  Finally
    FreeAndNil(qryFeriados);
  End;
end;

procedure TMetAno.pGravarMetaEmpresa;
  Var
    qryInsert: TUniQuery;
    intCnt : Integer;
begin
  qryInsert := fCriaQuery;
  Try
    With qryInsert Do
    Begin
      SQL.Add(' SELECT * ');
      SQL.Add('   FROM METEMP ');
      SQL.Add('  WHERE MET_CODEMP = :CODEMP ');
      SQL.Add('    AND MET_ANOMET = :ANOMET');
      SQL.Add('    AND MET_MESANO = :MESANO ');
      ParamByName('CODEMP').AsString := FCodEmp;
      ParamByName('ANOMET').AsString := IntToStr(FAnoAtual);

      Self.First;
      For intCnt := 1 To 12 Do
      Begin
        Close;
        ParamByName('MESANO').AsString := MesAtual.strMesAno;
        Open;

        If IsEmpty Then
          Insert
        Else
          Edit;

        FieldByName('MET_INDICE').AsInteger:= MesAtual.intMes;
        FieldByName('MET_CODEMP').AsString := FCodEmp;
        FieldByName('MET_ANOMET').AsString := IntToStr(FAnoAtual);
        FieldByName('MET_MESANO').AsString := MesAtual.strMesAno;
        FieldByName('MET_DIAUTI').AsFloat  := MesAtual.fltDiasUteis;
        If MesAtual.fltDiasUteis > 0 Then 
          FieldByName('MET_METDIA').AsFloat  := MesAtual.fltMetaProjetada / MesAtual.fltDiasUteis
        Else
          FieldByName('MET_METDIA').AsFloat  := 0;
        FieldByName('MET_METPRO').AsFloat  := MesAtual.fltMetaProjetada;
        FieldByName('MET_METREA').AsFloat  := MesAtual.fltMetaRealizada;
        FieldByName('MET_RESULT').AsFloat  := MesAtual.fltResultado;
        FieldByName('MET_MARMES').AsFloat  := MesAtual.fltMargemProjetada;
        FieldByName('MET_MARREA').AsFloat  := MesAtual.fltMargemRealizada;
        FieldByName('MET_LITPRO').AsFloat := MesAtual.fltLitragemProjetada;

        Post;

        Self.Next;
      End;
       
    End;
  Finally
    FreeAndNil(qryInsert);
  End;
end;

procedure TMetAno.pInicializar;
begin
  FAnoAtual := 0;
  FMetaAno := 0;
  FLitrAno := 0;
  FMargemMensal := 0;
  FCodEmp := '';
  FDiasUteisAno := 0;
  FDiasUteisPeriodo := 0;
  FDtaIni := 0;
  FDtaFin := 0;
  pSetMes(1);
end;

function TMetAno.fCarregouMetaEmpresa: Boolean;
  Var
    qryInsert : TUniQuery;
    dtaIni : TDate;
    dtaFin : TDate;
begin
  qryInsert := fCriaQuery;
  Try
    With qryInsert Do
    Begin
      SQL.Add(' SELECT * ');
      SQL.Add('   FROM METEMP ');
      SQL.Add('  WHERE MET_CODEMP = :CODEMP ');
      SQL.Add('    AND MET_ANOMET = :ANOMET');
      SQL.Add('  ORDER BY MET_INDICE ');
      ParamByName('CODEMP').AsString := FCodEmp;
      ParamByName('ANOMET').AsString := IntToStr(FAnoAtual); 
      Open;
 
      If Not IsEmpty Then
      Begin
        Result := True;

        Self.First;

        First;
        While Not Eof Do
        Begin
          If RecNo > 12 Then
          Begin
            qryInsert.Next;
            Continue;
          End;

          // Obtém primeiro dia do mês
          dtaIni := EncodeDate(FAnoAtual, FieldByName('MET_INDICE').AsInteger, 1);
          // Obtém último dia do mês
          dtaFin := IncDay(IncMonth(dtaIni), -1);

          FMetaMeses[RecNo -1].intMes             := FieldByName('MET_INDICE').AsInteger;
          FMetaMeses[RecNo -1].fltDiasUteis       := fRetDiasUteis(dtaIni, dtaFin);
          FMetaMeses[RecNo -1].strMesAno          := FieldByName('MET_MESANO').AsString;
          FMetaMeses[RecNo -1].fltMetaProjetada   := FieldByName('MET_METPRO').AsFloat;
          //FMetaMeses[RecNo -1].fltMetaRealizada   := FieldByName('MET_METREA').AsFloat;
          FMetaMeses[RecNo -1].fltResultado       := FieldByName('MET_RESULT').AsFloat;
          FMetaMeses[RecNo -1].fltMargemProjetada := FieldByName('MET_MARMES').AsFloat;
          FMetaMeses[RecNo -1].fltLitragemProjetada := FieldByName('MET_LITPRO').AsFloat;
          //FMetaMeses[RecNo -1].fltMargemRealizada := FieldByName('MET_MARREA').AsFloat;

          Self.Next;
          qryInsert.Next;
        End;

        pAtualizaMetaRealizada;
      End
      Else
        Result := False;
    End;
  Finally
    FreeAndNil(qryInsert);
  End;
end;

procedure TMetAno.pSetMes(intMes: Integer);
begin
  FMesAtual := intMes;

  FFimDosMeses := intMes > 12;

  If FFimDosMeses Then
    FMesAtual := 12;
end;

function TMetAno.fRetDiasUteis(dtaIni, dtaFin: TDate): Double;
  Var
    dtaAtu: TDate;
begin
  Result := 0;
  dtaAtu := dtaIni;

  While dtaAtu <= dtaFin Do
  Begin
    If DayOfTheWeek(dtaAtu) < 7 Then // Verifica se considera o sábado (0, 0.5, 0.75, 1)
    Begin
      If FFeriados.IndexOf(FormatDateTime('dd/mm/yyyy', dtaAtu)) = -1 Then
      Begin
        If DayOfTheWeek(dtaAtu) = 6 Then
          Result := Result + fCfgSis('SABUTI', varDouble)
        Else
          Result := Result + 1;
      End;
    End
    Else If DayOfTheWeek(dtaAtu) = 7 Then // Verifica se considera o domingo (0, 0.5, 0.75, 1)
    Begin
      If FFeriados.IndexOf(FormatDateTime('dd/mm/yyyy', dtaAtu)) = -1 Then
        Result := Result + fCfgSis('DOMUTI', varDouble);
    End;

    dtaAtu := IncDay(dtaAtu, 1);
  End;
End;

function TMetAno.fRetDiasUteisAno: Double;
  Var
    dtaIni: TDate;
    dtaFin: TDate;
begin
  dtaIni := EncodeDate(FAnoAtual, 1, 1);
  dtaFin := EncodeDate(FAnoAtual, 12, 31);
  Result := fRetDiasUteis(dtaIni, dtaFin);
end;

procedure TMetAno.pRetMetaRealizada(dtaIni, dtaFin: TDate; Out fltMeta, fltMargem, fltCusto, fltLitragem: Double);
  Var
    qryMeta: TUniQuery;
    strSQL,
    strCampoCusto: String;
begin
  qryMeta := fCriaQuery;
  Try
    If fEmptyStr(FComCus) Then
      strCampoCusto := ' IFNULL(' + fRetornaComposicaoPadrao + ',0) '
    Else
      strCampoCusto := ' IFNULL(' + fRetornaComposicao(FComCus) + ',0) ';

    With qryMeta, SQL Do
    Begin
      Add('SELECT');
      Add('  SUM(IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS, '+ CLAFIS_BR +') > 0, 0, 1) * IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * (DET_TOTITE-DET_DESESP-DET_DESCFF)) AS TOTMET,');
      Add('  SUM(' + fGetSqlPesoLitroKilo('(IF(LEFT(DET_CLAFIS, 1) < 5, -(DET_QTDITE), DET_QTDITE) * ' + fStrRelFatorLit() + ')', 'L') + ') AS LITROS, ');
      Add('  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * ('+ strCampoCusto +')) AS CUSTO');
      Add('FROM');
      Add('  MOVDET');
      Add('  LEFT JOIN CADUNI ON UNI_CODUNI = DET_UNIDAD ');
      Add('  LEFT JOIN MOVTRI T ON T.DET_SEQGER = MOVDET.AUTOINCREM');
      Add('  LEFT JOIN MOVICD   ON   ICD_SEQGER = MOVDET.AUTOINCREM AND DET_VALRET = 0 ');

      Add('WHERE');
      Add('  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND');
      If FEmpOrigem Then
        Add('  T.DET_EMPORI = :CODEMP AND ')
      Else
        Add('  DET_CODEMP = :CODEMP AND');
      Add('  DET_PROEMB <> "S" AND');
      Add('  DET_TIP_FC = "C"  AND');
      Add(cnsFiltroFFDVTR);
      Add('  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND');
      Add('  ((LOCATE(DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)');
      If fCfgSis('ENTBRF', varBoolean) Then
        Add(' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) ')
      Else
        Add(')');

      If FGlobal Then
      Begin
        strSQL := Text;
        strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);
        Clear;
        Add('SELECT');
        Add('  SUM(TOTMET) AS TOTMET, ');
        Add('  SUM(LITROS) AS LITROS, ');
        Add('  SUM(CUSTO) AS CUSTO');
        Add('FROM');
        Add(' ('+ strSQL+') TAB ');
      End;

      ParamByName('DTAINI').AsDateTime := dtaIni;
      ParamByName('DTAFIN').AsDateTime := dtaFin;
      ParamByName('CODEMP').AsString   := FCodEmp;
      ParamByName('CLAVEN').AsString   := VS_strClaVen;
      ParamByName('CLADEV').AsString   := VS_strClaDev;

      If Params.FindParam('LITGAL') <> Nil Then
      Begin
        If SameText(fCfgSis('LITGAL'), 'L') Then
          ParamByName('LITGAL').AsFloat := 1
        Else
          ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
      End;

      Open;
      fltMeta := FieldByName('TOTMET').AsFloat;
      fltCusto := FieldByName('CUSTO').AsFloat;
      fltLitragem := FieldByName('LITROS').AsFloat;
      fltMargem := fCalculaMargem(fltCusto, fltMeta);
      Close;
    End;
  Finally
    FreeAndNil(qryMeta);
  End;
End;

procedure TMetAno.pRetMetaRealizadaLitragem(dtaIni, dtaFin: TDate;
  out fltLitragem: Double);
  Var
    fltMeta, fltMargem, fltCusto: Double;
begin
  pRetMetaRealizada(dtaIni, dtaFin, fltMeta, fltMargem, fltCusto, fltLitragem);
end;

end.
