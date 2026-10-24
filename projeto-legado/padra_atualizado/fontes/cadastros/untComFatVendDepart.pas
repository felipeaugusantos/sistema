unit untComFatVendDepart;

interface

uses StrUtils, SysUtils, Classes, Forms, DB, untFuncoesSimples, UniClientDataSet,
  UniDataSetProvider, Uni, Variants;

type TComFat = Class (TComponent)
  private
    FAutInc: String;
    FCodTab: String;
    FDescri: String;
    FCodDep: String;
    FFatIni: Double;
    FFatFin: Double;
    FPerCom: Double;

    function getFatFin: String;
    function getFatIni: String;
    function getCodDep: String;
    function getPerCom: String;

    procedure setCodTab(const Value: String);
    procedure setDescri(const Value: String);
    procedure setFatFin(const Value: String);
    procedure setFatIni(const Value: String);
    procedure setCodDep(const Value: String);
    procedure setPerCom(const Value: String);

    procedure pAfterOpenCab(Dataset: TDataSet);
    procedure pAfterOpenDet(Dataset: TDataSet);
  public
    qryDadCab: TUniQuery;
    cdsDadCab: TUniClientDataSet;
    cpvDadCab: TUniDataSetProvider;
    qryDadDet: TUniQuery;
    cdsDadDet: TUniClientDataSet;
    cpvDadDet: TUniDataSetProvider;
    qryTabela: TUniQuery;
    arrDefCam: TArrDefCam;

    property strAutInc: String Read FAutInc   Write FAutInc;
    property strCodTab: String Read FCodTab   Write setCodTab;
    property strDescri: String Read FDescri   Write setDescri;
    property strFatIni: String Read getFatIni Write setFatIni;
    property strFatFin: String Read getFatFin Write setFatFin;
    property strCodDep: String Read getCodDep Write setCodDep;
    property strPerCom: String Read getPerCom Write setPerCom;

    procedure pAtualizaDados;
    procedure pAtualizaTabela;
    procedure pDeletaRegistro;
    procedure pInsereDados;
    procedure pAtualizaRegistros;

    constructor Create(Owner: TComponent); Reintroduce;
  end;

const
  arrCampos   : array[0..5] of String     = ('COM_CODTAB','COM_DESCRI','COM_FATINI','COM_FATFIN','COM_CODEMP','AUTOINCREM');
  arrDescricao: array[0..5] of String     = ('Código','Descrição','Faturamento Inicial','Faturamento Final','Empresa','AUTOINCREM');
  arrTipo     : array[0..5] of TFieldType = (ftString,ftString,ftFloat,ftFloat,ftString,ftString);
  arrTamanhos : array[0..5] of Integer    = (6,50,0,0,3,20);
  arrVisible  : array[0..5] of Boolean    = (True,True,True,True,True,False);
  arrFormat   : array[0..5] of String     = ('','',',0.000',',0.000','','');

implementation

{ TComFat }

constructor TComFat.Create(Owner: TComponent);
  Var
    intContador: Integer;
begin
  Try
    SetLength(arrDefCam, 6);

    For intContador := 0 To Length(arrDefCam) - 1 Do
    Begin
      arrDefCam[intContador].strNomCam := arrCampos[intContador];
      arrDefCam[intContador].strDesCri := arrDescricao[intContador];
      arrDefCam[intContador].ftpTipCam := arrTipo[intContador];
      arrDefCam[intContador].intTamCam := arrTamanhos[intContador];
      arrDefCam[intContador].blnVisible:= arrVisible[intContador];
      arrDefCam[intContador].strFormat := arrFormat[intContador];
    End;

    qryTabela           := fCriaQuery(Self);
    qryTabela.AfterOpen := pAfterOpenCab;

    qryDadCab           := fCriaQuery(Self);
    cdsDadCab           := TUniClientDataSet.Create(Self);
    cpvDadCab           := TUniDataSetProvider.Create(Self);
    cpvDadCab.DataSet   := qryDadCab;
    cdsDadCab.AfterOpen := pAfterOpenCab;

    qryDadDet           := fCriaQuery(Self);
    cdsDadDet           := TUniClientDataSet.Create(Self);
    cpvDadDet           := TUniDataSetProvider.Create(Self);
    cpvDadDet.DataSet   := qryDadDet;
    cdsDadDet.AfterOpen := pAfterOpenDet;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM COMDEPG WHERE FALSE');
    qryTabela.Open;
    pAtualizaDados;

    FCodTab := '';
    FDescri := '';
    FCodDep := '';
    FFatIni := 0;
    FFatFin := 0;
    FPerCom := 0;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto ComFat!' + #13 + E.Message);
  End;
end;

function TComFat.getCodDep: String;
begin
  Result := FCodDep;
end;

function TComFat.getFatFin: String;
begin
  Result := FloatToStrF(FFatFin, ffNumber, 12, 3);
end;

function TComFat.getFatIni: String;
begin
  Result := FloatToStrF(FFatIni, ffNumber, 12, 3);
end;

function TComFat.getPerCom: String;
begin
  Result := FloatToStrF(FPerCom, ffNumber, 12, 2);
end;

procedure TComFat.pAfterOpenCab(Dataset: TDataSet);
begin
  TFloatField(Dataset.FieldByName('COM_FATINI')).DisplayFormat := ',0.000';
  TFloatField(Dataset.FieldByName('COM_FATFIN')).DisplayFormat := ',0.000';
end;

procedure TComFat.pAfterOpenDet(Dataset: TDataSet);
begin
  TFloatField(Dataset.FieldByName('COM_PERCOM')).DisplayFormat := ',0.000';
end;

procedure TComFat.pAtualizaDados;
begin
  With qryDadCab Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM COMDEPG WHERE COM_CODTAB = :CODTAB');
    ParamByName('CODTAB').AsString := qryTabela.FieldByName('COM_CODTAB').AsString;
    Open;

    pSetaClient(qryDadCab);

    cdsDadCab.Close;
    cdsDadCab.SetProvider(cpvDadCab);
    cdsDadCab.Open;

    If (Not cdsDadCab.IsEmpty) And (qryTabela.State = dsInsert) Then
    Begin
      qryTabela.FieldByName('COM_DESCRI').AsString := cdsDadCab.FieldByName('COM_DESCRI').AsString;
      qryTabela.FieldByName('COM_FATINI').AsFloat  := cdsDadCab.FieldByName('COM_FATINI').AsFloat;
      qryTabela.FieldByName('COM_FATFIN').AsFloat  := cdsDadCab.FieldByName('COM_FATFIN').AsFloat;
    End;
  End;
  With qryDadDet Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM COMDEPD WHERE COM_SEQCOM = :CODTAB');
    ParamByName('CODTAB').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    Open;

    pSetaClient(qryDadDet);

    cdsDadDet.Close;
    cdsDadDet.SetProvider(cpvDadDet);
    cdsDadDet.Open;
  End;
end;

procedure TComFat.pAtualizaRegistros;
begin
  Try
    With cdsDadCab Do
    Begin
      DisableControls;
      First;
      While Not Eof Do
      Begin
        Edit;
        FieldByName('COM_DESCRI').AsString := FDescri;
        FieldByName('COM_FATINI').AsFloat  := FFatIni;
        FieldByName('COM_FATFIN').AsFloat  := FFatFin;
        Post;
        Next;
      End;
    End;
  Finally
    cdsDadCab.EnableControls;
  End;
end;

procedure TComFat.pAtualizaTabela;
begin
  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM COMDEPG WHERE AUTOINCREM = :AUTINC');
    ParamByName('AUTINC').AsString := FAutInc;
    Open;
  End;
end;

procedure TComFat.pDeletaRegistro;
begin

end;

procedure TComFat.pInsereDados;
begin
  Try
    With cdsDadCab Do
    Begin
      Append;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMDEPG', VS_strCodEmp);
      FieldByName('COM_CODEMP').AsString := VS_strCodEmp;
      FieldByName('COM_CODTAB').AsString := FCodTab;
      FieldByName('COM_DESCRI').AsString := FDescri;
      FieldByName('COM_FATINI').AsFloat  := FFatIni;
      FieldByName('COM_FATFIN').AsFloat  := FFatFin;
      Post;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TComFat.setCodDep(const Value: String);
begin
  FCodDep := Value;
end;

procedure TComFat.setCodTab(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FCodTab := Value
  Else
    fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
end;

procedure TComFat.setDescri(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FDescri := Value
  Else
    fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
end;

procedure TComFat.setFatFin(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FFatFin := fStrToFloat(Value)
  Else
    fMensagem('ATENÇÃO!', 'O Faturamento Final deve ser preenchido!', ['&Ok']);
end;

procedure TComFat.setFatIni(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FFatIni := fStrToFloat(Value)
  Else
    fMensagem('ATENÇÃO!', 'O Faturamento Inicial deve ser preenchido!', ['&Ok']);
end;

procedure TComFat.setPerCom(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FPerCom := fStrToFloat(Value)
  Else
    fMensagem('ATENÇÃO!', 'O % de Comissão deve ser preenchido!', ['&Ok']);
end;

end.
