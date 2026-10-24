unit untNCMModel;

interface

uses
   Classes;

type
   TNCMModel = class(TPersistent)
   private
      FStrAutInc,
      FStrCodNCM,
      FStrDescri,
      FStrCodExc,
      FStrCodTra,
      FStrAnvObr: String;
      FFltAlqIPI: Double;
   public
      constructor Create;
   published
      property strAutInc: String read FStrAutInc write FStrAutInc;
      property strCodNCM: String read FStrCodNCM write FStrCodNCM;
      property strDescri: String read FStrDescri write FStrDescri;
      property strCodExc: String read FStrCodExc write FStrCodExc;
      property strCodTra: String read FStrCodTra write FStrCodTra;
      property strAnvObr: String read FStrAnvObr write FStrAnvObr;
      property strAlqIPI: Double read FFltAlqIPI write FFltAlqIPI;
   end;

implementation

constructor TNCMModel.Create;
begin
  Self.FStrAutInc := '';
  Self.FStrCodNCM := '';
  Self.FStrDescri := '';
  Self.FStrCodExc := '';
  Self.FStrCodTra := '';
  Self.FStrAnvObr := '';
  Self.FFltAlqIPI := 0;
end;

end.
