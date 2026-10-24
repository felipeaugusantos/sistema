unit untTriSer;

interface

uses untZClient, Classes, SysUtils, Data.DB;

Type
  TTriSer = Class(TZClient)
  Private
    FCodSer : String;
    function fGetSql : String;
    procedure pCarregaTributos(strCodSer : String);
  Public
    procedure pAbreCadastro(strCodSer : String);
    procedure pGravaRegistro(strCodCid, strCdlsse, strTriMun : String);
    function  fPreparaParaSalvar(strCodSer : String):Boolean;

    Constructor Create(AOwner : TComponent); Overload;
  Published

  End;

implementation

{ TTriSer }

uses untFuncoesSimples, untCadTriSer;

constructor TTriSer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, fGetSql);
end;

function TTriSer.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT TRISER.AUTOINCREM, ';
  Result := Result + '        TSE_CODSER, ';
  Result := Result + '        TSE_CODCID, ';
  Result := Result + '        TSE_CDLSSE, ';
  Result := Result + '        TSE_TRIMUN, ';
  Result := Result + '        CID_NOMCID, ';
  Result := Result + '        CID_ESTADO  ';
  Result := Result + ' FROM TRISER        ';
  Result := Result + ' INNER JOIN CADCID ON CID_CODCID = TSE_CODCID ';
  Result := Result + ' WHERE TSE_CODSER = :CODSER ';

end;


function TTriSer.fPreparaParaSalvar(strCodSer: String): Boolean;
begin
  Result := True;

  Self.Active := true;

  if fEmptyStr(FCodSer) then
  Begin
    Try
      Self.DisableControls;
      Self.First;
      while not Self.Eof do
      Begin
        Self.Edit;
        Self.FieldByName('TSE_CODSER').AsString := strCodSer;
        Self.Post;
        Self.Next;
      End;

    Finally
      Self.EnableControls;
    End;
  End;

end;

procedure TTriSer.pAbreCadastro(strCodSer: String);
var
  frmCadTriSer: TfrmCadTriSer;
begin
  FCodSer := strCodSer;
  if IsEmpty then
    pCarregaTributos(strCodSer);

  Try
    pCriarFormularios(TfrmCadTriSer, frmCadTriSer);
    frmCadTriSer.objTriSer := Self;
    frmCadTriSer.Caption := 'Tributação do Serviço: ' + strCodSer + ' - ' + fRetNomeServico(strCodSer);
    frmCadTriSer.ShowModal;
  Finally
    FreeAndNil(frmCadTriSer);
  End;

end;

procedure TTriSer.pCarregaTributos(strCodSer: String);
begin
  Self.Close;
  Self.qryQuery.ParamByName('CODSER').AsString := strCodSer;
  Self.fAbreClient(True, 'TTriSer.pCarregaTributos');

  pSetaClient(Self);

end;

procedure TTriSer.pGravaRegistro(strCodCid, strCdlsse, strTriMun: String);
begin
  if self.Locate('TSE_CODCID', strCodCid, []) Then
    Self.Edit
  Else
  Begin
    Self.Insert;
    Self.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('TRISER', vs_strCodEmp);
  End;

  Self.FieldByName('TSE_CODSER').AsString := FCodSer;
  Self.FieldByName('TSE_CODCID').AsString := strCodCid;
  Self.FieldByName('TSE_CDLSSE').AsString := strCdlsse;
  Self.FieldByName('TSE_TRIMUN').AsString := strTriMun;
  Self.FieldByName('CID_NOMCID').AsString := fRetNomCidade(strCodCid);
  Self.FieldByName('CID_ESTADO').AsString := fRetNomCidade(strCodCid,1);
  Self.Post;

end;

end.
