unit untOpeEml;

interface

type
  TOpeEml = class
  private
    strCodOpe: String;
    strCodEmp: String;
    strE_Nome: String;
    strCodPrv: String;
    strE_Mail: String;
    strEmaLog: String;
    strPrvSen: String;
    strEmaAut: String;
    strImagem: String;
    strTexto_: String;
    strImgB64: String;

  public
    constructor Create(strCodOpe, strCodEmp, strE_Nome, strCodPrv,
      strE_Mail, strEmaLog, strPrvSen, strEmaAut, strImagem,
      strTexto_, strImgB64: String);

    function getCodOpe: String;
    function getCodEmp: String;
    function getE_Nome: String;
    function getCodPrv: String;
    function getE_Mail: String;
    function getEmaLog: String;
    function getPrvSen: String;
    function getEmaAut: String;
    function getImagem: String;
    function getTexto_: String;
    function getImgB64: String;

    procedure setCodOpe(const Value: String);
    procedure setCodEmp(const Value: String);
    procedure setE_Nome(const Value: String);
    procedure setCodPrv(const Value: String);
    procedure setE_Mail(const Value: String);
    procedure setEmaLog(const Value: String);
    procedure setPrvSen(const Value: String);
    procedure setEmaAut(const Value: String);
    procedure setImagem(const Value: String);
    procedure setTexto_(const Value: String);
    procedure setImgB64(const Value: String);
  end;

implementation

constructor TOpeEml.Create(strCodOpe, strCodEmp, strE_Nome, strCodPrv,
  strE_Mail, strEmaLog, strPrvSen, strEmaAut, strImagem,
  strTexto_, strImgB64: String);
begin
  Self.strCodOpe := strCodOpe;
  Self.strCodEmp := strCodEmp;
  Self.strE_Nome := strE_Nome;
  Self.strCodPrv := strCodPrv;
  Self.strE_Mail := strE_Mail;
  Self.strEmaLog := strEmaLog;
  Self.strPrvSen := strPrvSen;
  Self.strEmaAut := strEmaAut;
  Self.strImagem := strImagem;
  Self.strTexto_ := strTexto_;
  Self.strImgB64 := strImgB64;
end;

function TOpeEml.getCodOpe: String;
begin
  Result := strCodOpe;
end;

function TOpeEml.getCodEmp: String;
begin
  Result := strCodEmp;
end;

function TOpeEml.getE_Nome: String;
begin
  Result := strE_Nome;
end;

function TOpeEml.getCodPrv: String;
begin
  Result := strCodPrv;
end;

function TOpeEml.getE_Mail: String;
begin
  Result := strE_Mail;
end;

function TOpeEml.getEmaLog: String;
begin
  Result := strEmaLog;
end;

function TOpeEml.getPrvSen: String;
begin
  Result := strPrvSen;
end;

function TOpeEml.getEmaAut: String;
begin
  Result := strEmaAut;
end;

function TOpeEml.getImagem: String;
begin
  Result := strImagem;
end;

function TOpeEml.getTexto_: String;
begin
  Result := strTexto_;
end;

function TOpeEml.getImgB64: String;
begin
  Result := strImgB64;
end;

procedure TOpeEml.setCodOpe(const Value: String);
begin
  Self.strCodOpe := Value;
end;

procedure TOpeEml.setCodEmp(const Value: String);
begin
  Self.strCodEmp := Value;
end;

procedure TOpeEml.setE_Nome(const Value: String);
begin
  Self.strE_Nome := Value;
end;

procedure TOpeEml.setCodPrv(const Value: String);
begin
  Self.strCodPrv := Value;
end;

procedure TOpeEml.setE_Mail(const Value: String);
begin
  Self.strE_Mail := Value;
end;

procedure TOpeEml.setEmaLog(const Value: String);
begin
  Self.strEmaLog := Value;
end;

procedure TOpeEml.setPrvSen(const Value: String);
begin
  Self.strPrvSen := Value;
end;

procedure TOpeEml.setEmaAut(const Value: String);
begin
  Self.strEmaAut := Value;
end;

procedure TOpeEml.setImagem(const Value: String);
begin
  Self.strImagem := Value;
end;

procedure TOpeEml.setTexto_(const Value: String);
begin
  Self.strTexto_ := Value;
end;

procedure TOpeEml.setImgB64(const Value: String);
begin
  Self.strImgB64 := Value;
end;

end.

