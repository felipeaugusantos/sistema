unit untCadUniLocalizavel;

interface

uses
  untILocalizavel, EditFocus, DB;

type
  TCadUniLocalizavel = class(TInterfacedObject, ILocalizavel)
  private
    edtCodUni: TEditFocus;
    edtDesUni: TEditFocus;
    edtSigUni: TEditFocus;
  public
    procedure OnLocalizado(qryDados: TDataSet);
  public
    constructor Create(edtCodUni, edtDesUni, edtSigUni: TEditFocus);
    destructor Destroy; override;
  end;

implementation

{ TCadUniLocalizavel }

constructor TCadUniLocalizavel.Create(edtCodUni, edtDesUni, edtSigUni: TEditFocus);
begin
  inherited Create();
  Self.edtCodUni := edtCodUni;
  Self.edtDesUni := edtDesUni;
  Self.edtSigUni := edtSigUni;
end;

destructor TCadUniLocalizavel.Destroy;
begin

  inherited;
end;

procedure TCadUniLocalizavel.OnLocalizado(qryDados: TDataSet);
begin
  edtCodUni.Text := qryDados.FieldByName('UNI_CODUNI').AsString;
  edtDesUni.Text := qryDados.FieldByName('UNI_DESUNI').AsString;
  edtSigUni.Text := qryDados.FieldByName('UNI_SIGUNI').AsString;
end;

end.
