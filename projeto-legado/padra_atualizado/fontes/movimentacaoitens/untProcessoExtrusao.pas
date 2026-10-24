unit untProcessoExtrusao;

interface

uses
  Classes, SysUtils, System.StrUtils, DB, UniClientDataSet, Uni,
  untZClient, Variants, untFuncoesSimples;

 Type TObjProcessoExtrusao = Class


  private

    FTabela: String;

    camSEQGER,
    camAUTINC,
    camEXTS01,
    camEXTS02,
    camEXTS03,
    camNOMTER,
    camCODEMP:String;

    FCdsExtrusao: TUniClientDataSet;
    FDtsExtrusao: TDataSource;

  public

    procedure pDefineFieldsDataSetExtrusao;
    procedure pCarregaDadosExtrusao(strAutInc: String);
    procedure pLimpaDataSetProcessoExtrusao;
    procedure pGravaProcessoExtrusao(strAutInc: String);
    procedure pValidaCamposGridExtrusao;

    function fRetornaDataSourceProcessosExtrusao(blnInsert: Boolean = False): TDataSource;
    function fCamposExtrusaoPreenchidos: Boolean;

    constructor Create(strTabela: String);
    destructor Destroy; override;


End;

implementation

procedure TObjProcessoExtrusao.pDefineFieldsDataSetExtrusao;
begin
  If Not(AsSigned(FCdsExtrusao)) Then
  Begin
    FCdsExtrusao := TUniClientDataSet.Create(Nil);
    FDtsExtrusao := fCriaDataSource(FCdsExtrusao);

    FCdsExtrusao.FieldDefs.Add('AUTINC', ftString, 20);
    FCdsExtrusao.FieldDefs.Add('SEQGER', ftString, 20);
    FCdsExtrusao.FieldDefs.Add('NOMTER', ftString, 13);
    FCdsExtrusao.FieldDefs.Add('EXTS01', ftString, 13);
    FCdsExtrusao.FieldDefs.Add('EXTS02', ftString, 13);
    FCdsExtrusao.FieldDefs.Add('EXTS03', ftString, 13);

    FCdsExtrusao.CreateDataSet;
  End;
end;

function TObjProcessoExtrusao.fRetornaDataSourceProcessosExtrusao(blnInsert: Boolean = False): TDataSource;

CONST
  TERMOSTATO = 'TERMOSTATO';

  Var
  I: Integer;

begin

  I:= 4;

  if blnInsert then
    pLimpaDataSetProcessoExtrusao;


  If FcdsExtrusao.IsEmpty Then
  Begin
    for I := 0 to I - 1 do
    Begin
      FcdsExtrusao.Insert;
      FcdsExtrusao.FieldByName('NOMTER').AsString := 'TERMOSTATO 0'+intToStr(I+1);
      FcdsExtrusao.Post;
    End;
  End;

  FcdsExtrusao.IndexFieldNames:= 'NOMTER';

  FcdsExtrusao.First;

  Result:= FDtsExtrusao;

end;

procedure TObjProcessoExtrusao.pLimpaDataSetProcessoExtrusao;
begin
  FCdsExtrusao.EmptyDataSet;
end;

constructor TObjProcessoExtrusao.Create(strTabela: String);
begin

  pDefineFieldsDataSetExtrusao;

  FTabela:= strTabela;

  If fEmptyStr(FTabela) Then
  Begin
    pMensagemOk('Informe a Tabela que será utilizada na rotina!');
    Abort;
  End;

  If FTabela = 'GEIEXT' Then
  Begin
    camSEQGER:= 'GXT_SEQGMT';
    camAUTINC:= 'AUTOINCREM';
    camEXTS01:= 'GXT_EXTS01';
    camEXTS02:= 'GXT_EXTS02';
    camEXTS03:= 'GXT_EXTS03';
    camNOMTER:= 'GXT_NOMTER';
    camCODEMP:= 'GXT_CODEMP';
  End
  Else
  Begin
    camSEQGER:= 'EXT_SEQGER';
    camAUTINC:= 'AUTOINCREM';
    camEXTS01:= 'EXT_EXTS01';
    camEXTS02:= 'EXT_EXTS02';
    camEXTS03:= 'EXT_EXTS03';
    camNOMTER:= 'EXT_NOMTER';
    camCODEMP:= 'EXT_CODEMP';
  End;

end;

destructor TObjProcessoExtrusao.Destroy;
begin

  If FCdsExtrusao <> Nil Then
    FreeAndNil(FCdsExtrusao);

  inherited;
end;

function TObjProcessoExtrusao.fCamposExtrusaoPreenchidos: Boolean;
begin
  Result:= Not(fEmptyStr(FCdsExtrusao.FieldByName('NOMTER').AsString)) And
           Not(fEmptyStr(FCdsExtrusao.FieldByName('EXTS01').AsString)) And
           Not(fEmptyStr(FCdsExtrusao.FieldByName('EXTS02').AsString)) And
           Not(fEmptyStr(FCdsExtrusao.FieldByName('EXTS03').AsString));
end;

procedure TObjProcessoExtrusao.pGravaProcessoExtrusao(strAutInc: String);
var
  qryExtrusao: TUniQuery;
  FCdsTemp: TUniClientDataSet;
Begin

  Try
    If AsSigned(FCdsExtrusao) Then
    Begin
      FCdsExtrusao.First;
      qryExtrusao:= fCriaQuery();
      FCdsTemp    := TUniClientDataSet.Create(Nil);
      FCdsTemp.Data := FCdsExtrusao.Data;

      If fCamposExtrusaoPreenchidos Then
      Begin
        While Not FCdsExtrusao.Eof do
        Begin
          If fCamposExtrusaoPreenchidos Then
          Begin
            qryExtrusao.Close;
            qryExtrusao.SQL.Clear;
            qryExtrusao.SQL.Add(' INSERT INTO '+FTabela+' ('+camSEQGER+', '+
                                '                          '+camAUTINC+', '+
                                '                          '+camEXTS01+', '+
                                '                          '+camEXTS02+', '+
                                '                          '+camEXTS03+', '+
                                '                          '+camNOMTER+', '+
                                '                          '+camCODEMP+') '+
                                ' VALUES(                  :SEQGER,     '+
                                '                          :AUTINC,     '+
                                '                          :EXTS01,     '+
                                '                          :EXTS02,     '+
                                '                          :EXTS03,     '+
                                '                          :NOMTER,     '+
                                '                          :CODEMP)     ');
            qryExtrusao.ParamByName('SEQGER').AsString:=  strAutInc;
            qryExtrusao.ParamByName('AUTINC').AsString:=  fRetAutoIncrem(FTabela, VS_strCodEmp);
            qryExtrusao.ParamByName('NOMTER').AsString:=  FCdsExtrusao.FieldByName('NOMTER').AsString;

            qryExtrusao.ParamByName('EXTS01').Value   :=  AnsiReplaceStr(FCdsExtrusao.FieldByName('EXTS01').Value,',','.');
            qryExtrusao.ParamByName('EXTS02').Value   :=  AnsiReplaceStr(FCdsExtrusao.FieldByName('EXTS02').Value,',','.');
            qryExtrusao.ParamByName('EXTS03').Value   :=  AnsiReplaceStr(FCdsExtrusao.FieldByName('EXTS03').Value,',','.');
            qryExtrusao.ParamByName('CODEMP').AsString:=  VS_strCodEmp;

            qryExtrusao.ExecSQL;
          End;
          FCdsExtrusao.Next;
        End;

      End

    End;
  Finally
    FreeAndNil(qryExtrusao);
    FreeAndNil(FCdsTemp);
  End;

End;

procedure TObjProcessoExtrusao.pValidaCamposGridExtrusao;
Begin
  FCdsExtrusao.First;
  While Not(FCdsExtrusao.Eof) do
  Begin
    If ((fEmptyStr(FCdsExtrusao.FieldByName('EXTS01').AsString)) Or
        (fEmptyStr(FCdsExtrusao.FieldByName('EXTS02').AsString)) Or
        (fEmptyStr(FCdsExtrusao.FieldByName('EXTS03').AsString))) Then
    Begin
      Raise Exception.Create('Os Campos de termostato devem ser maior ou igual a zero');
      Break;
    End
    Else
    If ((FCdsExtrusao.FieldByName('EXTS01').Value < 0) Or
        (FCdsExtrusao.FieldByName('EXTS02').Value < 0) Or
        (FCdsExtrusao.FieldByName('EXTS03').Value < 0)) Then
    Begin
      Raise Exception.Create('Os Campos de termostato devem ser maior ou igual a zero');
      Break;
    End;
    FCdsExtrusao.Next;
  End;
End;

procedure TObjProcessoExtrusao.pCarregaDadosExtrusao(strAutInc: String);
var
  qryExt: TUniQuery;
Begin

  qryExt:= fCriaQuery();
  Try
    qryExt.Close;
    qryExt.SQL.Clear;
    qryExt.SQL.Add(' SELECT * FROM '+FTabela+' ');
    qryExt.SQL.Add(' WHERE '+camSEQGER+' = :SEQGER ');
    qryExt.ParamByName('SEQGER').AsString:= strAutInc;
    qryExt.Open;

    If Not(qryExt.IsEmpty) Then
      pLimpaDataSetProcessoExtrusao;

    qryExt.First;

    While Not(qryExt.eof) do
    Begin
      FCdsExtrusao.Insert;
      FCdsExtrusao.FieldByName('SEQGER').AsString:=  qryExt.FieldByName(camSEQGER).AsString;
      FCdsExtrusao.FieldByName('AUTINC').AsString:=  qryExt.FieldByName(camAUTINC).AsString;
      FCdsExtrusao.FieldByName('NOMTER').AsString:=  qryExt.FieldByName(camNOMTER).AsString;
      FCdsExtrusao.FieldByName('EXTS01').Value   :=  AnsiReplaceStr(qryExt.FieldByName(camEXTS01).Value,',','.');
      FCdsExtrusao.FieldByName('EXTS02').Value   :=  AnsiReplaceStr(qryExt.FieldByName(camEXTS02).Value,',','.');
      FCdsExtrusao.FieldByName('EXTS03').Value   :=  AnsiReplaceStr(qryExt.FieldByName(camEXTS03).Value,',','.');
      FCdsExtrusao.Post;

      qryExt.Next;
    End;

    FcdsExtrusao.IndexFieldNames:= 'NOMTER';

  Finally
    FreeAndNil(qryExt);
  End;

End;


end.
