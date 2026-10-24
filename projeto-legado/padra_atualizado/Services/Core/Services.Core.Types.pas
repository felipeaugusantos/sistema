unit Services.Core.Types;

interface

uses
  Datasnap.Provider, Datasnap.DBClient, System.SysUtils, Data.DB,
  untTypesSistema, System.Classes;

type
  TUniClientDataSet = class(TClientDataSet);
  TUniDataSetProvider = class(TDataSetProvider);

type
  TBitBtnLocked = class(TComponent);

type
  ExceptionAutCom = Exception;

type
  TDefCampos = Record
    strNomCam: String;
    strDesCri: String;
    ftpTipCam: TFieldType;
    intTamCam: Integer;
    blnVisible: Boolean;
    strFormat: String;
  end;

type
  TArrDefCam = Array Of TDefCampos;

type
  TcxProgressBar = class
  private type
    TProperties = record
      Max: Double;
      Min: Double;
      Text: String;
    end;
  public
    Properties: TProperties;
    Position: Double;
    Visible: Boolean;
  end;

type
  TApplication = class sealed(TComponent)
  private
    FExeName: String;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ProcessMessages;
    property ExeName: string read FExeName;
  end;

type
  TForm = class sealed(TComponent)
  end;

type
  TfConsulta = function(): Boolean of object;
  TfCriarConfiguracoes = reference to function(strCamCfg, strCodEmp: string): Boolean;

type
  TImprimeImpFatTin = procedure() of object;

type
  IArredondaParcela = Interface
    ['{2496AA89-B1E5-49F7-842A-EAFED44C2BE2}']
    procedure pArredondaParcela(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
  End;

var
  Application: TApplication;

implementation

{ Application }

constructor TApplication.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FExeName := System.SysUtils.GetModuleName(HInstance);
end;

procedure TApplication.ProcessMessages;
begin
  //do nothing
end;

initialization

Application := TApplication.Create(nil);

finalization

FreeAndNil(Application);

end.
