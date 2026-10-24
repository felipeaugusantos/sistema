{*********************************************************}
{* CLASSE PARA O CADASTRO DE PORTADORES                  *}
{*                                                       *}
{* DATA......: 27/04/2009                                *}
{* AUTOR.....: ELISSON ANTONIO MINCHIO                   *}
{*                                                       *}
{******************************************************EL*}
unit untCadPor;

interface

uses Classes, DB, untFuncoesSimples, Uni;

Type TCadPor = Class (TComponent)
  Private
    FCodPor: String;
    FNomPor: String;
    FDtaIni: TDateTime;
    FEntAna: String;
    FCtrAna: String;
    FCodEmp: String;
    FAutInc: String;
    FEntFlx: String;
    FEntPco: String;
    FDcrRec: Integer;
    FTraNsf: string;
    FConCon: String;
    FSigCon: String;
    FCodBco: String;

    function getDcrRec: String;
    function getDtaIni: string;

    procedure setDcrRec(const Value: String);
    procedure setDtaIni(const Value: string);
    procedure setNomPor(const Value: String);
    procedure setConCon(const Value: String);
    procedure setCodPor(const Value: String);
    procedure pAfterOpen(Dataset: TDataSet);
    procedure pAfterInsert(Dataset: TDataSet);
    procedure pAfterEdit(Dataset: TDataSet);
    procedure pSetaMascaraData(dtfData: TDateField);


  Public

    qryTabela: TUniQuery;
    arrDefCam: TArrDefCam;
    function fExisteConContabil: String;

    Property strCodPor: String Read FCodPor   Write setCodPor;
    Property strNomPor: String Read FNomPor   Write setNomPor;
    Property strDtaIni: string Read getDtaIni Write setDtaIni;
    Property strEntAna: String Read FEntAna   Write FEntAna;
    Property strCtrAna: String Read FCtrAna   Write FCtrAna;
    Property strCodEmp: String Read FCodEmp   Write FCodEmp;
    Property strAutInc: String Read FAutInc   Write FAutInc;
    Property strEntFlx: String Read FEntFlx   Write FEntFlx;
    Property strEntPco: String Read FEntPco   Write FEntPco;
    Property strDcrRec: String Read getDcrRec Write setDcrRec;
    Property strTraNsf: String Read FTraNsf   Write FTraNSF;
    Property strConCon: String Read FConCon   Write setConCon;
    Property strSigCon: String Read FSigCon   Write FSigCon;
    Property strCodBco: String Read FCodBco   Write FCodBco;

    Constructor Create(Owner: TComponent); Reintroduce;

  end;

Const
  arrCampos   : Array[0..12] Of String = ('POR_CODPOR','POR_NOMPOR','POR_DTAINI','POR_ENTANA','POR_CODEMP','POR_ENTFLX',
                                          'AUTOINCREM','POR_ENTPCO','POR_TRANSF','POR_DCRREC','POR_CONCON','POR_SIGCON',
                                          'POR_CODBCO');

  arrDescricao: Array[0..12] Of String = ('Código','Nome','Data Inicial','Entra na Análise','Código da Empresa','Fluxo de Caixa',
                                          'AUTOINCREM','Entra na Posição Contábil','Utilizado para Transferências',
                                          'POR_DCRREC','Conta Contábil','Sigla Contábil','Banco');

  arrTipo    : Array[0..13] Of TFieldType = (ftString,ftString,ftDate,ftFloat,ftString,ftString,ftString,ftString,ftString,ftString,ftInteger,ftString,ftString,ftString);
  arrTamanhos: Array[0..13] Of Integer    = (5,40,0,0,1,3,1,1,1,1,0,20,3,3);
  arrVisible : Array[0..13] Of Boolean    = (True,True,True,True,True,False,True,True,True,True,True,True,True,False);
  arrFormat  : Array[0..13] Of String     = ('','','99/99/9999;1;_','#,##0,00','','','','','','','','','','');

implementation

{ TCadPor }

uses SysUtils;

function TCadPor.getDcrRec: String;
begin
  Result := IntToStr(FDcrRec);
end;

function TCadPor.getDtaIni: string;
begin
  Result := FormatDateTime('dd/mm/yyyy',FDtaIni);
end;

procedure TCadPor.setDcrRec(const Value: String);
  begin

    If fEmptyStr(value) Then
    Begin
      FDcrRec := 0;
    End
    Else
    Begin

      If StrToIntDef(Value, -1) < 0 Then
        Raise Exception.Create('O campo "Dias para crédito do valor recebido" deve ser maior ou igual a Zero!')
      Else
        FDcrRec := StrToInt(Value);

    End;

end;

procedure TCadPor.setDtaIni(const Value: string);
begin

  If Not fEmptyStr(fTiraCaracEspeciais(Value)) Then
    FDtaIni := StrToDateTime(Value)
  Else
    Raise Exception.Create('A Data Inicial deve ser preenchida!');

end;

procedure TCadPor.setNomPor(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FNomPor := Value
  Else
    Raise Exception.Create('O Nome do Portador deve ser Preenchido!');

end;

constructor TCadPor.Create(Owner: TComponent);
  Var
    IntContador: Integer;
begin
  inherited;

  Try
    SetLength(arrDefCam,13);

    For intContador := 0 To Length(arrDefCam)-1 Do
    Begin
      arrDefCam[intContador].strNomCam := arrCampos[intContador];
      arrDefCam[intContador].strDesCri := arrDescricao[intContador];
      arrDefCam[intContador].ftpTipCam := arrTipo[intContador];
      arrDefCam[intContador].intTamCam := arrTamanhos[intContador];
      arrDefCam[intContador].blnVisible:= arrVisible[intContador];
      arrDefCam[intContador].strFormat := arrFormat[intContador];
    End;

    qryTabela := fCriaQuery(Self);
    qryTabela.AfterOpen   := pAfterOpen;
    qryTabela.AfterInsert := pAfterInsert;
    qryTabela.AfterEdit   := pAfterEdit;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM CADPOR WHERE FALSE');
    qryTabela.Open;
    
    FCodPor := '';
    FNomPor := '';
    FDtaIni := 0;
    FEntAna := '';
    FCtrAna := '';
    FCodEmp := '';
    FAutInc := '';
    FEntFlx := '';
    FEntPco := '';
    FDcrRec := 0;
    FTraNsf := '';
    FConCon := '';
    FCodBco := '';

  Except

    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto CadPor!' + #13 + E.Message);

  End;

end;

procedure TCadPor.pSetaMascaraData(dtfData: TDateField);
begin
  dtfData.EditMask := arrFormat[2];
end;

procedure TCadPor.pAfterOpen(Dataset: TDataSet);
begin
  pSetaMascaraData(TDateField(qryTabela.FieldByName('POR_DTAINI')));
end;

procedure TCadPor.pAfterEdit(Dataset: TDataSet);
begin
  pSetaMascaraData(TDateField(qryTabela.FieldByName('POR_DTAINI')));
end;

procedure TCadPor.pAfterInsert(Dataset: TDataSet);
begin
  pSetaMascaraData(TDateField(qryTabela.FieldByName('POR_DTAINI')));
end;

function TCadPor.fExisteConContabil: String;
  Var
    qryGenPor: TUniQuery;
begin
  Try

    If fEmptyStr(qryTabela.FieldByName('POR_CONCON').AsString) Then
    Begin
      Result := EmptyStr;
      Exit;
    End;

    qryGenPor := fCriaQuery;

    With qryGenPor Do
    Begin
      SQL.Add('SELECT');
      SQL.Add('  CONCAT(POR_CODPOR, "-", POR_NOMPOR) PORTADOR');
      SQL.Add('FROM');
      SQL.Add('  CADPOR');
      SQL.Add('WHERE');
      SQL.Add('  POR_CONCON  = :CONCON AND');
      SQL.Add('  POR_CODPOR <> :CODFOR    ');
      ParamByName('CONCON').Value := qryTabela.FieldByName('POR_CONCON').AsString;
      ParamByName('CODFOR').Value := qryTabela.FieldByName('POR_CODPOR').AsString;
      Open;

      Result := FieldByName('PORTADOR').AsString;

    End;

  Finally
    FreeAndNil(qryGenPor);
  End;

end;

procedure TCadPor.setConCon(const Value: String);
begin
  FConCon := Value;
end;

procedure TCadPor.setCodPor(const Value: String);
begin

  If fEmptyStr (Value) Then
    Raise Exception.Create('O Código do Portador deve ser preenchido!')
  Else
    FCodPor := Value;

end;

end.

