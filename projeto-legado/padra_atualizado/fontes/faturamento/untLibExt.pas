unit untLibExt;

interface

uses Uni, Contnrs, Classes;

Type

  TLibExt = class(TComponent)
    private
      FAutoincrem : String;
      FNumDoc     : String;
      FEspDoc     : String;
      FCodEmp     : String;

      {Liberação}
      FOpeLib     : String;
      FDtaLib     : TDate;
      FHraLib     : TTime;
      FMotLib     : String;

      {Liberado (S/N)}
      FLibPok     : String;

      {Bloqueio}
      FOpeBlo     : String;
      FDtaBlo     : TDate;
      FHraBlo     : TTime;
      FMotBlo     : String;
      FOndBlo     : Boolean;
    protected
      function fInsereRegLib_Default(strNumDoc_,
                                     strEspDoc_,
                                     strCodEmp_ : String) : String;
    public

      Constructor Create(AOwner          : TComponent;
                         strNumDoc_,
                         strEspDoc_,
                         strCodEmp_      : String;
                         blnInsereRegLib : Boolean = True); reintroduce; overload;

      Constructor Create(AOwner          : TComponent;
                         strNumPok       : String;
                         blnInsereRegLib : Boolean = True); reintroduce; overload;

      procedure pLiberar;
      procedure pBloquear;
      procedure pLimparLiberacao;

      procedure pExcluir;
      procedure pZeraValores;

      class function fPedidoTemOrigemExterna(strNumDoc_,
                                             strEspDoc_,
                                             strCodEmp_ : String) : Boolean;

      class function fPedidoDeOrigemExternaEstaLiberado(strNumDoc_,
                                                        strEspDoc_,
                                                        strCodEmp_ : String) : Boolean;

      property strAutoincrem : String Read FAutoincrem Write FAutoincrem;
      property strNumDoc     : String Read FNumDoc     Write FNumDoc;
      property strEspDoc     : String Read FEspDoc     Write FEspDoc;
      property strCodEmp     : String Read FCodEmp     Write FCodEmp;
      property strOpeLib     : String Read FOpeLib     Write FOpeLib;
      property dtaDtaLib     : TDate  Read FDtaLib     Write FDtaLib;
      property hraHraLib     : TTime  Read FHraLib     Write FHraLib;
      property strMotLib     : String Read FMotLib     Write FMotLib;
      property strLibPok     : String Read FLibPok     Write FLibPok;
      property strOpeBlo     : String Read FOpeBlo     Write FOpeBlo;
      property dtaDtaBlo     : TDate  Read FDtaBlo     Write FDtaBlo;
      property hraHraBlo     : TTime  Read FHraBlo     Write FHraBlo;
      property strMotBlo     : String Read FMotBlo     Write FMotBlo;
      property blnOndBlo     : Boolean Read FOndBlo    Write FOndBlo;

  End;


implementation

uses
  SysUtils, untConstantes, untFuncoesSimples, Data.DB, untFuncoes;

{ TLibExt }

Constructor TLibExt.Create(AOwner          : TComponent;
                           strNumDoc_,
                           strEspDoc_,
                           strCodEmp_      : String;
                           blnInsereRegLib : Boolean = True);
Var
  qryAux: TUniQuery;
begin

  inherited Create(AOwner);

  qryAux := fCriaQuery(nil);

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT                     ');
    qryAux.SQL.Add('  *                        ');
    qryAux.SQL.Add('FROM                       ');
    qryAux.SQL.Add('  LIBEXT                   ');
    qryAux.SQL.Add('WHERE                      ');
    qryAux.SQL.Add('  LEX_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  LEX_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  LEX_CODEMP = :CODEMP     ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc_;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc_;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp_;
    qryAux.Open;

    If (qryAux.IsEmpty) Then
    Begin

      pZeraValores;

      {Default}
      If (blnInsereRegLib) Then
      Begin
        FAutoincrem := fInsereRegLib_Default(strNumDoc_, strEspDoc_, strCodEmp_);
        FNumDoc     := strNumDoc_;
        FEspDoc     := strEspDoc_;
        FCodEmp     := strCodEmp_;
        FLibPok     := 'N';
      End;

    End
    Else
    Begin
      {Atualiza Fields}
      FAutoincrem := qryAux.FieldByName('AUTOINCREM').AsString;
      FNumDoc     := strNumDoc_;
      FEspDoc     := strEspDoc_;
      FCodEmp     := strCodEmp_;
      FOpeLib     := qryAux.FieldByName('LEX_OPELIB').AsString;
      FDtaLib     := qryAux.FieldByName('LEX_DTALIB').AsDateTime;
      FHraLib     := qryAux.FieldByName('LEX_HRALIB').AsDateTime;
      FMotLib     := qryAux.FieldByName('LEX_MOTLIB').AsString;
      FLibPok     := qryAux.FieldByName('LEX_LIBPOK').AsString;
      FOpeBlo     := qryAux.FieldByName('LEX_OPEBLO').AsString;
      FDtaBlo     := qryAux.FieldByName('LEX_DTABLO').AsDateTime;
      FHraBlo     := qryAux.FieldByName('LEX_HRABLO').AsDateTime;
      FMotBlo     := qryAux.FieldByName('LEX_MOTBLO').AsString;
      FOndBlo     := (qryAux.FieldByName('LEX_ONDBLO').AsString = 'S');
    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TLibExt.pExcluir;
Var
  qryAux: TUniQuery;
begin

  If fEmptyStr(FNumDoc) Or fEmptyStr(FEspDoc) Or fEmptyStr(FCodEmp) Then
    Exit;

  qryAux := fCriaQuery(nil);

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('DELETE FROM ');
    qryAux.SQL.Add('  LIBEXT    ');
    qryAux.SQL.Add('WHERE       ');
    qryAux.SQL.Add('  LEX_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  LEX_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  LEX_CODEMP = :CODEMP     ');

    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;

    qryAux.ExecSQL;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TLibExt.fInsereRegLib_Default(strNumDoc_, strEspDoc_, strCodEmp_: String) : String;
Var
  qryAux: TUniQuery;
begin

  Result := '';

  If fEmptyStr(strNumDoc_) Or fEmptyStr(strEspDoc_) Or fEmptyStr(strCodEmp_) Then
    Exit;

  qryAux := fCriaQuery(nil);

  Try

    qryAux.Close;
    qryAux.SQL.Clear;

    qryAux.SQL.Add('INSERT INTO LIBEXT (   ');
    qryAux.SQL.Add('  AUTOINCREM,          ');
    qryAux.SQL.Add('  LEX_NUMDOC,          ');
    qryAux.SQL.Add('  LEX_ESPDOC,          ');
    qryAux.SQL.Add('  LEX_CODEMP,          ');
    qryAux.SQL.Add('  LEX_OPELIB,          ');
    qryAux.SQL.Add('  LEX_DTALIB,          ');
    qryAux.SQL.Add('  LEX_HRALIB,          ');
    qryAux.SQL.Add('  LEX_MOTLIB,          ');
    qryAux.SQL.Add('  LEX_LIBPOK,          ');
    qryAux.SQL.Add('  LEX_OPEBLO,          ');
    qryAux.SQL.Add('  LEX_DTABLO,          ');
    qryAux.SQL.Add('  LEX_HRABLO,          ');
    qryAux.SQL.Add('  LEX_MOTBLO) VALUES ( ');
    qryAux.SQL.Add('  :AUTINC,             ');
    qryAux.SQL.Add('  :NUMDOC,             ');
    qryAux.SQL.Add('  :ESPDOC,             ');
    qryAux.SQL.Add('  :CODEMP,             ');
    qryAux.SQL.Add('  NULL,                ');
    qryAux.SQL.Add('  NULL,                ');
    qryAux.SQL.Add('  NULL,                ');
    qryAux.SQL.Add('  NULL,                ');
    qryAux.SQL.Add('  "N",                 ');
    qryAux.SQL.Add('  NULL,                ');
    qryAux.SQL.Add('  NULL,                ');
    qryAux.SQL.Add('  NULL,                ');
    qryAux.SQL.Add('  NULL)                ');

    qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('LIBEXT', VS_strCodEmp);
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc_;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc_;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp_;

    qryAux.ExecSQL;

    Result := qryAux.ParamByName('AUTINC').AsString;

  Finally
    FreeAndNil(qryAux);
  End;

end;

class function TLibExt.fPedidoDeOrigemExternaEstaLiberado(strNumDoc_,
                                                          strEspDoc_,
                                                          strCodEmp_: String): Boolean;
Var
  qryAux: TUniQuery;
begin

  Result := False;

  If fEmptyStr(strNumDoc_) Or fEmptyStr(strEspDoc_) Or fEmptyStr(strCodEmp_) Then
    Exit;

  qryAux := fCriaQuery(nil);

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT                     ');
    qryAux.SQL.Add('  LEX_LIBPOK               ');
    qryAux.SQL.Add('FROM                       ');
    qryAux.SQL.Add('  LIBEXT                   ');
    qryAux.SQL.Add('WHERE                      ');
    qryAux.SQL.Add('  LEX_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  LEX_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  LEX_CODEMP = :CODEMP     ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc_;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc_;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp_;

    qryAux.Open;

    {Não existe registro na "LIBEXT", já foi importado liberado!}
    If (qryAux.IsEmpty) Then
      Result := True
    Else
      Result := (qryAux.FieldByName('LEX_LIBPOK').AsString = 'S');

  Finally
    FreeAndNil(qryAux);
  End;

end;

class function TLibExt.fPedidoTemOrigemExterna(strNumDoc_,
                                               strEspDoc_,
                                               strCodEmp_: String): Boolean;
Var
  qryAux: TUniQuery;
begin

  Result := False;

  If fEmptyStr(strNumDoc_) Or fEmptyStr(strEspDoc_) Or fEmptyStr(strCodEmp_) Then
    Exit;

  qryAux := fCriaQuery(nil);

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT                     ');
    qryAux.SQL.Add('  *                        ');
    qryAux.SQL.Add('FROM                       ');
    qryAux.SQL.Add('  FATGOR                   ');
    qryAux.SQL.Add('LEFT JOIN LIBEXT ON LEX_NUMDOC = FGO_NUMDOC ');
    qryAux.SQL.Add('                AND LEX_ESPDOC = FGO_ESPDOC ');
    qryAux.SQL.Add('                AND LEX_CODEMP = FGO_CODEMP ');
    qryAux.SQL.Add('WHERE                      ');
    qryAux.SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  FGO_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  FGO_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  ((IFNULL(FGO_NUMPOK, "") <> "") OR (IFNULL(FGO_PEDSIT, "") <> "") OR (LEX_ONDBLO = "S")) ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc_;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc_;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp_;
    qryAux.Open;

    If (Not qryAux.IsEmpty) Then
      Result := True;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TLibExt.pLiberar;
Var
  qryAux: TUniQuery;
begin

  If fEmptyStr(FNumDoc) Or fEmptyStr(FEspDoc) Or fEmptyStr(FCodEmp) Then
    Exit;

  qryAux := fCriaQuery(nil);

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE   ');
    qryAux.SQL.Add('  LIBEXT ');
    qryAux.SQL.Add('SET      ');
    qryAux.SQL.Add('  LEX_OPELIB = :OPELIB, ');
    qryAux.SQL.Add('  LEX_DTALIB = :DTALIB, ');
    qryAux.SQL.Add('  LEX_HRALIB = :HRALIB, ');
    qryAux.SQL.Add('  LEX_MOTLIB = :MOTLIB, ');
    qryAux.SQL.Add('  LEX_LIBPOK = "S"      ');
    qryAux.SQL.Add('WHERE    ');
    qryAux.SQL.Add('  LEX_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  LEX_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  LEX_CODEMP = :CODEMP     ');

    qryAux.ParamByName('OPELIB').AsString := FOpeLib;
    qryAux.ParamByName('DTALIB').AsDate   := VS_Date;
    qryAux.ParamByName('HRALIB').AsTime   := fRetHoraServidor;
    qryAux.ParamByName('MOTLIB').AsString := FMotLib;

    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;

    qryAux.ExecSQL;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TLibExt.pLimparLiberacao;
Var
  qryAux: TUniQuery;
begin
  If fEmptyStr(FAutoincrem) Then
    Exit;

  qryAux := fCriaQuery(nil);

  Try
    qryAux.SQL.Add('UPDATE   ');
    qryAux.SQL.Add('  LIBEXT ');
    qryAux.SQL.Add('SET      ');
    qryAux.SQL.Add('  LEX_OPELIB = NULL, ');
    qryAux.SQL.Add('  LEX_DTALIB = NULL, ');
    qryAux.SQL.Add('  LEX_HRALIB = NULL, ');
    qryAux.SQL.Add('  LEX_MOTLIB = NULL  ');
    qryAux.SQL.Add('WHERE    ');
    qryAux.SQL.Add('  AUTOINCREM = :AUTINC ');

    qryAux.ParamByName('AUTINC').AsString := FAutoincrem;

    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

constructor TLibExt.Create(AOwner          : TComponent;
                           strNumPok       : String;
                           blnInsereRegLib : Boolean = True);
Var
  qryAux: TUniQuery;

  strNumDoc_,
  strEspDoc_,
  strCodEmp_ : String;

begin

  inherited Create(AOwner);

  qryAux := fCriaQuery(nil);

  Try

    {Localiza PD via NUMPOK}
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT                 ');
    qryAux.SQL.Add('  FGO_NUMDOC,          ');
    qryAux.SQL.Add('  FGO_ESPDOC,          ');
    qryAux.SQL.Add('  FGO_CODEMP           ');
    qryAux.SQL.Add('FROM                   ');
    qryAux.SQL.Add('  FATGOR               ');
    qryAux.SQL.Add('WHERE                  ');
    qryAux.SQL.Add('  FGO_NUMPOK = :NUMPOK ');

    qryAux.ParamByName('NUMPOK').AsString := strNumPok;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
    Begin

      strNumDoc_ := qryAux.FieldByName('FGO_NUMDOC').AsString;
      strEspDoc_ := qryAux.FieldByName('FGO_ESPDOC').AsString;
      strCodEmp_ := qryAux.FieldByName('FGO_CODEMP').AsString;

      {Verifica se já existe LIBEXT}
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT                     ');
      qryAux.SQL.Add('  *                        ');
      qryAux.SQL.Add('FROM                       ');
      qryAux.SQL.Add('  LIBEXT                   ');
      qryAux.SQL.Add('WHERE                      ');
      qryAux.SQL.Add('  LEX_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('  LEX_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('  LEX_CODEMP = :CODEMP     ');

      qryAux.ParamByName('NUMDOC').AsString := strNumDoc_;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc_;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp_;
      qryAux.Open;

    End;

    If (qryAux.IsEmpty) Then
    Begin

      pZeraValores;

      {Default}
      If (blnInsereRegLib) Then
      Begin
        FAutoincrem := fInsereRegLib_Default(strNumDoc_, strEspDoc_, strCodEmp_);
        FNumDoc     := strNumDoc_;
        FEspDoc     := strEspDoc_;
        FCodEmp     := strCodEmp_;
        FLibPok     := 'N';
      End;

    End
    Else
    Begin
      {Atualiza Fields}
      FAutoincrem := qryAux.FieldByName('AUTOINCREM').AsString;
      FNumDoc     := strNumDoc_;
      FEspDoc     := strEspDoc_;
      FCodEmp     := strCodEmp_;
      FOpeLib     := qryAux.FieldByName('LEX_OPELIB').AsString;
      FDtaLib     := qryAux.FieldByName('LEX_DTALIB').AsDateTime;
      FHraLib     := qryAux.FieldByName('LEX_HRALIB').AsDateTime;
      FMotLib     := qryAux.FieldByName('LEX_MOTLIB').AsString;
      FLibPok     := qryAux.FieldByName('LEX_LIBPOK').AsString;
      FOpeBlo     := qryAux.FieldByName('LEX_OPEBLO').AsString;
      FDtaBlo     := qryAux.FieldByName('LEX_DTABLO').AsDateTime;
      FHraBlo     := qryAux.FieldByName('LEX_HRABLO').AsDateTime;
      FMotBlo     := qryAux.FieldByName('LEX_MOTBLO').AsString;
      FOndBlo     := (qryAux.FieldByName('LEX_ONDBLO').AsString = 'S');
    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TLibExt.pBloquear;
Var
  qryAux: TUniQuery;
begin

  If fEmptyStr(FNumDoc) Or fEmptyStr(FEspDoc) Or fEmptyStr(FCodEmp) Then
    Exit;

  qryAux := fCriaQuery(nil);

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE   ');
    qryAux.SQL.Add('  LIBEXT ');
    qryAux.SQL.Add('SET      ');
    qryAux.SQL.Add('  LEX_OPEBLO = :OPEBLO, ');
    qryAux.SQL.Add('  LEX_DTABLO = :DTABLO, ');
    qryAux.SQL.Add('  LEX_HRABLO = :HRABLO, ');
    qryAux.SQL.Add('  LEX_MOTBLO = :MOTBLO, ');
    qryAux.SQL.Add('  LEX_ONDBLO = :ONDBLO, ');
    qryAux.SQL.Add('  LEX_LIBPOK = "N"      ');
    qryAux.SQL.Add('WHERE    ');
    qryAux.SQL.Add('  LEX_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  LEX_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  LEX_CODEMP = :CODEMP     ');

    qryAux.ParamByName('OPEBLO').AsString := FOpeBlo;
    qryAux.ParamByName('DTABLO').AsDate   := VS_Date;
    qryAux.ParamByName('HRABLO').AsTime   := fRetHoraServidor;
    qryAux.ParamByName('MOTBLO').AsString := FMotBlo;
    qryAux.ParamByName('ONDBLO').AsString := IIF(FOndBlo, 'S', 'N');

    qryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;

    qryAux.ExecSQL;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TLibExt.pZeraValores;
begin
  FAutoincrem := '';
  FNumDoc     := '';
  FEspDoc     := '';
  FCodEmp     := '';
  FOpeLib     := '';
  FDtaLib     :=  0;
  FHraLib     :=  0;
  FMotLib     := '';
  FLibPok     := '';
  FOpeBlo     := '';
  FDtaBlo     :=  0;
  FHraBlo     :=  0;
  FMotBlo     := '';
  FOndBlo     := False;
end;

end.
