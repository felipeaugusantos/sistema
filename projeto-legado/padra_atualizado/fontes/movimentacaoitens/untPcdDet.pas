unit untPcdDet;

interface

uses SysUtils, Uni, untModuloGirIte;

{*******************************************}
{* REPRESENTA OS PEDIDOS MULTI-LOJA        *}
{****************************************MV*}
Type
  TPcdDet = class(TObject)

    private
      FNumPed: String;
      FCodEmp: String;
      FEspDoc: String;
      FSeqGer: String;
      FCodIte: String;
      FCodGru: String;
      FEmpDes: String;
      FQtdIte: Double;

      intQtdMes: Integer;
      qryPcdDet: TUniQuery;

      procedure pZeraValores;

    protected
      function getCodEmp: String;
      function getCodIte: String;
      function getCodGru: String;
      function getEmpDes: String;
      function getEspDoc: String;
      function getNumPed: String;
      function getQtdIte: Double;
      function getSeqGer: String;

      procedure setCodEmp(const Value: String);
      procedure setCodIte(const Value: String);
      procedure setCodGru(const Value: String);
      procedure setEmpDes(const Value: String);
      procedure setEspDoc(const Value: String);
      procedure setNumPed(const Value: String);
      procedure setQtdIte(const Value: Double);
      procedure setSeqGer(const Value: String);
    public

      objGiro: TGiroItem;

      Constructor Create; reintroduce; overload;
      Constructor Create(Const strNumPed, strCodEmp, strEspDoc, strSeqGer, strEmpDes,
        strCodIte, strCodGru: String; intQtdMes, intDiaCom: Integer;
        blnConsMCom, blnArredSug: Boolean; strDestino: String; fltQuantd: Double); overload;
      Destructor Destroy; override;

      procedure pInserePcdDet; overload;
      procedure pInserePcdDet(strCodEmp, strCodIte, strEmpDes,
        strEspDoc, strNumPed: String; fltQtdIte: Double; strSeqGer: String); overload;

      procedure pCalculaGiro(strCodIte, strCodEmp: String; intQtdMes, intDiaCom: Integer;
        blnConsMCom, blnArredSug: Boolean);

      procedure pSetaGiro(const fltMedia, fltSaldos, fltSujestao: Double;
                                strCodIte, strCodEmp: String;
                                intQtdMes: Integer;
                                qryTmpEmp: TUniQuery);

      class procedure pApagaPcdDet(Const strNumPed, strCodEmp, strEspDoc: String);

      property strNumPed: String Read getNumPed Write setNumPed;
      property strCodEmp: String Read getCodEmp Write setCodEmp;
      property strEspDoc: String Read getEspDoc Write setEspDoc;
      property strSeqGer: String Read getSeqGer Write setSeqGer;
      property strCodIte: String Read getCodIte Write setCodIte;
      property strCodGru: String Read getCodGru Write setCodGru;
      property strEmpDes: String Read getEmpDes Write setEmpDes;
      property fltQtdIte: Double Read getQtdIte Write setQtdIte;

  End;

implementation

uses untFuncoes, untfuncoesSimples;

{ TPcdDet }

{*******************************************}
{* CONSTRUTORES                            *}
{****************************************MV*}
constructor TPcdDet.Create;
begin
  inherited;
  objGiro   := NIL;
  qryPcdDet := fCriaQuery(Nil);
  pZeraValores;
end;

constructor TPcdDet.Create(const strNumPed, strCodEmp, strEspDoc, strSeqGer,
  strEmpDes, strCodIte, strCodGru: String; intQtdMes, intDiaCom: Integer;
  blnConsMCom, blnArredSug: Boolean; strDestino: String; fltQuantd: Double);
begin
  objGiro   := NIL;
  Self.intQtdMes := intQtdMes;
  qryPcdDet := fCriaQuery(Nil);

  FNumPed := strNumPed;
  FCodEmp := strCodEmp;
  FEspDoc := strEspDoc;
  FSeqGer := strSeqGer;
  FCodIte := strCodIte;
  FCodGru := strCodGru;
  FEmpDes := strDestino;
  FQtdIte := fltQuantd;

  objGiro := TGiroItem.Create(FCodIte, FCodEmp, intQtdMes, intDiaCom, blnConsMCom, blnArredSug);
  
end;

{*******************************************}
{* DESTRUTOR                               *}
{****************************************MV*}
destructor TPcdDet.Destroy;
begin
  If Assigned(objGiro) Then
    FreeAndNil(objGiro);
  qryPcdDet.Close;
  FreeAndNil(qryPcdDet);
  inherited;
end;

{*******************************************}
{* GETERS                                  *}
{****************************************MV*}
function TPcdDet.getCodEmp: String;
begin
  Result := FCodEmp;
end;

function TPcdDet.getCodGru: String;
begin
  Result := FCodGru;
end;

function TPcdDet.getCodIte: String;
begin
  Result := FCodIte;
end;

function TPcdDet.getEmpDes: String;
begin
  Result := FEmpDes;
end;

function TPcdDet.getEspDoc: String;
begin
  Result := FEspDoc;
end;

function TPcdDet.getNumPed: String;
begin
  Result := FNumPed;
end;

function TPcdDet.getQtdIte: Double;
begin
  Result := FQtdIte;
end;

function TPcdDet.getSeqGer: String;
begin
  Result := FSeqGer;
end;

{*******************************************}
{* INSERE NOVO REGISTRO                    *}
{****************************************MV*}
class procedure TPcdDet.pApagaPcdDet(const strNumPed, strCodEmp,
  strEspDoc: String);
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add('DELETE FROM PCDDET WHERE PCD_NUMPED = :NUMPED AND PCD_ESPDOC = :ESPDOC AND PCD_CODEMP = :CODEMP ');
  qryAux.ParamByName('NUMPED').AsString := strNumPed;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ExecSQL;
  qryAux.Close;
  FreeAndNil(qryAux);

end;

procedure TPcdDet.pCalculaGiro(strCodIte, strCodEmp: String;
  intQtdMes, intDiaCom: Integer;blnConsMCom, blnArredSug: Boolean);
begin
  objGiro := TGiroItem.Create(strCodIte, strCodEmp, intQtdMes, intDiaCom, blnConsMCom, blnArredSug);
end;

procedure TPcdDet.pSetaGiro(const fltMedia, fltSaldos, fltSujestao: Double;
                                  strCodIte, strCodEmp: String;
                                  intQtdMes: Integer;
                                  qryTmpEmp: TUniQuery);
begin
  objGiro := TGiroItem.Create(fltMedia, fltSaldos, fltSujestao, strCodIte, strCodEmp, intQtdMes, qryTmpEmp);
end;

procedure TPcdDet.pInserePcdDet(strCodEmp, strCodIte, strEmpDes,
  strEspDoc, strNumPed: String; fltQtdIte: Double; strSeqGer: String);
begin
  qryPcdDet.SQL.Clear;
  qryPcdDet.SQL.Add('REPLACE INTO PCDDET ');
  qryPcdDet.SQL.Add('(                   ');
  qryPcdDet.SQL.Add('PCD_NUMPED,         ');
  qryPcdDet.SQL.Add('PCD_CODEMP,         ');
  qryPcdDet.SQL.Add('PCD_ESPDOC,         ');
  qryPcdDet.SQL.Add('PCD_SEQGER,         ');
  qryPcdDet.SQL.Add('PCD_CODITE,         ');
  qryPcdDet.SQL.Add('PCD_EMPDES,         ');
  qryPcdDet.SQL.Add('PCD_QTDITE,         ');
  qryPcdDet.SQL.Add('AUTOINCREM          ');
  qryPcdDet.SQL.Add(') VALUES(           ');
  qryPcdDet.SQL.Add(':NUMPED,            ');
  qryPcdDet.SQL.Add(':CODEMP,            ');
  qryPcdDet.SQL.Add(':ESPDOC,            ');
  qryPcdDet.SQL.Add(':SEQGER,            ');
  qryPcdDet.SQL.Add(':CODITE,            ');
  qryPcdDet.SQL.Add(':EMPDES,            ');
  qryPcdDet.SQL.Add(':QTDITE,            ');
  qryPcdDet.SQL.Add(':AUTINC )           ');

  qryPcdDet.ParamByName('NUMPED').AsString := strNumPed;
  qryPcdDet.ParamByName('CODEMP').AsString := strCodEmp;
  qryPcdDet.ParamByName('ESPDOC').AsString := strEspDoc;
  qryPcdDet.ParamByName('SEQGER').AsString := strSeqGer;
  qryPcdDet.ParamByName('CODITE').AsString := strCodIte;
  qryPcdDet.ParamByName('EMPDES').AsString := strEmpDes;
  qryPcdDet.ParamByName('QTDITE').AsFloat  := fltQtdIte;
  qryPcdDet.ParamByName('AUTINC').AsString := fRetAutoIncrem('PCDDET', VS_strCodEmp);
  qryPcdDet.ExecSQL;
  qryPcdDet.Close;
end;

procedure TPcdDet.pInserePcdDet;
begin

  setCodEmp(FCodEmp);
  setCodIte(FCodIte);
  setCodGru(FCodGru);
  setEmpDes(FEmpDes);
  setEspDoc(FEspDoc);
  setNumPed(FNumPed);
  setQtdIte(FQtdIte);
  setSeqGer(FSeqGer);

  pInserePcdDet(FCodEmp, FCodIte, FCodGru, FEmpDes, FEspDoc, FNumPed, FQtdIte,
    FSeqGer);

end;

procedure TPcdDet.pZeraValores;
begin
  FNumPed := '';
  FCodEmp := '';
  FEspDoc := '';
  FSeqGer := '';
  FCodIte := '';
  FCodGru := '';
  FEmpDes := '';
  FQtdIte := 0.0;
end;

{*******************************************}
{* SETERS                                  *}
{****************************************MV*}
procedure TPcdDet.setCodEmp(const Value: String);
begin

  If (fEmptyStr(Value)) Then
    Raise Exception.Create('Empresa do pedido deve ser preenchida!');

  If (Value <> FCodEmp) Then
  Begin
    FCodEmp := Value;
  End;
end;

procedure TPcdDet.setCodGru(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise Exception.Create('Código do Grupo deve ser preenchido!');

  If (Value <> FCodGru) Then
  Begin
    FCodGru := Value;
  End;
end;

procedure TPcdDet.setCodIte(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise Exception.Create('Código do Item deve ser preenchido!');

  If (Value <> FCodIte) Then
  Begin
    FCodIte := Value;
  End;
end;

procedure TPcdDet.setEmpDes(const Value: String);
begin

  If (fEmptyStr(Value)) Then
    Raise Exception.Create('Empresa de destino deve ser preenchida!');

  If (Value <> FEmpDes) Then
  Begin
    FEmpDes := Value;
  End;
end;

procedure TPcdDet.setEspDoc(const Value: String);
begin

  If (fEmptyStr(Value)) Then
    Raise Exception.Create('Espécie do pedido deve ser preenchida!');

  If (Value <> FEspDoc) Then
  Begin
    FEspDoc := Value;
  End;
end;

procedure TPcdDet.setNumPed(const Value: String);
begin

  If (fEmptyStr(Value)) Then
    Raise Exception.Create('Pedido deve ser preenchido!');

  If (Value <> FNumPed) Then
  Begin
    FNumPed := Value;
  End;
end;

procedure TPcdDet.setQtdIte(const Value: Double);
begin

  If (Value < 0.0) Then
    Raise Exception.Create('Quantidade do item deve ser maior ou igual a Zero!');

  If (Value <> FQtdIte) Then
  Begin
    FQtdIte := Value;
  End;
end;

procedure TPcdDet.setSeqGer(const Value: String);
begin

  If (fEmptyStr(Value)) Then
    Raise Exception.Create('Sequencial do pedido deve ser preenchido!');

  If (Value <> FSeqGer) Then
  Begin
    FSeqGer := Value;
  End;
end;

end.

