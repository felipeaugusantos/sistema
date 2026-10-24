
{*************************************************************
*CLASSE PARA GRAVAÇÃO DAS TABELAS RETGER E RETDET            *
*RETGER = HEADER DO ARQUIVO (INFORMAÇÕES SOBRE O ARQUIVO)    *
*RETDET = DETALHE DO ARQUIVO (INFORMAÇÕES SOBRE OS REGITROS) *
************************************************MT*REQ:217604}
unit untTDetalhamentoRetorno;

interface

uses Windows, Forms, Classes, SysUtils, Uni, StrUtils, UniClientDataSet, Data.DB,Variants,
     untFuncoesSimples,System.Generics.Collections,cxProgressBar, untGravando;

Type
  TDadosDetalhe = Class
  Private
  Public
    AutoIncremRetGer: String;
    AutoIncremCadRec: String;
    NossoNumero: String;
    ValorPago: Double;
    ValorJuros: Double;
    ValorDesconto: Double;
    ValorTarifa: Double;
    DataPagamento: TDateTime;
    BancoRecebimento: String;
    AgenciaRecebimento: String;
    DataRetorno: TDateTime;
    OperadorRetorno: String;
    CodigoOcorrencia: String;
    Update: Boolean;
    CodigoEmpresa: String;

    CodigoBanco,
    Carteira,
    NomeArquivo: String;
    NumeroRemessa: Integer;
  End;

Type
  TDetalhamentoRetorno = Class(TComponent)
  Private
    LListaDetalhamento : TList<TDadosDetalhe>;
    qryRetGer: TUniQuery;
    qryRetDet: TUniQuery;

    function UpdateRetGer (ADetalhe: TDadosDetalhe): Boolean;
    function InsertRetGer (ADetalhe: TDadosDetalhe): Boolean;
    function InsertRetDet (ADetalhe: TDadosDetalhe): Boolean;
    function DeleteRetDet (ADetalhe: TDadosDetalhe): Boolean;

    function AddCampoSql(ACondicao:Boolean; Campo: String): String;
    procedure SetParams(ACondicao: Boolean; AParamByName: String; AValue: Variant );
    function RetornaSequencialRetGer(ADetalhe: TDadosDetalhe): String;
  Public
    function GravaDetalhamentoRetorno(pgbProgresso: TcxProgressBar): Boolean;
    procedure Add(ADetalhe: TDadosDetalhe);
    procedure Default(Var ADetalhe: TDadosDetalhe);
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

{ TDetalhamentoRetorno }

procedure TDetalhamentoRetorno.Add(ADetalhe: TDadosDetalhe);
begin
  LListaDetalhamento.Add(ADetalhe);
end;

procedure TDetalhamentoRetorno.Default(Var ADetalhe: TDadosDetalhe);
begin
  ADetalhe.AutoIncremCadRec   := '';
  ADetalhe.NossoNumero        := '' ;
  ADetalhe.ValorPago          := 0;
  ADetalhe.ValorJuros         := 0;
  ADetalhe.ValorDesconto      := 0;
  ADetalhe.ValorTarifa        := 0;
  ADetalhe.DataPagamento      := 0;
  ADetalhe.BancoRecebimento   := '';
  ADetalhe.AgenciaRecebimento := '';
  ADetalhe.DataRetorno        := 0;
  ADetalhe.OperadorRetorno    := '';
  ADetalhe.CodigoOcorrencia   := '';
  ADetalhe.Update             := False;
  ADetalhe.CodigoEmpresa      := '';
  ADetalhe.CodigoBanco        := '';
  ADetalhe.Carteira           := '';
  ADetalhe.NomeArquivo        := '';
  ADetalhe.NumeroRemessa      := 0;
  ADetalhe.Update             := False;
end;

function TDetalhamentoRetorno.AddCampoSql(ACondicao: Boolean;
  Campo: String): String;
begin
  If ACondicao Then
    Result := Campo
  Else
    Result := '';
end;

constructor TDetalhamentoRetorno.Create(Owner: TComponent);
begin
  inherited;
  LListaDetalhamento := TList<TDadosDetalhe>.Create;
  qryRetGer := fCriaQuery(Nil);
  qryRetDet := FCriaQuery(Nil)
end;

destructor TDetalhamentoRetorno.Destroy;
begin
  FreeAndNil(LListaDetalhamento);
  FreeAndNil(qryRetGer);
  FreeAndNil(qryRetDet);
  inherited;
end;

function TDetalhamentoRetorno.InsertRetDet(ADetalhe: TDadosDetalhe): Boolean;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + 'INSERT INTO RETDET ';
  strSQL := strSQL + '       (           ';
  strSQL := strSQL + '       DET_SEQGER, ';
  strSQL := strSQL + '       DET_NOSNUM, ';
  strSQL := strSQL + '       DET_DTACAD, ';
  strSQL := strSQL + '       DET_HORCAD, ';
  strSQL := strSQL + AddCampoSql((Not fEmptyStr(ADetalhe.AutoIncremCadRec)),'DET_DUPLIC, ');
  strSQL := strSQL + AddCampoSql((ADetalhe.ValorPago > 0),'DET_VALPAG, ');
  strSQL := strSQL + AddCampoSql((ADetalhe.ValorJuros > 0),'DET_VALJUR, ');
  strSQL := strSQL + AddCampoSql((ADetalhe.ValorDesconto > 0),'DET_VALDES, ');
  strSQL := strSQL + AddCampoSql((ADetalhe.ValorTarifa > 0),'DET_TARIFA, ');
  strSQL := strSQL + AddCampoSql((Not fEmptyStr(ADetalhe.BancoRecebimento)),'DET_BCOPAG, ');
  strSQL := strSQL + AddCampoSql((Not fEmptyStr(ADetalhe.AgenciaRecebimento)),'DET_AGEPAG, ');
  strSQL := strSQL + AddCampoSql((Not fEmptyStr(ADetalhe.OperadorRetorno)),'DET_OPERET, ');
  strSQL := strSQL + AddCampoSql((Not fEmptyStr(ADetalhe.CodigoOcorrencia)),'DET_CODOCO, ');
  strSQL := strSQL + AddCampoSql((ADetalhe.DataRetorno <> 0),'DET_DTARET, ');
  strSQL := strSQL + AddCampoSql((ADetalhe.DataPagamento <> 0),'DET_DTAPAG,');
  strSQL := strSQL + '       AUTOINCREM) ';
  strSQL := strSQL + '       VALUES (    ';
  strSQL := strSQL + '       :SEQGER,    ';
  strSQL := strSQL + '       :NOSNUM,    ';
  strSQL := strSQL + '       :DTACAD,    ';
  strSQL := strSQL + '       :HORCAD,    ';
  strSQL := strSQL + AddCampoSql((Not fEmptyStr(ADetalhe.AutoIncremCadRec)),':DUPLIC, ');
  strSQL := strSQL + AddCampoSql((ADetalhe.ValorPago > 0),':VALPAG, ');
  strSQL := strSQL + AddCampoSql((ADetalhe.ValorJuros > 0),':VALJUR, ');
  strSQL := strSQL + AddCampoSql((ADetalhe.ValorDesconto > 0),':VALDES, ');
  strSQL := strSQL + AddCampoSql((ADetalhe.ValorTarifa > 0),':TARIFA, ');
  strSQL := strSQL + AddCampoSql((Not fEmptyStr(ADetalhe.BancoRecebimento)),':BCOPAG, ');
  strSQL := strSQL + AddCampoSql((Not fEmptyStr(ADetalhe.AgenciaRecebimento)),':AGEPAG, ');
  strSQL := strSQL + AddCampoSql((Not fEmptyStr(ADetalhe.OperadorRetorno)),':OPERET, ');
  strSQL := strSQL + AddCampoSql((Not fEmptyStr(ADetalhe.CodigoOcorrencia)),':CODOCO, ');
  strSQL := strSQL + AddCampoSql((ADetalhe.DataRetorno <> 0),':DTARET, ');
  strSQL := strSQL + AddCampoSql((ADetalhe.DataPagamento <> 0),':DTAPAG,');
  strSQL := strSQL + '       :AUTOIN)    ';

  Try
    qryRetDet.Close;
    qryRetDet.SQL.Clear;
    qryRetDet.SQL.Add(strSQL);
    qryRetDet.ParamByName('AUTOIN').AsString   := fRetAutoIncrem('REMDET', VS_strCodEmp);
    qryRetDet.ParamByName('SEQGER').AsString   := RetornaSequencialRetGer(ADetalhe);
    qryRetDet.ParamByName('NOSNUM').AsString   := ADetalhe.NossoNumero;
    qryRetDet.ParamByName('DTACAD').AsDateTime := VS_Date;
    qryRetDet.ParamByName('HORCAD').AsTime     := fTime();

    SetParams((ADetalhe.DataPagamento <> 0),'DTAPAG',ADetalhe.DataPagamento);
    SetParams((Not fEmptyStr(ADetalhe.AutoIncremCadRec)),'DUPLIC',ADetalhe.AutoIncremCadRec);
    SetParams((ADetalhe.ValorPago > 0),'VALPAG',ADetalhe.ValorPago);
    SetParams((ADetalhe.ValorJuros > 0),'VALJUR',ADetalhe.ValorJuros);
    SetParams((ADetalhe.ValorDesconto > 0),'VALDES',ADetalhe.ValorDesconto);
    SetParams((ADetalhe.ValorTarifa > 0),'TARIFA',ADetalhe.ValorTarifa);
    SetParams((Not fEmptyStr(ADetalhe.BancoRecebimento)),'BCOPAG',ADetalhe.BancoRecebimento);
    SetParams((Not fEmptyStr(ADetalhe.AgenciaRecebimento)),'AGEPAG',ADetalhe.AgenciaRecebimento);
    SetParams((ADetalhe.DataRetorno <> 0),'DTARET',ADetalhe.DataRetorno);
    SetParams((Not fEmptyStr(ADetalhe.OperadorRetorno)),'OPERET',ADetalhe.OperadorRetorno);
    SetParams((Not fEmptyStr(ADetalhe.CodigoOcorrencia)),'CODOCO',ADetalhe.CodigoOcorrencia);

    qryRetDet.ExecSQL;
    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TDetalhamentoRetorno.InsertRetGer(ADetalhe: TDadosDetalhe): Boolean;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'INSERT INTO RETGER ';
  strSQL := strSQL + '       (           ';
  strSQL := strSQL + '       AUTOINCREM, ';
  strSQL := strSQL + '       GER_CODEMP, ';
  strSQL := strSQL + '       GER_CODBCO, ';
  strSQL := strSQL + '       GER_NOMARQ, ';
  strSQL := strSQL + '       GER_DTACAD, ';
  strSQL := strSQL + '       GER_HORCAD, ';
  strSQL := strSQL + '       GER_CARTEI) ';
  strSQL := strSQL + '       VALUES (    ';
  strSQL := strSQL + '       :AUTOIN,    ';
  strSQL := strSQL + '       :CODEMP,    ';
  strSQL := strSQL + '       :CODBCO,    ';
  strSQL := strSQL + '       :NOMARQ,    ';
  strSQL := strSQL + '       :DTACAD,    ';
  strSQL := strSQL + '       :HORCAD,    ';
  strSQL := strSQL + '       :CARTEI)    ';

  Try
    qryRetGer.Close;
    qryRetGer.SQL.Clear;
    qryRetGer.SQL.Add(strSQL);
    qryRetGer.ParamByName('AUTOIN').AsString   := fRetAutoIncrem('REMGER', ADetalhe.CodigoEmpresa);;
    qryRetGer.ParamByName('CODEMP').AsString   := ADetalhe.CodigoEmpresa;
    qryRetGer.ParamByName('CODBCO').AsString   := ADetalhe.CodigoBanco;
    qryRetGer.ParamByName('CARTEI').AsString   := ADetalhe.Carteira;
    qryRetGer.ParamByName('NOMARQ').AsString   := ADetalhe.NomeArquivo;
    qryRetGer.ParamByName('DTACAD').AsDateTime := VS_Date;
    qryRetGer.ParamByName('HORCAD').AsTime     := fTime();
    qryRetGer.ExecSQL;
    Result:= True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TDetalhamentoRetorno.RetornaSequencialRetGer(
  ADetalhe: TDadosDetalhe): String;
begin
  Result := '';
  Try
    qryRetGer.Close;
    qryRetGer.SQL.Clear;
    qryRetGer.SQL.Add('SELECT AUTOINCREM ');
    qryRetGer.SQL.Add('FROM RETGER ');
    qryRetGer.SQL.Add('WHERE GER_CARTEI = :CARTEI AND ');
    qryRetGer.SQL.Add('      GER_NOMARQ = :NOMARQ ');
    qryRetGer.ParamByName('CARTEI').AsString := ADetalhe.Carteira;
    qryRetGer.ParamByName('NOMARQ').AsString := ADetalhe.NomeArquivo;
    qryRetGer.Open;
    Result := qryRetGer.FieldByName('AUTOINCREM').AsString;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create (E.Message);
    End;
  End;
end;

procedure TDetalhamentoRetorno.SetParams(ACondicao: Boolean; AParamByName: String; AValue: Variant);
begin
  Try
    If ACondicao Then
      qryRetDet.ParamByName(AParamByName).Value := AValue;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TDetalhamentoRetorno.GravaDetalhamentoRetorno(pgbProgresso: TcxProgressBar): Boolean;
Var
  LDetalhe: TDadosDetalhe;
  LRetGer: Boolean;
  LInTransaction : Boolean;
begin
  Result := True;
  LInTransaction := False;
  Try
    LRetGer := True;
    LInTransaction := fInTransaction;

    If Not LInTransaction Then
      fStartTransaction;

    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := LListaDetalhamento.Count;

    For LDetalhe In LListaDetalhamento Do
    Begin
      pStepStatusGravacao(pgbProgresso, 'Aguarde... Gravando detalhamento arquivo Sicredi.');

      If LRetGer Then
      Begin

        If LDetalhe.Update then
          Result := UpdateRetGer(LDetalhe)
        Else
          Result := InsertRetGer(LDetalhe);

        DeleteRetDet(LDetalhe);
        LRetGer := False;
      End;

     Result := InsertRetDet(LDetalhe);
    End;

    If Not LInTransaction Then
      fCommit;
  Except
    On E: Exception Do
    Begin
      If Not LInTransaction Then
        fRollBack;
      pMensagensErro(E.Message, '[TDetalhamentoRetorno.GravaDetalhamentoRetorno]');
    End;
  End;

end;

function TDetalhamentoRetorno.DeleteRetDet(ADetalhe: TDadosDetalhe): Boolean;
begin
  Try
    qryRetDet.Close;
    qryRetDet.SQL.Clear;
    qryRetDet.SQL.Add('DELETE FROM RETDET WHERE DET_SEQGER = :SEQGER');
    qryRetDet.ParamByName('SEQGER').AsString := RetornaSequencialRetGer(ADetalhe);
    qryRetDet.ExecSQL;
    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TDetalhamentoRetorno.UpdateRetGer(ADetalhe: TDadosDetalhe): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'UPDATE RETGER SET ';
  strSQL := strSQL + '       GER_CODEMP = :CODEMP, ';
  strSQL := strSQL + '       GER_CODBCO = :CODBCO, ';
  strSQL := strSQL + '       GER_DTACAD = :DTACAD, ';
  strSQL := strSQL + '       GER_HORCAD = :HORCAD ';
  strSQL := strSQL + 'WHERE    ';
  strSQL := strSQL + '       GER_CARTEI = :CARTEI AND ';
  strSQL := strSQL + '       GER_NOMARQ = :NOMARQ ';

  Try
    qryRetGer.Close;
    qryRetGer.SQL.Clear;
    qryRetGer.SQL.Add(strSQL);
    qryRetGer.ParamByName('CODEMP').AsString   := ADetalhe.CodigoEmpresa;
    qryRetGer.ParamByName('CODBCO').AsString   := ADetalhe.CodigoBanco;
    qryRetGer.ParamByName('CARTEI').AsString   := ADetalhe.Carteira;
    qryRetGer.ParamByName('NOMARQ').AsString   := ADetalhe.NomeArquivo;
    qryRetGer.ParamByName('DTACAD').AsDateTime := VS_Date;
    qryRetGer.ParamByName('HORCAD').AsTime     := fTime();
    qryRetGer.ExecSQL;
    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

end.
