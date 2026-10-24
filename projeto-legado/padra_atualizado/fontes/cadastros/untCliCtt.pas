unit untCliCtt;

interface

uses Uni, Contnrs, Classes, System.Variants;

{*******************************************}
{* CONTATOS DO CLIENTE                     *}
{****************************************JB*}
Type

    TCliCtt = class(TComponent)
      private
        FCodCli: String;
        FAutCtt: Boolean;
        FCpfCtt: String;
        FRg_Ctt: String;
        FNomCtt: String;
        FEndCtt: String;
        FBaiCtt: String;
        FCidCtt: String;
        FNomCid: String;
        FEstado: String;
        FTelCtt: String;
        FCelCtt: String;
        FFaxCtt: String;
        FDepCtt: String;
        FEmaCtt: String;
        FCgoCtt: String;
        FNomCgo: String;
        FDptCtt: String;
        FNomDpt: String;
        FNasCtt: TDateTime;
        FTfuCtt: String;
        FNomTfu: String;
        FHobCtt: String;
        FNomHob: String;
        FEscCtt: String;
        FNomEsc: String;
        FTemSeg: String;
        FTemEmp: String;
        FGmuCtt: String;
        FNomGmu: String;
        FEciCtt: String;
        FNomEci: String;
        FQtdFil: Integer;
        FCerCtt: String;
        FObsCtt: String;
        FIdCiDe: Extended;
        FAutoincrem: String;
        FExcluir: Boolean;
        FRamFon: String;
        FRamFax: String;

        qryCliCtt: TUniQuery;

        procedure pZeraValores;

      protected
        function getAutCtt: Boolean;
        function getCpfCtt: String;
        function getRg_Ctt: String;
        function getBaiCtt: String;
        function getCidCtt: String;
        function getCodCli: String;
        function getEmaCtt: String;
        function getEndCtt: String;
        function getNomCtt: String;
        function getTelCtt: String;
        function getCelCtt: String;
        function getFaxCtt: String;
        function getDepCtt: String;
        function getCgoCtt: String;
        function getDptCtt: String;
        function getNasCtt: TDateTime;
        function getTfuCtt: String;
        function getHobCtt: String;
        function getEscCtt: String;
        function getTemSeg: String;
        function getTemEmp: String;
        function getGmuCtt: String;
        function getEciCtt: String;
        function getQtdFil: Integer;
        function getCerCtt: String;
        function getObsCtt: String;
        function getIdCiDe: Extended;
        function getRamFon: String;
        function getRamFax: String;

        procedure setAutCtt(const Value: Boolean);
        procedure setCpfCtt(const Value: String);
        procedure setRg_Ctt(const Value: String);
        procedure setBaiCtt(const Value: String);
        procedure setCidCtt(const Value: String);
        procedure setCodCli(const Value: String);
        procedure setEmaCtt(const Value: String);
        procedure setEndCtt(const Value: String);
        procedure setNomCtt(const Value: String);
        procedure setTelCtt(const Value: String);
        procedure setCelCtt(const Value: String);
        procedure setFaxCtt(const Value: String);
        procedure setDepCtt(const Value: String);
        procedure setCgoCtt(const Value: String);
        procedure setDptCtt(const Value: String);
        procedure setNasCtt(const Value: TDateTime);
        procedure setTfuCtt(const Value: String);
        procedure setHobCtt(const Value: String);
        procedure setEscCtt(const Value: String);
        procedure setTemSeg(const Value: String);
        procedure setTemEmp(const Value: String);
        procedure setGmuCtt(const Value: String);
        procedure setEciCtt(const Value: String);
        procedure setQtdFil(const Value: Integer);
        procedure setCerCtt(const Value: String);
        procedure setObsCtt(const Value: String);
        procedure setIdCiDe(const Value: Extended);
        procedure setRamFon(const Value: String);
        procedure setRamFax(const Value: String);

      public

        Constructor Create(AOwner: TComponent); reintroduce; overload;
        Constructor Create(AOwner: TComponent; Const strCodCli, strAutInc: String; blnAutoIncNULL : Boolean = False); reintroduce; overload;
        Destructor Destroy; override;

        procedure pInsereCliCtt;
        procedure pExcluirCliCtt;
        class procedure pApagarCadCtt(const strCodCli: String);
        class function fRetContatos(const strCodCli: String; blnAutoIncNULL : Boolean = False): TObjectList;

        property strCodCli: String Read getCodCli Write setCodCli;
        property blnAutCtt: Boolean Read getAutCtt Write setAutCtt;
        property strCpfCtt: String Read getCpfCtt Write setCpfCtt;
        property strRg_Ctt: String Read getRg_Ctt Write setRg_Ctt;
        property strNomCtt: String Read getNomCtt Write setNomCtt;
        property strEndCtt: String Read getEndCtt Write setEndCtt;
        property strBaiCtt: String Read getBaiCtt Write setBaiCtt;
        property strCidCtt: String Read getCidCtt Write setCidCtt;
        property strNomCid: String Read FNomCid;
        property strEstado: String Read FEstado;
        property strTelCtt: String Read getTelCtt Write setTelCtt;
        property strCelCtt: String Read getCelCtt Write setCelCtt;
        property strFaxCtt: String Read getFaxCtt Write setFaxCtt;
        property strDepCtt: String Read getDepCtt Write setDepCtt;
        property strEmaCtt: String Read getEmaCtt Write setEmaCtt;
        property strCgoCtt: String Read getCgoCtt Write setCgoCtt;
        property strNomCgo: String Read FNomCgo;
        property strDptCtt: String Read getDptCtt Write setDptCtt;
        property strNomDpt: String Read FNomDpt;
        property dtNasCtt: TDateTime Read getNasCtt Write setNasCtt;
        property strTfuCtt: String Read getTfuCtt Write setTfuCtt;
        property strNomTfu: String Read FNomTfu;
        property strHobCtt: String Read getHobCtt Write setHobCtt;
        property strNomHob: String Read FNomHob;
        property strEscCtt: String Read getEscCtt Write setEscCtt;
        property strNomEsc: String Read FNomEsc;
        property strTemSeg: String Read getTemSeg Write setTemSeg;
        property strTemEmp: String Read getTemEmp Write setTemEmp;
        property strGmuCtt: String Read getGmuCtt Write setGmuCtt;
        property strNomGmu: String Read FNomGmu;
        property strEciCtt: String Read getEciCtt Write setEciCtt;
        property strNomEci: String Read FNomEci;
        property intQtdFil: Integer Read getQtdFil Write setQtdFil;
        property strCerCtt: String Read getCerCtt Write setCerCtt;
        property strObsCtt: String Read getObsCtt Write setObsCtt;
        property extIdCiDe: Extended Read getIdCiDe Write setIdCiDe;
        property blnExcluir: Boolean Read FExcluir Write FExcluir;
        property strAutoincrem: String Read FAutoincrem;
        property strRamFon: String Read getRamFon Write setRamFon;
        property strRamFax: String Read getRamFax Write setRamFax;

  End;

implementation

uses SysUtils, untConstantes, untFuncoesSimples, Data.DB, untFuncoes,
  untTypesSistema;

{ TCliCtt }

constructor TCliCtt.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  qryCliCtt := fCriaQuery(Self);
  pZeraValores;
end;

constructor TCliCtt.Create(AOwner: TComponent; const strCodCli, strAutInc: String; blnAutoIncNULL : Boolean = False);
  Var
    qryAux: TUniQuery;
begin
  inherited Create(AOwner);
  qryCliCtt := fCriaQuery(Self);

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT                                        ');
  qryAux.SQL.Add('  *                                           ');
  qryAux.SQL.Add('FROM                                          ');
  qryAux.SQL.Add('  CLICTT                                      ');
  qryAux.SQL.Add('  LEFT JOIN CADCID ON CID_CODCID = CLI_CIDCTT ');
  qryAux.SQL.Add('  LEFT JOIN CADCGO ON CGO_CODCGO = CLI_CGOCTT ');
  qryAux.SQL.Add('  LEFT JOIN CADDPT ON DPT_CODDPT = CLI_DPTCTT ');
  qryAux.SQL.Add('  LEFT JOIN CADTFU ON TFU_CODTFU = CLI_TFUCTT ');
  qryAux.SQL.Add('  LEFT JOIN CADHOB ON HOB_CODHOB = CLI_HOBCTT ');
  qryAux.SQL.Add('  LEFT JOIN CADESC ON ESC_CODESC = CLI_ESCCTT ');
  qryAux.SQL.Add('  LEFT JOIN CADGMU ON GMU_CODGMU = CLI_GMUCTT ');
  qryAux.SQL.Add('  LEFT JOIN CADECI ON ECI_CODECI = CLI_ECICTT ');

  qryAux.SQL.Add('WHERE                                    ');
  qryAux.SQL.Add('  CLI_CODCLI = :CODCLI AND               ');
  qryAux.SQL.Add('  CLICTT.AUTOINCREM = :AUTINC            ');

  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ParamByName('AUTINC').AsString := strAutInc;
  qryAux.Open;

  If (qryAux.IsEmpty) Then
  Begin
    pZeraValores;
  End
  Else
  Begin
    FCodCli := qryAux.FieldByName('CLI_CODCLI').AsString;
    FNomCtt := qryAux.FieldByName('CLI_NOMCTT').AsString;
    FCpfCtt := qryAux.FieldByName('CLI_NUMCPF').AsString;
    FRg_Ctt := qryAux.FieldByName('CLI_NUMR_G').AsString;
    FAutCtt := qryAux.FieldByName('CLI_AUTCTT').AsString = 'S';
    FEndCtt := qryAux.FieldByName('CLI_ENDCTT').AsString;
    FBaiCtt := qryAux.FieldByName('CLI_BAICTT').AsString;
    FCidCtt := qryAux.FieldByName('CLI_CIDCTT').AsString;
    FNomCid := qryAux.FieldByName('CID_NOMCID').AsString;
    FEstado := qryAux.FieldByName('CID_ESTADO').AsString;
    FTelCtt := qryAux.FieldByName('CLI_TELCTT').AsString;
    FCelCtt := qryAux.FieldByName('CLI_CELCTT').AsString;
    FFaxCtt := qryAux.FieldByName('CLI_FAXCTT').AsString;
    FDepCtt := qryAux.FieldByName('CLI_DEPCTT').AsString;
    FEmaCtt := qryAux.FieldByName('CLI_EMACTT').AsString;

    FCgoCtt := qryAux.FieldByName('CLI_CGOCTT').AsString;
    FNomCgo := qryAux.FieldByName('CGO_DESCGO').AsString;
    FDptCtt := qryAux.FieldByName('CLI_DPTCTT').AsString;
    FNomDpt := qryAux.FieldByName('DPT_DESDPT').AsString;
    FNasCtt := qryAux.FieldByName('CLI_NASCTT').AsDateTime;
    FTfuCtt := qryAux.FieldByName('CLI_TFUCTT').AsString;
    FNomTfu := qryAux.FieldByName('TFU_DESTFU').AsString;
    FHobCtt := qryAux.FieldByName('CLI_HOBCTT').AsString;
    FNomHob := qryAux.FieldByName('HOB_DESHOB').AsString;
    FEscCtt := qryAux.FieldByName('CLI_ESCCTT').AsString;
    FNomEsc := qryAux.FieldByName('ESC_DESESC').AsString;
    FTemSeg := qryAux.FieldByName('CLI_TEMSEG').AsString;
    FTemEmp := qryAux.FieldByName('CLI_TEMEMP').AsString;
    FGmuCtt := qryAux.FieldByName('CLI_GMUCTT').AsString;
    FNomGmu := qryAux.FieldByName('GMU_DESGMU').AsString;
    FEciCtt := qryAux.FieldByName('CLI_ECICTT').AsString;
    FNomEci := qryAux.FieldByName('ECI_DESECI').AsString;
    FQtdFil := qryAux.FieldByName('CLI_QTDFIL').AsInteger;
    FCerCtt := qryAux.FieldByName('CLI_CERCTT').AsString;
    FObsCtt := qryAux.FieldByName('CLI_OBSERV').AsString;
    FIdCiDe := qryAux.FieldByName('CLI_IDCIDE').AsExtended;
    FRamFon := qryAux.FieldByName('CLI_RAMFON').AsString;
    FRamFax := qryAux.FieldByName('CLI_RAMFAX').AsString;

    if not blnAutoIncNULL then
      Fautoincrem := qryAux.FieldByName('AUTOINCREM').AsString
    else
      Fautoincrem := '';

  End;
  FreeAndNil(qryAux);
end;

destructor TCliCtt.Destroy;
begin
  inherited;
end;

class function TCliCtt.fRetContatos(const strCodCli: String; blnAutoIncNULL : Boolean = False): TObjectList;
  Var
    qryAux: TUniQuery;
begin

  Result := TObjectList.Create(True);

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT AUTOINCREM FROM CLICTT WHERE CLI_CODCLI = :CODCLI ORDER BY CLI_NOMCTT');
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.Open;
  While (Not qryAux.Eof) Do
  Begin
    Result.Add(TCliCtt.Create(nil, strCodCli, qryAux.FieldByName('AUTOINCREM').AsString, blnAutoIncNULL));
    qryAux.Next;
  End;
  qryAux.Close;

  FreeAndNil(qryAux);

end;

function TCliCtt.getAutCtt: Boolean;
begin
  Result := FAutCtt;
end;

function TCliCtt.getBaiCtt: String;
begin
  Result := FBaiCtt;
end;

function TCliCtt.getCelCtt: String;
begin
  Result := FCelCtt;
end;

function TCliCtt.getCerCtt: String;
begin
  Result := FCerCtt;
end;

function TCliCtt.getCgoCtt: String;
begin
  Result := FCgoCtt;
end;

function TCliCtt.getCidCtt: String;
begin
  Result := FCidCtt;
end;

function TCliCtt.getCodCli: String;
begin
  Result := FCodCli;
end;

function TCliCtt.getCpfCtt: String;
begin
  Result := FCpfCtt;
end;

function TCliCtt.getEciCtt: String;
begin
  Result := FEciCtt;
end;

function TCliCtt.getEmaCtt: String;
begin
  Result := FEmaCtt;
end;

function TCliCtt.getEndCtt: String;
begin
  Result := FEndCtt;
end;

function TCliCtt.getEscCtt: String;
begin
  Result := FEscCtt;
end;

function TCliCtt.getNasCtt: TDateTime;
begin
  Result := FNasCtt;
end;

function TCliCtt.getNomCtt: String;
begin
  Result := FNomCtt;
end;

function TCliCtt.getObsCtt: String;
begin
  Result := FObsCtt;
end;

function TCliCtt.getQtdFil: Integer;
begin
  Result := FQtdFil;
end;

function TCliCtt.getRamFax: String;
begin
  Result := FRamFax;
end;

function TCliCtt.getRamFon: String;
begin
  Result := FRamFon;
end;

function TCliCtt.getRg_Ctt: String;
begin
  Result := FRg_Ctt;
end;

function TCliCtt.getTelCtt: String;
begin
  Result := FTelCtt;
end;

function TCliCtt.getTemEmp: String;
begin
  Result := FTemEmp;
end;

function TCliCtt.getTemSeg: String;
begin
  Result := FTemSeg;
end;

function TCliCtt.getTfuCtt: String;
begin
  Result := FTfuCtt;
end;

{function TCliCtt.getCelCtt: String;
begin
  Result := FCelCtt;
end;
}
function TCliCtt.getFaxCtt: String;
begin
  Result := FFaxCtt;
end;

function TCliCtt.getGmuCtt: String;
begin
  Result := FGmuCtt;
end;

function TCliCtt.getHobCtt: String;
begin
  Result := FHobCtt;
end;

function TCliCtt.getIdCiDe: Extended;
begin
  Result := FIdCiDe;
end;

function TCliCtt.getDepCtt: String;
begin
  Result := FDepCtt;
end;


function TCliCtt.getDptCtt: String;
begin
  Result := FDptCtt;
end;

class procedure TCliCtt.pApagarCadCtt(const strCodCli: String);
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('DELETE FROM CLICTT WHERE CLI_CODCLI = :CODCLI');
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ExecSQL;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

procedure TCliCtt.pExcluirCliCtt;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryCliCtt.SQL.Add('DELETE FROM CLICTT WHERE AUTOINCREM = :AUTOINCREM');
  qryCliCtt.ParamByName('AUTOINCREM').AsString := FAutoincrem;
  qryCliCtt.ExecSQL();
  qryCliCtt.Close();

  FreeAndNil(qryAux);
end;

procedure TCliCtt.pInsereCliCtt;
  Var
    blnEditar: Boolean;
begin
  qryCliCtt.Close();
  qryCliCtt.SQL.Clear();

  If (Not fEmptyStr(FAutoincrem)) Then Begin
    qryCliCtt.SQL.Add('SELECT * FROM CLICTT WHERE AUTOINCREM = :AUTOINCREM');
    qryCliCtt.ParamByName('AUTOINCREM').AsString := FAutoincrem;
    qryCliCtt.Open();

    blnEditar := (Not qryCliCtt.isEmpty);
  End Else
    blnEditar := False;

  qryCliCtt.Close();
  qryCliCtt.SQL.Clear();

  If (Not blnEditar) Then Begin
    qryCliCtt.SQL.Add('INSERT INTO CLICTT  ');
    qryCliCtt.SQL.Add('( CLI_CODCLI,       ');
    qryCliCtt.SQL.Add('  CLI_AUTCTT,       ');
    qryCliCtt.SQL.Add('  CLI_NUMCPF,       ');
    qryCliCtt.SQL.Add('  CLI_NUMR_G,       ');
    qryCliCtt.SQL.Add('  CLI_NOMCTT,       ');
    qryCliCtt.SQL.Add('  CLI_ENDCTT,       ');
    qryCliCtt.SQL.Add('  CLI_BAICTT,       ');
    qryCliCtt.SQL.Add('  CLI_CIDCTT,       ');
    qryCliCtt.SQL.Add('  CLI_TELCTT,       ');
    qryCliCtt.SQL.Add('  CLI_CELCTT,       ');
    qryCliCtt.SQL.Add('  CLI_FAXCTT,       ');
    qryCliCtt.SQL.Add('  CLI_DEPCTT,       ');
    qryCliCtt.SQL.Add('  CLI_EMACTT,       ');
    qryCliCtt.SQL.Add('  CLI_CODEMP,       ');
    qryCliCtt.SQL.Add('  AUTOINCREM,       ');
    qryCliCtt.SQL.Add('  CLI_CGOCTT,       ');
    qryCliCtt.SQL.Add('  CLI_DPTCTT,       ');
    qryCliCtt.SQL.Add('  CLI_NASCTT,       ');
    qryCliCtt.SQL.Add('  CLI_TFUCTT,       ');
    qryCliCtt.SQL.Add('  CLI_HOBCTT,       ');
    qryCliCtt.SQL.Add('  CLI_ESCCTT,       ');
    qryCliCtt.SQL.Add('  CLI_TEMSEG,       ');
    qryCliCtt.SQL.Add('  CLI_TEMEMP,       ');
    qryCliCtt.SQL.Add('  CLI_GMUCTT,       ');
    qryCliCtt.SQL.Add('  CLI_ECICTT,       ');
    qryCliCtt.SQL.Add('  CLI_QTDFIL,       ');
    qryCliCtt.SQL.Add('  CLI_CERCTT,       ');
    qryCliCtt.SQL.Add('  CLI_RAMFON,       ');
    qryCliCtt.SQL.Add('  CLI_RAMFAX,       ');
    qryCliCtt.SQL.Add('  CLI_OBSERV        ');
    qryCliCtt.SQL.Add(') VALUES (          ');
    qryCliCtt.SQL.Add('  :CODCLI,          ');
    qryCliCtt.SQL.Add('  :AUTCTT,          ');
    qryCliCtt.SQL.Add('  :NUMCPF,          ');
    qryCliCtt.SQL.Add('  :NUMR_G,          ');
    qryCliCtt.SQL.Add('  :NOMCTT,          ');
    qryCliCtt.SQL.Add('  :ENDCTT,          ');
    qryCliCtt.SQL.Add('  :BAICTT,          ');
    qryCliCtt.SQL.Add('  :CIDCTT,          ');
    qryCliCtt.SQL.Add('  :TELCTT,          ');
    qryCliCtt.SQL.Add('  :CELCTT,          ');
    qryCliCtt.SQL.Add('  :FAXCTT,          ');
    qryCliCtt.SQL.Add('  :DEPCTT,          ');
    qryCliCtt.SQL.Add('  :EMACTT,          ');
    qryCliCtt.SQL.Add('  :CODEMP,          ');
    qryCliCtt.SQL.Add('  :AUTOINCREM,      ');
    qryCliCtt.SQL.Add('  :CGOCTT,          ');
    qryCliCtt.SQL.Add('  :DPTCTT,          ');
    qryCliCtt.SQL.Add('  :NASCTT,          ');
    qryCliCtt.SQL.Add('  :TFUCTT,          ');
    qryCliCtt.SQL.Add('  :HOBCTT,          ');
    qryCliCtt.SQL.Add('  :ESCCTT,          ');
    qryCliCtt.SQL.Add('  :TEMSEG,          ');
    qryCliCtt.SQL.Add('  :TEMEMP,          ');
    qryCliCtt.SQL.Add('  :GMUCTT,          ');
    qryCliCtt.SQL.Add('  :ECICTT,          ');
    qryCliCtt.SQL.Add('  :QTDFIL,          ');
    qryCliCtt.SQL.Add('  :CERCTT,          ');
    qryCliCtt.SQL.Add('  :RAMFON,          ');
    qryCliCtt.SQL.Add('  :RAMFAX,          ');
    qryCliCtt.SQL.Add('  :OBSCTT)          ');
  End Else Begin
    qryCliCtt.SQL.Add('UPDATE CLICTT SET        ');
    qryCliCtt.SQL.Add('  CLI_CODCLI = :CODCLI,  ');
    qryCliCtt.SQL.Add('  CLI_AUTCTT = :AUTCTT,  ');
    qryCliCtt.SQL.Add('  CLI_NUMCPF = :NUMCPF,  ');
    qryCliCtt.SQL.Add('  CLI_NUMR_G = :NUMR_G,  ');
    qryCliCtt.SQL.Add('  CLI_NOMCTT = :NOMCTT,  ');
    qryCliCtt.SQL.Add('  CLI_ENDCTT = :ENDCTT,  ');
    qryCliCtt.SQL.Add('  CLI_BAICTT = :BAICTT,  ');
    qryCliCtt.SQL.Add('  CLI_CIDCTT = :CIDCTT,  ');
    qryCliCtt.SQL.Add('  CLI_TELCTT = :TELCTT,  ');
    qryCliCtt.SQL.Add('  CLI_CELCTT = :CELCTT,  ');
    qryCliCtt.SQL.Add('  CLI_FAXCTT = :FAXCTT,  ');
    qryCliCtt.SQL.Add('  CLI_DEPCTT = :DEPCTT,  ');
    qryCliCtt.SQL.Add('  CLI_EMACTT = :EMACTT,  ');
    qryCliCtt.SQL.Add('  CLI_CODEMP = :CODEMP,  ');
    qryCliCtt.SQL.Add('  CLI_CGOCTT = :CGOCTT,  ');
    qryCliCtt.SQL.Add('  CLI_DPTCTT = :DPTCTT,  ');
    qryCliCtt.SQL.Add('  CLI_NASCTT = :NASCTT,  ');
    qryCliCtt.SQL.Add('  CLI_TFUCTT = :TFUCTT,  ');
    qryCliCtt.SQL.Add('  CLI_HOBCTT = :HOBCTT,  ');
    qryCliCtt.SQL.Add('  CLI_ESCCTT = :ESCCTT,  ');
    qryCliCtt.SQL.Add('  CLI_TEMSEG = :TEMSEG,  ');
    qryCliCtt.SQL.Add('  CLI_TEMEMP = :TEMEMP,  ');
    qryCliCtt.SQL.Add('  CLI_GMUCTT = :GMUCTT,  ');
    qryCliCtt.SQL.Add('  CLI_ECICTT = :ECICTT,  ');
    qryCliCtt.SQL.Add('  CLI_QTDFIL = :QTDFIL,  ');
    qryCliCtt.SQL.Add('  CLI_CERCTT = :CERCTT,  ');
    qryCliCtt.SQL.Add('  CLI_RAMFON = :RAMFON,  ');
    qryCliCtt.SQL.Add('  CLI_RAMFAX = :RAMFAX,  ');
    qryCliCtt.SQL.Add('  CLI_OBSERV = :OBSCTT   ');
    qryCliCtt.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM ');
  End;

  qryCliCtt.ParamByName('CODCLI').AsString := FCodCli;
  qryCliCtt.ParamByName('AUTCTT').AsString := IIF(FAutCtt, 'S', 'N');
  qryCliCtt.ParamByName('NUMCPF').AsString := FCpfCtt;
  qryCliCtt.ParamByName('NUMR_G').AsString := FRg_Ctt;
  qryCliCtt.ParamByName('NOMCTT').AsString := FNomCtt;
  qryCliCtt.ParamByName('ENDCTT').AsString := FEndCtt;
  qryCliCtt.ParamByName('BAICTT').AsString := FBaiCtt;
  qryCliCtt.ParamByName('TELCTT').AsString := FTelCtt;
  qryCliCtt.ParamByName('CELCTT').AsString := FCelCtt;
  qryCliCtt.ParamByName('FAXCTT').AsString := FFaxCtt;
  qryCliCtt.ParamByName('DEPCTT').AsString := FDepCtt;
  qryCliCtt.ParamByName('EMACTT').AsString := FEmaCtt;
  qryCliCtt.ParamByName('CODEMP').AsString := VS_strCodEmp;

  If (Not blnEditar) Then
    FAutoincrem := fRetAutoIncrem('CLICTT', VS_strCodEmp);

  qryCliCtt.ParamByName('AUTOINCREM').AsString := FAutoincrem;

  If fEmptyStr(FCidCtt) Then
    qryCliCtt.ParamByName('CIDCTT').Value := Null
  Else
    qryCliCtt.ParamByName('CIDCTT').AsString := FCidCtt;

  If FCgoCtt <> '' Then
    qryCliCtt.ParamByName('CGOCTT').AsString := FCgoCtt
  Else
    qryCliCtt.ParamByName('CGOCTT').Value := Null;
  If FDptCtt <> '' Then
    qryCliCtt.ParamByName('DPTCTT').AsString := FDptCtt
  Else
    qryCliCtt.ParamByName('DPTCTT').Value := Null;
  If FNasCtt > 0 Then
    qryCliCtt.ParamByName('NASCTT').AsDateTime := FNasCtt
  Else
    qryCliCtt.ParamByName('NASCTT').Value := Null;
  If FTfuCtt <> '' Then
    qryCliCtt.ParamByName('TFUCTT').AsString := FTfuCtt
  Else
    qryCliCtt.ParamByName('TFUCTT').Value := Null;
  If FHobCtt <> '' Then
    qryCliCtt.ParamByName('HOBCTT').AsString := FHobCtt
  Else
    qryCliCtt.ParamByName('HOBCTT').Value := Null;
  If FEscCtt <> '' Then
    qryCliCtt.ParamByName('ESCCTT').AsString := FEscCtt
  Else
    qryCliCtt.ParamByName('ESCCTT').Value := Null;
  qryCliCtt.ParamByName('TEMSEG').AsString := FTemSeg;
  qryCliCtt.ParamByName('TEMEMP').AsString := FTemEmp;
  If FGmuCtt <> '' Then
    qryCliCtt.ParamByName('GMUCTT').AsString := FGmuCtt
  Else
    qryCliCtt.ParamByName('GMUCTT').Value := Null;
  If FEciCtt <> '' Then
    qryCliCtt.ParamByName('ECICTT').AsString := FEciCtt
  Else
    qryCliCtt.ParamByName('ECICTT').Value := Null;
  qryCliCtt.ParamByName('QTDFIL').AsInteger := FQtdFil;
  qryCliCtt.ParamByName('CERCTT').AsString  := FCerCtt;
  qryCliCtt.ParamByName('OBSCTT').AsString  := FObsCtt;

  If fEmptyStr(FRamFon) Then
    qryCliCtt.ParamByName('RAMFON').Value := Null
  Else
    qryCliCtt.ParamByName('RAMFON').AsString := FRamFon;

  If fEmptyStr(FRamFax) Then
    qryCliCtt.ParamByName('RAMFAX').Value := Null
  Else
    qryCliCtt.ParamByName('RAMFAX').AsString := FRamFax;

  qryCliCtt.ExecSQL;
  qryCliCtt.Close;
end;

procedure TCliCtt.pZeraValores;
begin
  FCodCli := '';
  FAutCtt := True;
  FCpfCtt := '';
  FRg_Ctt := '';
  FNomCtt := '';
  FEndCtt := '';
  FBaiCtt := '';
  FCidCtt := '';
  FNomCid := '';
  FEstado := '';
  FTelCtt := '';
  FCelCtt := '';
  FFaxCtt := '';
  FDepCtt := '';
  FEmaCtt := '';
  FCgoCtt := '';
  FDptCtt := '';
  FNasCtt := 0;
  FTfuCtt := '';
  FHobCtt := '';
  FEscCtt := '';
  FTemSeg := '';
  FTemEmp := '';
  FGmuCtt := '';
  FEciCtt := '';
  FQtdFil := 0;
  FCerCtt := '';
  FObsCtt := '';
  FExcluir := False;
  FAutoincrem := '';
  FRamFon := '';
  FRamFax := '';
end;

procedure TCliCtt.setAutCtt(const Value: Boolean);
begin
  FAutCtt := Value;
end;

procedure TCliCtt.setBaiCtt(const Value: String);
begin
  If (FBaiCtt <> Value) Then
    FBaiCtt := Value;
end;

procedure TCliCtt.setCidCtt(const Value: String);
begin
  FNomCid := fRetNomCidade(Value);
  If (fEmptyStr(FNomCid)) And (Not fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('Essa cidade não está cadastrada!');

  FEstado := fRetNomCidade(Value, 1);

  If (FCidCtt <> Value) Then
    FCidCtt := Value;
end;

procedure TCliCtt.setCodCli(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O Cliente deve ser preenchido!');
  Try
  If (FCodCli <> Value) Then
    FCodCli := Value;
  Except
    On E: Exception Do
      pMensagensErro('Value: ' + Value + ' FCodCli: ' + FCodCli + ' - ' + E.Message, '');
  End;
end;

procedure TCliCtt.setCpfCtt(const Value: String);
begin
  If fCfgSis('AUTCTT', VarBoolean) Then
  Begin
    If (Pos(fCfgSis('DOCCLI'), '1_3_') > 0) Then
    Begin
      If (fEmptyStr(Value)) Then
      Begin
        If (FAutCtt) Then
          Raise ExceptionAutCom.Create('O CPF deve ser preenchido!');
      End;
    End;

    If (Not fEmptyStr(Value)) And ((fStringRepetida(Value)) Or (Not fValidaCnpjCpf(Value, False))) Then
    Begin
      Raise ExceptionAutCom.Create('Não é um número de CPF válido!');
    End;
  End;

  FCpfCtt := Value;
end;

procedure TCliCtt.setEciCtt(const Value: String);
begin
  If Not fEmptyStr(Value) Then
  Begin
    FNomEci := fRetNomEstadoCivil(Value);

    If (fEmptyStr(FNomEci)) Then
      Raise ExceptionAutCom.Create('Esse Estado Civil não está cadastrado!');
  End;

  If (FEciCtt <> Value) Then
    FEciCtt := Value;
end;

procedure TCliCtt.setEmaCtt(const Value: String);
begin
  If (FEmaCtt <> Value) Then
    FEmaCtt := Value;
end;

procedure TCliCtt.setEndCtt(const Value: String);
begin
  If (FEndCtt <> Value) Then
    FEndCtt := Value;
end;

procedure TCliCtt.setEscCtt(const Value: String);
begin
  If Not fEmptyStr(Value) Then
  Begin
    FNomEsc := fRetNomEscolaridade(Value);

    If (fEmptyStr(FNomEsc)) Then
      Raise ExceptionAutCom.Create('Essa Escolaridade não está cadastrada!');
  End;

  If (FEscCtt <> Value) Then
    FEscCtt := Value;
end;

procedure TCliCtt.setNasCtt(const Value: TDateTime);
begin
  If (FNasCtt <> Value) Then
    FNasCtt := Value;
end;

procedure TCliCtt.setNomCtt(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O Nome deve ser preenchido!');

  If (FNomCtt <> Value) Then
    FNomCtt := Value;
end;

procedure TCliCtt.setObsCtt(const Value: String);
begin
  If (FObsCtt <> Value) Then
    FObsCtt := Value;
end;

procedure TCliCtt.setQtdFil(const Value: Integer);
begin
  If (FQtdFil <> Value) Then
    FQtdFil := Value;
end;

procedure TCliCtt.setRamFax(const Value: String);
begin
  If (FRamFax <> Value) Then
    FRamFax := Value;
end;

procedure TCliCtt.setRamFon(const Value: String);
begin
  If (FRamFon <> Value) Then
    FRamFon := Value;
end;

procedure TCliCtt.setRg_Ctt(const Value: String);
begin
  If fCfgSis('AUTCTT', VarBoolean) Then
  Begin
    If (Pos(fCfgSis('DOCCLI'), '1_4_') > 0) Then
    Begin
      If (fEmptyStr(Value)) Then
      Begin
        If FAutCtt Then
          Raise ExceptionAutCom.Create('O RG deve ser preenchido!');
      End;
    End;
  End;
  FRg_Ctt := Value;
end;

procedure TCliCtt.setTelCtt(const Value: String);
begin
  If (FTelCtt <> Value) Then
    FTelCtt := Value;
end;

procedure TCliCtt.setTemEmp(const Value: String);
begin
  If (FTemEmp <> Value) Then
    FTemEmp := Value;
end;

procedure TCliCtt.setTemSeg(const Value: String);
begin
  If (FTemSeg <> Value) Then
    FTemSeg := Value;
end;

procedure TCliCtt.setTfuCtt(const Value: String);
begin
  If Not fEmptyStr(Value) Then
  Begin
    FNomTfu := fRetNomTimeFutebol(Value);

    If (fEmptyStr(FNomTfu)) Then
      Raise ExceptionAutCom.Create('Esse Time de Futebol não está cadastrado!');
  End;

  If (FTfuCtt <> Value) Then
    FTfuCtt := Value;
end;

{procedure TCliCtt.setTelCtt(const Value: String);
begin
  If (FTelCtt <> Value) Then
    FTelCtt := Value;
end;
}
procedure TCliCtt.setCelCtt(const Value: String);
begin
  If (FCelCtt <> Value) Then
    FCelCtt := Value;
end;

procedure TCliCtt.setCerCtt(const Value: String);
begin
  If (FCerCtt <> Value) Then
    FCerCtt := Value;
end;

procedure TCliCtt.setCgoCtt(const Value: String);
begin
  If Not fEmptyStr(Value) Then
  Begin
    FNomCgo := fRetNomCargo(Value);

    If (fEmptyStr(FNomCgo)) Then
      Raise ExceptionAutCom.Create('Esse Cargo não está cadastrado!');
  End;

  If (FCgoCtt <> Value) Then
    FCgoCtt := Value;
end;

procedure TCliCtt.setFaxCtt(const Value: String);
begin
  If (FFaxCtt <> Value) Then
    FFaxCtt := Value;
end;

procedure TCliCtt.setGmuCtt(const Value: String);
begin
  If Not fEmptyStr(Value) Then
  Begin
    FNomGmu := fRetNomGostoMusical(Value);

    If (fEmptyStr(FNomGmu)) Then
      Raise ExceptionAutCom.Create('Esse Gosto Musical não está cadastrado!');
  End;

  If (FGmuCtt <> Value) Then
    FGmuCtt := Value;
end;

procedure TCliCtt.setHobCtt(const Value: String);
begin
  If Not fEmptyStr(Value) Then
  Begin
    FNomHob := fRetNomHobby(Value);

    If (fEmptyStr(FNomHob)) Then
      Raise ExceptionAutCom.Create('Esse Hobby não está cadastrado!');
  End;

  If (FHobCtt <> Value) Then
    FHobCtt := Value;
end;

procedure TCliCtt.setIdCiDe(const Value: Extended);
begin
  FIdCiDe := Value;
end;

procedure TCliCtt.setDepCtt(const Value: String);
begin
  If (FDepCtt <> Value) Then
    FDepCtt := Value;
end;

procedure TCliCtt.setDptCtt(const Value: String);
begin
  If Not fEmptyStr(Value) Then
  Begin
    FNomDpt := fRetNomDepartamentoCliCon(Value);

    If (fEmptyStr(FNomDpt)) Then
      Raise ExceptionAutCom.Create('Esse Departamento não está cadastrado!');
  End;

  If (FDptCtt <> Value) Then
    FDptCtt := Value;
end;

end.

