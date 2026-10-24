unit untDocPDOR_Excel;

interface

Uses
  Variants, Classes, SysUtils, StrUtils, Controls, DB, UniClientDataSet, Forms,
  Uni, untZClient, untExcel, frxDBSet, untFuncoesEditorFast;

Type
  TDocPDOR_Excel = Class(TComponent)
  Private

    FArq_LayOut  : String;
    FExcel       : TExcel;
    FIsExcel     : Boolean;
    FCdsMestre   : TUniClientDataSet;
    FCdsDetalhe  : TUniClientDataSet;
    FCdsEmpresa  : TUniClientDataSet;
    FCdsCliente  : TUniClientDataSet;
    FCdsEndEnt   : TUniClientDataSet;
    FCdsOperador : TUniClientDataSet;

  Protected
    procedure pSetMestre(CDS : TDataSet);
    procedure pSetDetalhe(CDS : TDataSet);
    procedure pSetEmpresa(CDS : TDataSet);
    procedure pSetCliente(CDS : TDataSet);
    procedure pSetEndEnt(CDS : TDataSet);
    procedure pSetOperador(CDS : TDataSet);
    procedure pMontarCabecalhoRodape;
    procedure pMontarDetalhe;
  Public

    property strArq_LayOut : String read FArq_LayOut;
    property ObjExcel      : TExcel read FExcel write FExcel;

    constructor Create(Owner : TComponent); Override;
    Destructor  Destroy; Override;

    class function fUtilizaLayOutExcel : Boolean;

    procedure pSetDados(ArrClients : TArrClients);
    procedure pMontarPlanilha;

  End;

implementation

uses
  untFuncoesSimples;

{ TDocPDOR_Excel }

Const
  ARQ_LAYOUT_EXCEL = 'LAYOUT_EXCEL_PD_OR.xls';

constructor TDocPDOR_Excel.Create(Owner: TComponent);
begin

  inherited Create(Owner);

  objExcel := TExcel.fCriarExcel(Owner);

  If Assigned(objExcel) Then
    FIsExcel := objExcel.ClassNameIs('TExcelOfc');

  FArq_LayOut := ARQ_LAYOUT_EXCEL;

end;

destructor TDocPDOR_Excel.Destroy;
begin

  If Assigned(FExcel) Then
    FreeAndNil(FExcel);

  If Assigned(FCdsMestre) Then
    FreeAndNil(FCdsMestre);

  If Assigned(FCdsDetalhe) Then
    FreeAndNil(FCdsDetalhe);

  If Assigned(FCdsEmpresa) Then
    FreeAndNil(FCdsEmpresa);

  If Assigned(FCdsCliente) Then
    FreeAndNil(FCdsCliente);

  If Assigned(FCdsEndEnt) Then
    FreeAndNil(FCdsEndEnt);

  If Assigned(FCdsOperador) Then
    FreeAndNil(FCdsOperador);

  inherited Destroy;

end;

class function TDocPDOR_Excel.fUtilizaLayOutExcel: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + ARQ_LAYOUT_EXCEL);
end;

procedure TDocPDOR_Excel.pMontarCabecalhoRodape;
var
  i, intAvanca : Integer;
  strTexto     : Variant;
begin

  If Not FIsExcel Then
    intAvanca := 1
  Else
    intAvanca := 0;

  If Assigned(FCdsEmpresa) Then
  Begin
    FCdsEmpresa.First;
    If Not FCdsEmpresa.IsEmpty Then
    Begin
      For i := 0 To FCdsEmpresa.FieldCount -1 Do
      Begin
        {WHILE: Pois pode haver mais de uma ocorrência!}
        While FExcel.LocalizarCelula('{{' + FCdsEmpresa.Fields[i].FieldName + '}}', True) Do
        Begin

          FExcel.Escrever(FExcel.LinhaAtual + intAvanca,
                          FExcel.ColunaAtual,
                          FCdsEmpresa.Fields[i].Value,
                          False);
        End;
      End;
    End;
  End;

  If Assigned(FCdsMestre) Then
  Begin
    FCdsMestre.First;
    If Not FCdsMestre.IsEmpty Then
    Begin
      For i := 0 To FCdsMestre.FieldCount -1 Do
      Begin
        {WHILE: Pois pode haver mais de uma ocorrência!}
        While FExcel.LocalizarCelula('{{' + FCdsMestre.Fields[i].FieldName + '}}', True) Do
        Begin

          If FCdsMestre.Fields[i].FieldName = 'NUMDOC' Then
            strTexto := fStrZero(FCdsMestre.Fields[i].AsString, 12)
          Else
            strTexto := FCdsMestre.Fields[i].Value;

          If (FCdsMestre.Fields[i] Is TFloatField) Or (FCdsMestre.Fields[i] Is TCurrencyField) Then
          Begin

            FExcel.Escrever(FExcel.LinhaAtual + intAvanca,
                            FExcel.ColunaAtual,
                            strTexto,
                            True);

            {Formatação Numérica}
            FExcel.FormatoNumerico(FExcel.LinhaAtual + intAvanca, FExcel.ColunaAtual, '#.##0,00', True);

          End
          Else
          Begin
            FExcel.Escrever(FExcel.LinhaAtual + intAvanca,
                            FExcel.ColunaAtual,
                            strTexto,
                            False);
          End;

        End;
      End;
    End;
  End;

  If Assigned(FCdsCliente) Then
  Begin
    FCdsCliente.First;
    If Not FCdsCliente.IsEmpty Then
    Begin
      For i := 0 To FCdsCliente.FieldCount -1 Do
      Begin
        {WHILE: Pois pode haver mais de uma ocorrência!}
        While FExcel.LocalizarCelula('{{' + FCdsCliente.Fields[i].FieldName + '}}', True) Do
        Begin
          FExcel.Escrever(FExcel.LinhaAtual + intAvanca,
                          FExcel.ColunaAtual,
                          FCdsCliente.Fields[i].Value,
                          False);
        End;
      End;
    End;
  End;

  If Assigned(FCdsEndEnt) Then
  Begin
    FCdsEndEnt.First;
    If Not FCdsEndEnt.IsEmpty Then
    Begin
      For i := 0 To FCdsEndEnt.FieldCount -1 Do
      Begin
        {WHILE: Pois pode haver mais de uma ocorrência!}
        While FExcel.LocalizarCelula('{{' + FCdsEndEnt.Fields[i].FieldName + '}}', True) Do
        Begin
          FExcel.Escrever(FExcel.LinhaAtual + intAvanca,
                          FExcel.ColunaAtual,
                          FCdsEndEnt.Fields[i].Value,
                          False);
        End;
      End;
    End;
  End;

  If Assigned(FCdsOperador) Then
  Begin
    FCdsOperador.First;
    If Not FCdsOperador.IsEmpty Then
    Begin
      For i := 0 To FCdsOperador.FieldCount -1 Do
      Begin
        {WHILE: Pois pode haver mais de uma ocorrência!}
        While FExcel.LocalizarCelula('{{' + FCdsOperador.Fields[i].FieldName + '}}', True) Do
        Begin
          FExcel.Escrever(FExcel.LinhaAtual + intAvanca,
                          FExcel.ColunaAtual,
                          FCdsOperador.Fields[i].Value,
                          False);
        End;
      End;
    End;
  End;

end;

procedure TDocPDOR_Excel.pMontarDetalhe;
const
  POSICAO_INICIAL = '{{SEQDET}}';

var
  intColIni,
  intLinIni,
  intAvanca   : Integer;
  strTexto    : Variant;
  cdsPosicoes : TZClient;
  blnFloat    : Boolean;

  procedure pCriaDataSetPosicoes();
  Begin

    cdsPosicoes := TZClient.Create(Self);

    With cdsPosicoes.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'VAR';
      DataType := ftString;
      Size     := 20;
    End;

    With cdsPosicoes.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'COL';
      DataType := ftInteger;
    End;

    cdsPosicoes.CreateDataSet;
    cdsPosicoes.EmptyDataSet;

  End;

  procedure pGravaPosicao(strVar : String; intCol : Integer);
  Begin
    cdsPosicoes.Append;
    cdsPosicoes.FieldByName('VAR').AsString  := strVar;
    cdsPosicoes.FieldByName('COL').AsInteger := intCol;
    cdsPosicoes.Post;
  End;

  function fRetVal_CdsDetalhe(strVar : String; Out blnIsFloat : Boolean) : Variant;
  Var
    strField : String;
  Begin

    Result := '';

    strField := StringReplace(strVar, '{{', '', [rfReplaceAll]);
    strField := StringReplace(strField, '}}', '', [rfReplaceAll]);

    If (FCdsDetalhe.FindField(strField) <> Nil) Then
    Begin
      blnIsFloat := (FCdsDetalhe.FieldByName(strField) Is TFloatField) Or (FCdsDetalhe.FieldByName(strField) Is TCurrencyField);
      Result     := FCdsDetalhe.FieldByName(strField).Value;
    End;

  End;

begin

  {Localiza célula inicial}
  If FExcel.LocalizarCelula(POSICAO_INICIAL) Then
  Begin

    pCriaDataSetPosicoes;

    Try

      If Not FIsExcel Then
        intAvanca := 1
      Else
        intAvanca := 0;

      intColIni := FExcel.ColunaAtual;
      intLinIni := FExcel.LinhaAtual + intAvanca;

      pGravaPosicao(POSICAO_INICIAL, intColIni);
      intColIni := intColIni + intAvanca;
      FExcel.ColunaAtual := intColIni;

      {Grava posições em DataSet}
      While FExcel.Ler_Celula(fGetLetraAlfa(intColIni) + IntToStr(intLinIni)) <> '' Do
      Begin
        pGravaPosicao(FExcel.Ler_Celula(fGetLetraAlfa(intColIni) + IntToStr(intLinIni)), intColIni);
        intColIni := intColIni + 1;
        FExcel.ColunaAtual := intColIni;
      End;

      FCdsDetalhe.First;
      While Not FCdsDetalhe.Eof Do
      Begin

        cdsPosicoes.First;
        While Not cdsPosicoes.Eof Do
        Begin

          If cdsPosicoes.FieldByName('VAR').AsString = '{{CODITE}}' Then
          Begin
            strTexto := fStrZero(VarToString(fRetVal_CdsDetalhe(cdsPosicoes.FieldByName('VAR').AsString, blnFloat)), fTamCodIte);
            FExcel.Escrever(intLinIni, cdsPosicoes.FieldByName('COL').AsInteger, strTexto, False);
          End
          Else
          Begin

            strTexto := fRetVal_CdsDetalhe(cdsPosicoes.FieldByName('VAR').AsString, blnFloat);

            If (blnFloat) Then
            Begin

              FExcel.Escrever(intLinIni, cdsPosicoes.FieldByName('COL').AsInteger, strTexto, True);

              {Formatação Numérica}
              FExcel.FormatoNumerico(intLinIni, cdsPosicoes.FieldByName('COL').AsInteger, '#.##0,00', True);

            End
            Else
            Begin
              FExcel.Escrever(intLinIni, cdsPosicoes.FieldByName('COL').AsInteger, strTexto, False);
            End;

          End;

          FExcel.ColunaAtual := cdsPosicoes.FieldByName('COL').AsInteger;
          cdsPosicoes.Next;

        End;

        FCdsDetalhe.Next;
        intLinIni := intLinIni + 1;

        FExcel.ProximaLinha;
        FExcel.CriarNovaLinha;

      End;

    Finally
      FreeAndNil(cdsPosicoes);
    End;

  End;

end;

procedure TDocPDOR_Excel.pMontarPlanilha;
begin
  {Não inverter essa ordem:
   - 1º Detalhe
   - 2º Cabeçalho e Rodapé}
  pMontarDetalhe;
  pMontarCabecalhoRodape;
end;

procedure TDocPDOR_Excel.pSetCliente(CDS: TDataSet);
begin
  FCdsCliente := fCriaClientDatset(CDS, False, Self);
end;

procedure TDocPDOR_Excel.pSetDados(ArrClients: TArrClients);
var
  i : Integer;
begin

  For i := 0 To Length(ArrClients) -1 Do
  Begin

    If ArrClients[i].frxDados.Name = 'frxMovGer' Then
      pSetMestre(ArrClients[i].cdsDados);

    If ArrClients[i].frxDados.Name = 'frxMovdet' Then
      pSetDetalhe(ArrClients[i].cdsDados);

    If ArrClients[i].frxDados.Name = 'frxEmpresa' Then
      pSetEmpresa(ArrClients[i].cdsDados);

    If ArrClients[i].frxDados.Name = 'frxCliente' Then
      pSetCliente(ArrClients[i].cdsDados);

    If ArrClients[i].frxDados.Name = 'frxEndEnt' Then
      pSetEndEnt(ArrClients[i].cdsDados);

    If ArrClients[i].frxDados.Name = 'frxOperador' Then
      pSetOperador(ArrClients[i].cdsDados);

  End;

end;

procedure TDocPDOR_Excel.pSetDetalhe(CDS : TDataSet);
begin
  FCdsDetalhe := fCriaClientDatset(CDS, False, Self);
end;

procedure TDocPDOR_Excel.pSetEmpresa(CDS: TDataSet);
begin
  FCdsEmpresa := fCriaClientDatset(CDS, False, Self);
end;

procedure TDocPDOR_Excel.pSetEndEnt(CDS: TDataSet);
begin
  FCdsEndEnt := fCriaClientDatset(CDS, False, Self);
end;

procedure TDocPDOR_Excel.pSetMestre(CDS : TDataSet);
begin
  FCdsMestre := fCriaClientDatset(CDS, False, Self);
end;

procedure TDocPDOR_Excel.pSetOperador(CDS: TDataSet);
begin
  FCdsOperador := fCriaClientDatset(CDS, False, Self);
end;

end.
